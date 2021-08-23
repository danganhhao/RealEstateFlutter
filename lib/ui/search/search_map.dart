import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';
import 'package:real_estate/constants/colors.dart';
import 'package:user_location/user_location.dart';
import 'package:real_estate/data/models/search_engine/entity/post.dart';

class SearchMap extends StatefulWidget {
  static Route<dynamic> route(List<PostItem> items) =>
      MaterialPageRoute(builder: (context) => SearchMap(items: items));

  final List<PostItem> items;

  const SearchMap({Key? key, required this.items}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SearchMapState(items);
  }
}

class _SearchMapState extends State<SearchMap> {
  final List<PostItem> items;

  _SearchMapState(this.items);

  // ADD THIS
  MapController mapController = MapController();
  late UserLocationOptions userLocationOptions;

  // ADD THIS
  List<Marker> markers = [];

  @override
  Widget build(BuildContext context) {
    userLocationOptions = UserLocationOptions(
      context: context,
      mapController: mapController,
      markers: markers,
    );
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              center: LatLng(10.759333, 106.684000),
              interactiveFlags:
                  InteractiveFlag.pinchZoom | InteractiveFlag.drag,
              zoom: 13,
              plugins: [
                UserLocationPlugin(),
              ],
            ),
            layers: [
              TileLayerOptions(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c']),
              MarkerLayerOptions(
                  markers: items
                      .map((postItem) => Marker(
                            width: 30.0,
                            height: 30.0,
                            point: LatLng(postItem.lat ?? 10.759333,
                                postItem.lng ?? 106.684000),
                            builder: (ctx) => Container(
                              child: InkWell(
                                  onTap: () {
                                    _showBottomSheet(postItem);
                                  },
                                  child: Image.asset("assets/icons/marker.png",
                                      width: 40,
                                      height: 40,
                                      fit: BoxFit.cover)),
                            ),
                          ))
                      .toList()),
              userLocationOptions,
            ],
            mapController: mapController,
          ),
          Positioned(
              top: 30,
              left: 8,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                  print("tap");
                },
                child: ClipOval(
                  child: Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    color: AppColors.primaryColor,
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }

  void _showBottomSheet(PostItem item) {
    Size size = MediaQuery.of(context).size;
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("info"),
              Text(item.title ?? ""),
              Text("${item.price}"),
            ],
          );
        });
  }
}
