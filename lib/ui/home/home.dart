import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/data/bloc/base_state.dart';
import 'package:real_estate/data/bloc/search_bloc/search_bloc.dart';
import 'package:real_estate/data/bloc/search_bloc/search_event.dart';
import 'package:real_estate/data/models/search_engine/entity/post.dart';
import 'package:real_estate/ui/home/post_card.dart';
import 'package:real_estate/ui/home/title_with_more_btn.dart';
import 'package:real_estate/widgets/error_widget.dart';
import 'package:real_estate/widgets/progress_indicator_widget.dart';

import 'header.dart';

class HomeScreen extends StatefulWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => HomeScreen(),
      );

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // BlocProvider.of<UserBloc>(context).add(GetUserEvent());
    BlocProvider.of<SearchBloc>(context).add(GetSearchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () {},
      ),
    );
  }

  Widget _buildBody() {
    Size size = MediaQuery.of(context).size;
    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<SearchBloc>(context).add(GetSearchEvent());
      },
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            HeaderSearchBoxWidget(size: size, context: context),
            _blocConsumer(size),
            _blocConsumer(size),
            _blocConsumer(size),

          ],
        ),
      ),
    );
  }

  BlocConsumer<SearchBloc, Object?> _blocConsumer(Size size) {
    return BlocConsumer(
            bloc: BlocProvider.of<SearchBloc>(context),
            listener: (context, state) {
              if (state is BaseError) {
                // Todo: Error here
              }
            },
            builder: (context, state) {
              if (state is BaseInitial || state is BaseLoading) {
                return _buildLoading();
              } else if (state is BaseLoaded) {
                if (state.data is Post) {
                  Post? data = (state.data as Post?);
                  if (data != null) {
                    return _buildLane(data, size);
                  }
                }
              }
              return const NetworkErrorWidget();
            },
          );
  }

  Widget _buildLane(Post post, Size size) {
    return post.result != null ? Column(
      children: [
        TitleWithMoreBtn(title: "Recommend", press: () {}),
        SizedBox(
            height: size.width * 0.6,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: post.result!.length,
              itemBuilder: (context, index) {
                return PostCard(size: size, item: post.result![index]);
              },
            )),
      ],
    ) : Container();
  }
  Widget _buildLoading() => const CustomProgressIndicatorWidget();
}
