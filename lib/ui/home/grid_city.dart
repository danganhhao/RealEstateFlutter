import 'dart:async';

import 'package:flutter/material.dart';
import 'package:real_estate/constants/dimens.dart';
import 'package:real_estate/data/models/city_info/city_info.dart';
import 'package:real_estate/ui/home/title_with_more_btn.dart';

class GridCityWidget extends StatefulWidget {
  const GridCityWidget({
    Key? key,
    required this.data,
    required this.press,
  }) : super(key: key);

  final CityInfo? data;
  final Function press;

  @override
  State createState() {
    return _CityWidget(data: data, press: press);
  }
}

class _CityWidget extends State<GridCityWidget> {
  final CityInfo? data;
  final Function press;

  int _pos = 0;
  late Timer _timer;


  @override
  void initState() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      setState(() {
        _pos = (_pos + 1) % 2;      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  _CityWidget({this.data, required this.press});
  @override
  Widget build(BuildContext context) {
    return data != null
        ? Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimens.default_padding),
          child: Row(
            children: const [
              TitleWithCustomUnderline(text: "Pupolar"),
              Spacer()
            ],
          ),
        ),
        GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            crossAxisCount: 2,
            childAspectRatio: 5 / 3,
            padding: const EdgeInsets.all(4.0),
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
            children: data!.items!.map((city) {
              return InkWell(
                onTap: () {
                  press(city);
                },
                child: GridTile(
                  child: Container(
                    decoration: const BoxDecoration(
                        borderRadius:
                        BorderRadius.all(Radius.circular(4))),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius:
                          const BorderRadius.all(Radius.circular(4)),
                          child: FadeInImage.assetNetwork(
                            placeholder: "assets/images/placeholder.jpg",
                            image: city.images![_pos],
                          ),
                        ),
                        Container(
                            decoration: const BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(4)),
                                color: Color(0x4D000000))),
                        Positioned(
                            top: 4,
                            left: 4,
                            child: Text(
                              "${city.name}",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 20),
                            )),
                        Positioned(
                            left: 4,
                            top: 24,
                            child: Text(
                              "${city.totalEstate} bất động sản",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 16),
                            )),
                      ],
                    ),
                  ),
                ),
              );
            }).toList()),
      ],
    )
        : Container();
  }
}
