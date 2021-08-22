import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/constants/colors.dart';
import 'package:real_estate/constants/dimens.dart';
import 'package:real_estate/data/bloc/base_state.dart';
import 'package:real_estate/data/bloc/content_bloc/content_bloc.dart';
import 'package:real_estate/data/bloc/content_bloc/content_event.dart';
import 'package:real_estate/data/bloc/search_bloc/search_bloc.dart';
import 'package:real_estate/data/models/estate_type/estate_type.dart';
import 'package:real_estate/data/models/location/base_location.dart';
import 'package:real_estate/data/models/location/district.dart';
import 'package:real_estate/data/models/location/province.dart';
import 'package:real_estate/data/models/location/ward.dart';
import 'package:real_estate/data/models/search_engine/request/search_request.dart';
import 'package:real_estate/di/components/service_locator.dart';
import 'package:real_estate/ui/search/search_result.dart';
import 'package:real_estate/utils/routes/routes.dart';
import 'package:real_estate/widgets/error_widget.dart';
import 'package:real_estate/widgets/progress_indicator_widget.dart';


class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<SearchBloc>()),
        BlocProvider(create: (_) => getIt<ContentBloc>()),
      ],
      child: _Search(),
    );
  }
}

class _Search extends StatefulWidget {

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<_Search> {
  TextEditingController searchController = TextEditingController();
  bool _isShowOptions = false;
  String _provinceId = "";
  String _districtId = "";
  String _wardId = "";
  String _estateTypeId = "";
  List optionsHint = ["Province", "District", "Ward", "Estate type"];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Center(child: Text("Search"))),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              _buildSearchBox(),
              _buildTitleOptions(),
              _buildSearchOptions(),
              _buildClearOptions(),
              Center(
                child: ElevatedButton(
                    child: const Text('Search'),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchResult(
                                  data: SearchRequest(
                                      keyword: searchController.text,
                                      province: _provinceId,
                                      district: _districtId,
                                      ward: _wardId,
                                      estateType: _estateTypeId))));
                    },
                    style: ElevatedButton.styleFrom(
                        primary: AppColors.primaryColor)),
              )
            ],
          ),
        ));
  }

  InkWell _buildTitleOptions() {
    return InkWell(
        onTap: () {
          setState(() {
            _isShowOptions = !_isShowOptions;
          });
        },
        child: Container(
          margin: const EdgeInsets.symmetric(
              horizontal: Dimens.default_padding * .5,
              vertical: Dimens.default_padding * .5),
          alignment: Alignment.centerLeft,
          child: const Text(
            "Options",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ));
  }

  Widget _buildClearOptions() {
    return _isShowOptions == true ? InkWell(
        onTap: () {
          setState(() {
            _provinceId = "";
            _districtId = "";
            _wardId = "";
            _estateTypeId = "";
            setState(() {
              optionsHint[0] = "Province";
              optionsHint[1] = "District";
              optionsHint[2] = "Ward";
              optionsHint[3] = "Estate type";
            });
          });
        },
        child: Container(
          margin: const EdgeInsets.symmetric(
              horizontal: Dimens.default_padding * .5,
              vertical: Dimens.default_padding * .5),
          alignment: Alignment.centerRight,
          child: const Text(
            "Clear",
            style: TextStyle(fontSize:16, fontStyle: FontStyle.normal, color: Colors.red),
          ),
        )): Container();
  }

  Widget _buildSearchBox() {
    return Container(
      margin: const EdgeInsets.all(Dimens.default_padding * .5),
      padding: const EdgeInsets.symmetric(horizontal: Dimens.default_padding),
      height: 45,
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.23),
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Search",
                hintStyle:
                    TextStyle(color: AppColors.primaryColor.withOpacity(0.5)),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
            flex: 1,
          ),
          const Icon(Icons.search, color: AppColors.primaryColor)
        ],
      ),
    );
  }

  Widget _buildSearchOptions() {
    Map<int, String> options = {};
    options[0] = "Province";
    options[1] = "District";
    options[2] = "Ward";
    options[3] = "Estate type";
    return _isShowOptions == true
        ? ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: options.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: Dimens.default_padding * .5),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        options[index] ?? "",
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor),
                      )),
                  InkWell(
                    onTap: () {
                      if (index == 0) {
                        BlocProvider.of<ContentBloc>(context)
                            .add(GetProvinceEvent());
                        _selectBottomSheet();
                      } else if (index == 1 && _provinceId.isNotEmpty) {
                        BlocProvider.of<ContentBloc>(context)
                            .add(GetDistrictEvent(_provinceId));
                        _selectBottomSheet();
                      } else if (index == 2 &&
                          _provinceId.isNotEmpty &&
                          _districtId.isNotEmpty) {
                        BlocProvider.of<ContentBloc>(context)
                            .add(GetWardEvent(_districtId));
                        _selectBottomSheet();
                      } else if (index == 3) {
                        BlocProvider.of<ContentBloc>(context)
                            .add(GetEstateTypeEvent());
                        _selectBottomSheet();
                      }
                    },
                    child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: Dimens.default_padding * .5,
                            vertical: Dimens.default_padding * .25),
                        padding: const EdgeInsets.symmetric(
                            horizontal: Dimens.default_padding * .5),
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.primaryColor)),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(optionsHint[index],
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.black)),
                              flex: 1,
                            ),
                            const Icon(Icons.keyboard_arrow_down,
                                color: Colors.black)
                          ],
                        )),
                  )
                ],
              );
            })
        : Container();
  }

  void _selectBottomSheet() {
    Size size = MediaQuery.of(context).size;
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: Dimens.default_padding * .5,
                    vertical: Dimens.default_padding * .25),
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimens.default_padding * .5),
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.primaryColor)),
                child: const TextField(
                    decoration: InputDecoration(
                  hintText: "Search",
                  hintStyle: TextStyle(color: Colors.black54, fontSize: 14),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                )),
              ),
              BlocBuilder(
                  bloc: BlocProvider.of<ContentBloc>(context),
                  builder: (context, state) {
                    if (state is BaseInitial || state is BaseLoading) {
                      return const Center(
                          child: CustomProgressIndicatorWidget());
                    } else if (state is BaseLoaded) {
                      return _buildList(state.data, size);
                    }
                    return const NetworkErrorWidget();
                  })
            ],
          );
        });
  }

  Widget _buildList(Object data, Size size) {
    if (data is List<BaseLocation>) {
      return Expanded(
          child: SingleChildScrollView(
        child: ListView.builder(
            itemCount: data.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  if (data is List<Province>) {
                    _provinceId = data[index].id.toString();
                    _districtId = "";
                    _wardId = "";
                    setState(() {
                      optionsHint[0] = data[index].name;
                      optionsHint[1] = "District";
                      optionsHint[2] = "Ward";
                    });
                  }
                  if (data is List<District>) {
                    _districtId = data[index].id.toString();
                    _wardId = '';
                    setState(() {
                      optionsHint[1] = data[index].name;
                      optionsHint[2] = "Ward";
                    });
                  }
                  if (data is List<Ward>) {
                    _wardId = data[index].id.toString();
                    setState(() {
                      optionsHint[2] = data[index].name;
                    });
                  }
                  Navigator.of(context).pop();
                },
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Text(data[index].name),
                ),
              );
            }),
      ));
    }
    if (data is List<EstateType>) {
      return Expanded(
          child: SingleChildScrollView(
              child: ListView.builder(
                  itemCount: data.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        if (data is List<EstateType>) {
                          _estateTypeId = data[index].id.toString();
                          setState(() {
                            optionsHint[3] = data[index].name;
                          });
                        }
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Text(data[index].name),
                      ),
                    );
                  })));
    }
    return Container();
  }
}
