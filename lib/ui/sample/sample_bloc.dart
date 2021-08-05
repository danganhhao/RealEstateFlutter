// class HomeScreen extends StatefulWidget {
//   static Route<dynamic> route() =>
//       MaterialPageRoute(
//         builder: (context) => HomeScreen(),
//       );
//
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   void initState() {
//     BlocProvider.of<UserBloc>(context).add(GetUserEvent());
//     BlocProvider.of<SearchBloc>(context).add(GetSearchEvent());
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Center(child: Text("Real Estate"))),
//       body: _buildHome(),
//     );
//   }
//
//   Widget _buildHome() {
//     return SingleChildScrollView(
//       scrollDirection: Axis.vertical,
//       child: Column(
//         children: [
//           BlocBuilder<UserBloc, BaseState>(
//             builder: (context, state) {
//               if (state is BaseLoaded) {
//                 if (state.data is UserList) {
//                   return _buildUser((state.data as UserList).users);
//                 }
//               }
//               return Container();
//             },
//           ),
//           BlocConsumer(
//             bloc: BlocProvider.of<SearchBloc>(context),
//             listener: (context, state) {
//               print("State has changed");
//               if (state is BaseError) {
//                 Scaffold.of(context).showSnackBar(
//                   SnackBar(
//                     content: Text(state.message),
//                   ),
//                 );
//               }
//             },
//             builder: (context, state) {
//               if (state is BaseInitial || state is BaseLoading) {
//                 return _buildLoading();
//               } else if (state is BaseLoaded) {
//                 if (state.data is Post) {
//                   Post? data = (state.data as Post?);
//                   if (data != null) {
//                     print(data);
//                     return _home(data);
//                   }
//                 }
//               } else if (state is BaseError) {
//                 return Container();
//               }
//               return Container();
//             },
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _home(Post post) {
//     return post.result != null ?
//     Container(
//       height: 500,
//       child: ListView.builder(
//           scrollDirection: Axis.horizontal,
//           shrinkWrap: true,
//           itemCount: post.result?.length,
//           itemBuilder: (context, index) {
//             return Text(post.result![index].title ?? "");
//           }),
//     ) : Container();
//   }
//
//   Widget _buildUser(List<User>? users) {
//     return users != null
//         ? ListView.builder(
//         scrollDirection: Axis.vertical,
//         shrinkWrap: true,
//         itemCount: users.length,
//         itemBuilder: (context, index) {
//           return Text(users[index].name ?? "");
//         })
//         : Container();
//   }
//
//   Widget _buildLoading() => CustomProgressIndicatorWidget();
// }
