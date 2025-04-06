import 'package:flutter/material.dart';
import 'package:yemen_travel_guid/colors/app_colors.dart';
import 'package:yemen_travel_guid/controllers/user_controller.dart';

import 'package:yemen_travel_guid/models/city_model.dart';
import 'package:yemen_travel_guid/models/place_model.dart';
import 'package:yemen_travel_guid/models/trip_model.dart';
import 'package:yemen_travel_guid/constant.dart';
import 'package:yemen_travel_guid/views/screens/cities/city_page.dart';
import 'package:yemen_travel_guid/views/screens/login/login.dart';
import 'package:yemen_travel_guid/views/screens/places/place_page.dart';
import 'package:yemen_travel_guid/views/screens/trips/trip_page.dart';
class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String? searchText ;
  List<CityModel> cities = [];
  List<PlaceModel> places = [];
  List<TripModel> trips = [];
  bool loading = true;

  void _search() async {

    var response = await search(searchText??'');
    if (response.error == null) {
      cities = response.mapData!['cities'] as List<CityModel>;
      places = response.mapData!['places'] as List<PlaceModel>;
      trips = response.mapData!['trips'] as List<TripModel>;
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

  @override
  void initState() {
    _search();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('بحث', style:TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color: AppColors.primary3)),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0,bottom: 16.0,right: 16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'البحث عن وجهات وأشياء للقيام بها...',
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(Icons.search, color: AppColors.primary4,size: 33,),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: AppColors.primary3, ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: AppColors.primary3, width:  1.3),
                  ),

                ),
                onChanged: (value) {
                  setState(() {
                    searchText = value;
                  });
                  _search();
                },
              ),
              SizedBox(height: 20),
              // عنوان الاقتراحات

              // قائمة الاقتراحات
              Column(
                children: [
                  if(searchText == null || searchText == '')
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'اقتراحات',
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color: AppColors.primary3),
                    ),
                  ),
                  SizedBox(height: 10),
                  ListView.builder(
                    itemCount: cities.length,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder:
                        (BuildContext context, int index) {
                      CityModel city = cities[index];
                      return ListTile(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_) => CityPage(cityId: city.id)));
                        },
                        title: Text(city.cityName,),
                        subtitle: Text(city.description, maxLines: 3,
                          overflow: TextOverflow.ellipsis,),
                        leading: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: city.images.isNotEmpty ? DecorationImage(
                              image:
                              NetworkImage(city.images[0].image),
                              fit: BoxFit.cover,
                            ) : null,
                          ),
                        ),
                      );
                    },

                  ),
                  if(cities.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Divider(),
                  ),
                  ListView.builder(
                    itemCount: places.length,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder:
                        (BuildContext context, int index) {
                      PlaceModel place = places[index];
                      return ListTile(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_) => PlacePage(placeId: place.id)));
                        },
                        title: Text(place.placeName,),
                        subtitle: Text(place.description, maxLines: 3,
                          overflow: TextOverflow.ellipsis,),
                        leading: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: place.images.isNotEmpty ? DecorationImage(
                              image:
                              NetworkImage(place.images[0].image),
                              fit: BoxFit.cover,
                            ) : null,
                          ),
                        ),
                      );
                    },

                  ),
                  if(places.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Divider(),
                  ),
                  ListView.builder(
                    itemCount: trips.length,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder:
                        (BuildContext context, int index) {
                      TripModel trip = trips[index];
                      return ListTile(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_) => TripPage(tripId: trip.id)));
                        },
                        title: Text(trip.name,),
                        subtitle: Text(trip.description, maxLines: 3,
                          overflow: TextOverflow.ellipsis,),
                        leading: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image:trip.image.isNotEmpty
                                ? DecorationImage(
                              image: NetworkImage(trip.image),
                              fit: BoxFit.cover,
                            )
                                : null,
                          ),
                        ),
                      );
                    },

                  ),
                  if(trips.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Divider(),
                  ),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
