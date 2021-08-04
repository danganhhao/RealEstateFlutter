import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/data/bloc/base_state.dart';
import 'package:real_estate/data/bloc/search_bloc/search_bloc.dart';
import 'package:real_estate/data/bloc/search_bloc/search_event.dart';
import 'package:real_estate/data/models/search_engine/entity/post.dart';
// import 'package:real_estate/data/models/user/user.dart';
import 'package:real_estate/data/network/repository/search_repository.dart';
import 'package:real_estate/di/components/service_locator.dart';
import 'package:real_estate/widgets/progress_indicator_widget.dart';

class HomeScreen extends StatefulWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => HomeScreen(),
      );

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final UserBloc _userBloc = UserBloc(getIt<UserRepository>());
  final SearchBloc _searchBloc = SearchBloc(getIt<SearchRepository>());

  @override
  void initState() {
    // _userBloc.add(GetUserEvent());
    _searchBloc.add(GetSearchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Real Estate"))),
      body: _buildHome(),
    );
  }

  Widget _buildHome() {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
      child: BlocProvider(
        create: (_) => _searchBloc,
        child: BlocListener<SearchBloc, BaseState>(
          listener: (context, state) {
            if (state is BaseError) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          child: BlocBuilder<SearchBloc, BaseState>(
            builder: (context, state) {
              if (state is BaseInitial) {
                return _buildLoading();
              } else if (state is BaseLoading) {
                return _buildLoading();
              } else if (state is BaseLoaded) {
                if (state.props.isNotEmpty) {
                  if (state.props[0] is Post) {
                    Post? data = (state.props[0] as Post);
                    if (data != null) {
                      print(data);
                      return _home(data);
                    }
                  }
                }
                return Container();
              } else if (state is BaseError) {
                return Container();
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _home(Post post) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          post.result != null ?
          ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: post.result?.length,
              itemBuilder: (context, index) {
                return Text(post.result![index].title ?? "");
              }) : Container(),
        ],
      ),
    );
  }

  Widget _buildLoading() => CustomProgressIndicatorWidget();

}
