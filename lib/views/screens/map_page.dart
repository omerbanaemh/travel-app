import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:yemen_travel_guid/constant.dart';
import 'package:yemen_travel_guid/controllers/city_controller.dart';
import 'package:yemen_travel_guid/controllers/user_controller.dart';
import 'package:yemen_travel_guid/models/city_model.dart';
import 'package:yemen_travel_guid/views/screens/cities/city_page.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  List<CityModel> cities = [];
  bool loading = false;

  @override
  void initState() {
    _getCities();
    super.initState();
  }

  void _getCities() async {
    setState(() {
      loading = true;
    });
    var response = await getCities();
    if (response.error == null) {
      cities = response.data as List<CityModel>;
    }else if(response.error == 'unauthorized'){
      unauthorizedLogout(context);
    } else {
      showErrorSnackBar(
        context: context,
        message: response.error.toString(),
      );
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : FlutterMap(
              options: const MapOptions(
                  initialCenter: LatLng(14.549497, 49.119880),
                  initialZoom: 2,
                  interactionOptions: InteractionOptions(
                      flags: ~InteractiveFlag.doubleTapZoom)),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                ),
                MarkerLayer(
                  markers: cities.map((city) {
                    return Marker(
                      point: LatLng(city.latitude, city.longitude),
                      child: InkWell(
                        onTap: () {
                          _showBottomSheet(context, city.id, city.cityName,
                              city.description);
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(bottom: 22.0),
                          child: Icon(Icons.location_on,
                              color: Colors.red, size: 20),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
    );
  }

  void _showBottomSheet(
      BuildContext context, int cityId, String name, String description) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: const Color(0xfff5efec),
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.only(
            left: 16.0,
            bottom: 16.0,
            right: 16.0,
          ),
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 6,
                  width: 72,
                  decoration: BoxDecoration(
                    color: const Color(0xffa76f47),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: SizedBox(
                      width: 310,
                      height: 182,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: Image.asset(
                            'assets/images/banner.png',
                            fit: BoxFit.cover,
                          ))),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on_rounded,
                            color: Color(0xffa76f47),
                            size: 30,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              name,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text(
                        description,
                        style: const TextStyle(fontSize: 16, color: Colors.black54),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffa76f47),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CityPage(
                                        cityId: cityId,
                                      )));
                        },
                        child: const Text(
                          'انقر للمزيد',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
