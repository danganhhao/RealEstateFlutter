import 'package:flutter/material.dart';
import 'package:real_estate/constants/dimens.dart';
import 'package:real_estate/data/models/city_info/city_info.dart';
import 'package:real_estate/ui/home/title_with_more_btn.dart';

class GridCityWidget extends StatelessWidget {
  const GridCityWidget({
    Key? key,
    required this.data, required this.press,
  }) : super(key: key);

  final CityInfo? data;
  final Function press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                                  image: city.images![0],
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
