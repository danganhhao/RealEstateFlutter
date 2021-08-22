import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/data/bloc/base_state.dart';
import 'package:real_estate/data/bloc/content_bloc/content_bloc.dart';
import 'package:real_estate/data/bloc/search_bloc/search_bloc.dart';
import 'package:real_estate/data/bloc/search_bloc/search_event.dart';
import 'package:real_estate/data/models/search_engine/entity/post.dart';
import 'package:real_estate/data/models/search_engine/request/search_request.dart';
import 'package:real_estate/di/components/service_locator.dart';
import 'package:real_estate/ui/search/search_post_item.dart';
import 'package:real_estate/widgets/error_widget.dart';
import 'package:real_estate/widgets/progress_indicator_widget.dart';
import 'package:real_estate/data/extensions/list_extension.dart';
import 'package:real_estate/data/extensions/string_extension.dart';


class SearchResult extends StatelessWidget {
  final SearchRequest data;

  const SearchResult({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<SearchBloc>()),
        BlocProvider(create: (_) => getIt<ContentBloc>()),
      ],
      child: _SearchResult(data: data,),
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
    BlocProvider.of<SearchBloc>(context).add(GetSearchEvent(data: data, page: page));
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
              totalPage = int.parse(data.totalPage.orEmpty());
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

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (page <= totalPage && maxScroll - currentScroll <= _scrollThreshold) {
      BlocProvider.of<SearchBloc>(context)
          .add(GetSearchEvent(data: data, page: ++page));
    }
  }
}
