import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/constants/colors.dart';
import 'package:real_estate/data/bloc/base_state.dart';
import 'package:real_estate/data/bloc/content_bloc/content_bloc.dart';
import 'package:real_estate/data/bloc/content_bloc/content_event.dart';
import 'package:real_estate/data/models/estate_type/estate_type.dart';
import 'package:real_estate/data/models/search_engine/request/search_request.dart';
import 'package:real_estate/di/components/service_locator.dart';
import 'package:real_estate/ui/search/search_result.dart';
import 'package:real_estate/utils/app_utils.dart';
import 'package:real_estate/widgets/error_widget.dart';
import 'package:real_estate/widgets/progress_indicator_widget.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ContentBloc>(),
      child: const _Category(),
    );
  }
}

class _Category extends StatefulWidget {
  const _Category({Key? key}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<_Category> {
  @override
  void initState() {
    BlocProvider.of<ContentBloc>(context).add(GetEstateTypeEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text("Category"))),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<ContentBloc>(context).add(GetEstateTypeEvent());
      },
      child: _buildBlocCategories(),
    );
  }

  Widget _buildBlocCategories() {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer(
        bloc: BlocProvider.of<ContentBloc>(context),
        listener: (context, state) {},
        builder: (context, state) {
          if (state is BaseInitial || state is BaseLoading) {
            return const Center(
              child: CustomProgressIndicatorWidget(),
            );
          } else if (state is BaseLoaded) {
            if (state.data is List<EstateType>) {
              List<EstateType> data = (state.data as List<EstateType>);
              return _buildGridCategory(data, size);
            }
          }
          return const NetworkErrorWidget();
        });
  }

  Widget _buildGridCategory(List<EstateType> data, Size size) {
    List<Color> _colors = [Colors.white, AppColors.primaryColor];
    List<double> _stops = [0.3, 0.9];
    return Container(
        padding: const EdgeInsets.all(5),
        child: GridView.builder(
            itemCount: data.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: size.width * .5,
                childAspectRatio: 2 / 2,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      SearchResult.route(SearchRequest(
                          estateType: data[index].id.toString())));
                },
                child: Container(
                  padding: const EdgeInsets.all(5),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                            offset: Offset(0, 1),
                            blurRadius: 4,
                            color: Colors.grey)
                      ],
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: _colors,
                        stops: _stops,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  child: Stack(
                    children: [
                      Container(
                          child: Image.asset(
                            AppUtils.instance
                                .getCategoryImageById(data[index].id),
                            fit: BoxFit.fill,
                          ),
                          alignment: Alignment.center),
                      Container(
                        child: Text(data[index].name,
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                        alignment: Alignment.topCenter,
                      )
                    ],
                  ),
                ),
              );
            }));
  }
}
