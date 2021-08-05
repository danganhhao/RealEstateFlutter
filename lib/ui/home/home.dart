import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/data/bloc/base_state.dart';
import 'package:real_estate/data/bloc/search_bloc/search_bloc.dart';
import 'package:real_estate/data/bloc/search_bloc/search_event.dart';
import 'package:real_estate/data/bloc/user_bloc/user_bloc.dart';
import 'package:real_estate/data/bloc/user_bloc/user_event.dart';
import 'package:real_estate/data/models/search_engine/entity/post.dart';
import 'package:real_estate/data/models/user/user.dart';
import 'package:real_estate/data/models/user/user_list.dart';
import 'package:real_estate/widgets/error_widget.dart';
import 'package:real_estate/widgets/progress_indicator_widget.dart';

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
      appBar: AppBar(title: Center(child: Text("Real Estate"))),
      body: _buildHome(),
    );
  }

  Widget _buildHome() {
    return RefreshIndicator(
      onRefresh: () async {},
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            BlocConsumer(
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
                      return _buildLane(data);
                    }
                  }
                }
                return const NetworkErrorWidget();
              },
            ),
            BlocConsumer(
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
                      return _buildLane(data);
                    }
                  }
                }
                return const NetworkErrorWidget();
              },
            ),
            BlocConsumer(
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
                      return _buildLane(data);
                    }
                  }
                }
                return const NetworkErrorWidget();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _home(Post post) {
    return post.result != null
        ? SizedBox(
            height: 300,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                // shrinkWrap: true,
                itemCount: post.result?.length,
                itemBuilder: (context, index) {
                  return Text(post.result![index].title ?? "");
                }),
          )
        : Container();
  }

  Widget _buildLane(Post post) {
    return post.result != null
        ? SizedBox(
            height: 220,
            child: Column(
              children: [
                Row(
                  children: const [
                    Icon(
                      Icons.label_important_outline,
                      color: Colors.blue,
                    ),
                    Text(
                      "Tin rao nổi bật",
                      style: TextStyle(fontSize: 24, color: Colors.blue),
                    )
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(top: 10),
                  height: 190,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: post.result?.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.all(5),
                          child: Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 0.5,
                                  blurRadius: 2,
                                  offset: const Offset(2, 2), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Stack(
                              children: [
                                // Card(
                                //   elevation: 4.0,
                                //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                //   clipBehavior: Clip.antiAlias,
                                //   child: Column(
                                //     mainAxisAlignment: MainAxisAlignment.start,
                                //     children: <Widget>[
                                //       FadeInImage.assetNetwork(
                                //         alignment: Alignment.topCenter,
                                //         placeholder: '',
                                //         image: post.result![index].images![0].image ?? "",
                                //         fit: BoxFit.fill,
                                //         width: double.maxFinite,
                                //         height: 150,
                                //       ),
                                //     ],
                                //   ),
                                // ),
                                FadeInImage.assetNetwork(
                                  alignment: Alignment.topCenter,
                                  placeholder: '',
                                  fit: BoxFit.scaleDown,
                                  width: 150,
                                  height: 150,
                                  image: post.result![index].images![0].image ?? "",
                                ),
                                Text("AAA"),
                                Icon(Icons.label_important_outline)
                              ],
                            ),
                          ),
                        );
                        // return Text(post.result![index].title ?? "");
                      }),
                ),
              ],
            ),
          )
        : Container();
  }

  Widget _buildLoading() => const CustomProgressIndicatorWidget();
}
