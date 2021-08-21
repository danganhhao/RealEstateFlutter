import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/constants/colors.dart';
import 'package:real_estate/constants/dimens.dart';
import 'package:real_estate/data/bloc/base_state.dart';
import 'package:real_estate/data/bloc/content_bloc/content_bloc.dart';
import 'package:real_estate/data/bloc/content_bloc/content_event.dart';
import 'package:real_estate/data/bloc/search_bloc/search_bloc.dart';
import 'package:real_estate/data/bloc/search_bloc/search_event.dart';
import 'package:real_estate/data/models/city_info/city_info.dart';
import 'package:real_estate/data/models/search_engine/entity/post.dart';
import 'package:real_estate/data/models/search_engine/request/search_request.dart';
import 'package:real_estate/ui/home/grid_city.dart';
import 'package:real_estate/ui/home/news_widget.dart';
import 'package:real_estate/ui/home/post_card.dart';
import 'package:real_estate/ui/home/title_with_more_btn.dart';
import 'package:real_estate/ui/search/search_result.dart';
import 'package:real_estate/utils/snackbar/snackbar.dart';
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
    BlocProvider.of<SearchBloc>(context).add(GetSearchEvent(data: SearchRequest(), page: 1));
    BlocProvider.of<ContentBloc>(context).add(GetCityInfoEvent());
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
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(),
          Image.asset(
            "assets/icons/logo.png",
            height: 100,
          ),
          Container()
        ],
      ),
    );
  }

  Widget _buildBody() {
    Size size = MediaQuery.of(context).size;
    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<SearchBloc>(context).add(GetSearchEvent(data: SearchRequest(), page: 1));
        BlocProvider.of<ContentBloc>(context).add(GetCityInfoEvent());
      },
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            const HeaderSearchBoxWidget(),
            _buildRecommend(size),
            _buildRecommend(size),
            _buildCityWidget(size),
            _buildNews(size)
          ],
        ),
      ),
    );
  }

  BlocConsumer<SearchBloc, Object?> _buildRecommend(Size size) {
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
    return post.result != null
        ? Column(
            children: [
              TitleWithMoreBtn(
                  title: "Recommend",
                  press: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SearchResult(
                                data: SearchRequest())));
                  }),
              SizedBox(
                  height: size.width * 0.6,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: post.result!.length,
                    itemBuilder: (context, index) {
                      return PostCard(
                        item: post.result![index],
                        press: () {
                          Snackbar.show(context, "Press!");
                        },
                      );
                    },
                  )),
            ],
          )
        : Container();
  }

  BlocConsumer<ContentBloc, BaseState> _buildCityWidget(Size size) {
    return BlocConsumer(
      bloc: BlocProvider.of<ContentBloc>(context),
      listener: (context, state) {
        if (state is BaseError) {
          // Todo: Error here
        }
      },
      builder: (context, state) {
        if (state is BaseInitial || state is BaseLoading) {
          return Container();
        } else if (state is BaseLoaded) {
          if (state.data is CityInfo) {
            CityInfo? data = (state.data as CityInfo?);
            if (data != null) {
              return GridCityWidget(data: data, press: _cityPress);
            }
          }
        }
        return Container();
      },
    );
  }

  void _cityPress(CityItem item) {
    Snackbar.show(context, item.name ?? "");
  }

  Widget _buildNews(Size size) {
    List<String> links = [
      "https://batdongsan.com.vn/phan-tich-nhan-dinh/kho-phan-doan-thoi-diem-phuc-hoi-cua-thi-truong-bat-dong-san-ar107284",
      "https://batdongsan.com.vn/phan-tich-nhan-dinh/kho-phan-doan-thoi-diem-phuc-hoi-cua-thi-truong-bat-dong-san-ar107284",
      "https://batdongsan.com.vn/phan-tich-nhan-dinh/kho-phan-doan-thoi-diem-phuc-hoi-cua-thi-truong-bat-dong-san-ar107284",
      "https://batdongsan.com.vn/phan-tich-nhan-dinh/kho-phan-doan-thoi-diem-phuc-hoi-cua-thi-truong-bat-dong-san-ar107284",
      "https://batdongsan.com.vn/phan-tich-nhan-dinh/kho-phan-doan-thoi-diem-phuc-hoi-cua-thi-truong-bat-dong-san-ar107284",
    ];
    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: Dimens.default_padding),
          child: Row(
            children: const [TitleWithCustomUnderline(text: "News"), Spacer()],
          ),
        ),
        SizedBox(
          height: size.width * 0.4,
          child: ListView.builder(
              itemCount: links.length,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (context, index) => NewsWidget(link: links[index])),
        )
      ],
    );
  }

  Widget _buildLoading() => const CustomProgressIndicatorWidget();
}
