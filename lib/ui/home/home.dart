import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/data/bloc/base_state.dart';
import 'package:real_estate/data/bloc/user_bloc/user_bloc.dart';
import 'package:real_estate/data/bloc/user_bloc/user_event.dart';
import 'package:real_estate/data/models/user/user.dart';
import 'package:real_estate/data/models/user/user_list.dart';
import 'package:real_estate/data/network/repository/user_repository.dart';
import 'package:real_estate/di/components/service_locator.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final UserBloc _userBloc = UserBloc(getIt<UserRepository>());

  @override
  void initState() {
    _userBloc.add(GetUserEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('COVID-19 List')),
      body: _buildListUser(),
    );
  }

  Widget _buildListUser() {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: BlocProvider(
        create: (_) => _userBloc,
        child: BlocListener<UserBloc, BaseState>(
          listener: (context, state) {
            if (state is BaseError) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          child: BlocBuilder<UserBloc, BaseState>(
            builder: (context, state) {
              if (state is BaseInitial) {
                return _buildLoading();
              } else if (state is BaseLoading) {
                return _buildLoading();
              } else if (state is BaseLoaded) {
                print('xxxx');
                if (state.props.isNotEmpty){
                  if (state.props[0] is UserList) {
                    List<User>? data = (state.props[0] as UserList).users;
                    if (data != null ) {
                      print(data);
                      return _buildListView(data);
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

  Widget _buildLoading() => Center(child: CircularProgressIndicator());

  Widget _buildListView(List<User> data) => ListView.builder(
    itemCount: data.length,
      itemBuilder: (user, index) {
        return Text(data[index].name ?? "");
      });
}
