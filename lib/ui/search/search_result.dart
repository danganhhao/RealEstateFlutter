import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/constants/colors.dart';
import 'package:real_estate/data/bloc/base_state.dart';
import 'package:real_estate/data/bloc/content_bloc/content_bloc.dart';
import 'package:real_estate/data/bloc/search_bloc/search_bloc.dart';
import 'package:real_estate/data/bloc/search_bloc/search_event.dart';
import 'package:real_estate/data/models/search_engine/entity/post.dart';
import 'package:real_estate/data/models/search_engine/request/search_request.dart';
import 'package:real_estate/di/components/service_locator.dart';
import 'package:real_estate/ui/search/search_map.dart';
import 'package:real_estate/ui/search/search_post_item.dart';
import 'package:real_estate/widgets/error_widget.dart';
import 'package:real_estate/widgets/progress_indicator_widget.dart';
import 'package:real_estate/data/extensions/list_extension.dart';
import 'package:real_estate/data/extensions/string_extension.dart';

class SearchResult extends StatelessWidget {

  static Route<dynamic> route(SearchRequest data) => MaterialPageRoute(
    builder: (context) => SearchResult(data: data),
  );

  final SearchRequest data;

  const SearchResult({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<SearchBloc>()),
        BlocProvider(create: (_) => getIt<ContentBloc>()),
      ],
      child: _SearchResult(
        data: data,
      ),
    );
  }
}

class _SearchResult extends StatefulWidget {
  final SearchRequest data;

  const _SearchResult({Key? key, required this.data}) : super(key: key);

  @override
  _SearchResultState createState() => _SearchResultState(data: data);
}

class _SearchResultState extends State<_SearchResult> {
  final SearchRequest data;
  final List<PostItem> items = [];
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  int page = 1;
  int totalPage = 0;

  _SearchResultState({required this.data});

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    BlocProvider.of<SearchBloc>(context)
        .add(GetSearchEvent(data: data, page: page));
    super.initState();
  }

  @override
  void dispose() {
    items.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Posts"), centerTitle: true),
        body: _buildBody());
  }

  Widget _buildBody() {
    return Container(
      child: Column(
        children: [_buildSearchOptions(), _buildListPostBloc()],
      ),
    );
  }

  Widget _buildListPostBloc() {
    return BlocBuilder(
        bloc: BlocProvider.of<SearchBloc>(context),
        builder: (context, state) {
          if (state is BaseInitial || state is BaseLoading) {
            return const Center(
              child: CustomProgressIndicatorWidget(),
            );
          } else if (state is BaseLoaded) {
            if (state.data is Post) {
              Post data = (state.data as Post);
              items.addAll(data.result ?? []);
              if (data.totalPage.orEmpty().isNotEmpty) {
                totalPage = int.parse(data.totalPage.orEmpty());
              }
              return _buildListPost();
            }
          }
          return const NetworkErrorWidget();
        });
  }

  Widget _buildListPost() {
    return Expanded(
        child: SingleChildScrollView(
            controller: _scrollController,
            child: ListView.builder(
                itemCount: items.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  if ((index >= items.length - 1)) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return InkWell(
                      onTap: () {},
                      child: SearchPostItem(data: items[index]),
                    );
                  }
                })));
  }

  Widget _buildSearchOptions() {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 50,
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black, width: 1))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: InkWell(
              onTap: () {},
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.sort,
                    color: AppColors.primaryColor,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 5),
                    child: const Text(
                      "Sort",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {},
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.filter_alt,
                    color: AppColors.primaryColor,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 5),
                    child: const Text(
                      "Filter",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                Navigator.push(context, SearchMap.route(items));
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.map,
                    color: AppColors.primaryColor,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 5),
                    child: const Text(
                      "Map",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (page <= totalPage && maxScroll - currentScroll <= _scrollThreshold) {
      BlocProvider.of<SearchBloc>(context)
          .add(GetSearchEvent(data: data, page: ++page));
    }
  }
}
