import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/constants/colors.dart';
import 'package:real_estate/data/bloc/base_state.dart';
import 'package:real_estate/data/bloc/search_bloc/search_bloc.dart';
import 'package:real_estate/data/bloc/search_bloc/search_event.dart';
import 'package:real_estate/data/models/search_engine/entity/post.dart';
import 'package:real_estate/data/models/search_engine/request/search_request.dart';
import 'package:real_estate/ui/search/search_post_item.dart';
import 'package:real_estate/widgets/error_widget.dart';
import 'package:real_estate/widgets/progress_indicator_widget.dart';

class SearchResult extends StatefulWidget {
  final SearchRequest data;

  const SearchResult({Key? key, required this.data}) : super(key: key);

  @override
  _SearchResultState createState() => _SearchResultState(data: data);
}

class _SearchResultState extends State<SearchResult> {
  final SearchRequest data;
  final List<PostItem> items = [];
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  int page = 1;

  _SearchResultState({required this.data});

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    BlocProvider.of<SearchBloc>(context)
        .add(GetSearchEvent(data: data, page: page));
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
        children: [Text("AAA"), _buildListPostBloc()],
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
              return _buildListPost();
            }
          }
          return const NetworkErrorWidget();
        });
  }

  Widget _buildListPost() {
    Size size = MediaQuery.of(context).size;
    return Expanded(
        child: SingleChildScrollView(
            controller: _scrollController,
            child: ListView.builder(
                itemCount: items.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final title = "${items[index].id}.${items[index].title}";
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

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      BlocProvider.of<SearchBloc>(context)
          .add(GetSearchEvent(data: data, page: ++page));
    }
  }

  @override
  void dispose() {
    items.clear();
    super.dispose();
  }

}
