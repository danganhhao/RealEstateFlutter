import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/constants/colors.dart';
import 'package:real_estate/constants/dimens.dart';

class SearchScreen extends StatefulWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => SearchScreen(),
      );

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool _isShowOptions = false;
  String _keyword = "";
  String _cityId= "";
  String _districtId = "";
  String _wardId = "";
  String _estateTypeId = "";

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
              Center(
                child: ElevatedButton(
                    child: const Text('Search'),
                    onPressed: () {},
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
    options[0] = "City";
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
                      _selectBottomSheet();
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
                              child: Text(options[index] ?? "",
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
              )
            ],
          );
        });
  }
}
