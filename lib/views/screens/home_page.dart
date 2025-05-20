import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yemen_travel_guid/constant.dart';
import 'package:yemen_travel_guid/controllers/city_controller.dart';
import 'package:yemen_travel_guid/controllers/user_controller.dart';

import 'package:yemen_travel_guid/models/city_model.dart';
import 'package:yemen_travel_guid/models/place_model.dart';
import 'package:yemen_travel_guid/models/trip_model.dart';
import 'package:yemen_travel_guid/views/screens/cities/city_page.dart';
import 'package:yemen_travel_guid/views/screens/places/favorite_places_page.dart';
import 'package:yemen_travel_guid/views/screens/places/place_page.dart';
import 'package:yemen_travel_guid/views/screens/trips/trip_page.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int cityId = 0;
  List<CityModel> cities = [];
  List<PlaceModel> places = [];
  List<TripModel> trips = [];
  bool loadingCities = true;


  final List<String> images = [
    'assets/images/banner.png',
    'assets/images/banner.png',
    'assets/images/banner.png',
    'assets/images/banner.png',
  ];









  void _getCities() async {

    var response = await getCities();
    if (response.error == null) {
      cities = response.data as List<CityModel>;
    }
    else if(response.error == 'unauthorized'){
      unauthorizedLogout(context);
    }
    else {
      showErrorSnackBar(
        context: context,
        message: response.error.toString(),
      );
    }
    setState(() {
      loadingCities = false;
    });
  }
  void _getCityShow(cityId) async {

    var response = await getCityShow(cityId);
    if (response.error == null) {
      setState(() {
        places = response.mapData!['places'] as List<PlaceModel>;
        trips = response.mapData!['trips'] as List<TripModel>;
      });
    }else if(response.error == 'unauthorized'){
      unauthorizedLogout(context);
    } else {
      showErrorSnackBar(
        context: context,
        message: response.error.toString(),
      );
    }
    setState(() {
      loadingCities = false;
    });
  }

  @override
  void initState() {
    _getCities();
    _getCityShow(0);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [CarouselSlider.builder(
              itemCount: images.length,
              itemBuilder: (BuildContext context, int index, int realIndex) {
                return SizedBox(
                  width: double.infinity,
                  child: Image.asset(images[index], fit: BoxFit.cover),
                );
              },
              options: CarouselOptions(
                height: 230,
                viewportFraction: 1.0,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                enlargeCenterPage: false,
              ),
            ),
              Positioned(
                top: 40,
                left: 10,
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const FavoritePlacesPage()));
                  },
                  child: SvgPicture.asset(
                    height: 30,
                    width: 30,
                    'assets/images/home/heart.svg',
                    fit: BoxFit.cover,
                  )
                ),)
            ]
          ),
          SizedBox(
              width: double.infinity,
              child: Image.asset('assets/images/home/underbanner.png',fit: BoxFit.cover,)
          ),
          const Padding(
            padding: EdgeInsets.only(right: 10,top: 5,bottom: 5),
            child: Text('وجهات السفر',style: TextStyle(fontSize: 20,color: Color(0xFFC08759),),),
          ),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: cities.length + 1,
              itemBuilder: (context, index) {

                if (index == 0) {
                  return InkWell(
                    onTap: (){_getCityShow(0);},
                    child: Container(
                      width: 100,
                      padding: const EdgeInsets.only(right: 10,),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              ClipOval(
                                child: Image.asset(
                                  'assets/images/home/map.png',
                                  fit: BoxFit.cover,
                                  width: 73,
                                  height: 70,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              const Text(
                                'الكل',
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.only(bottom: 10.0),
                            child: VerticalDivider(
                              color: Color(0xcbb88c6c),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                } else {
                  // final dynamicIndex = index - 1;
                  CityModel city = cities[index - 1];
                  return InkWell(
                    onDoubleTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> CityPage(cityId: city.id)));},
                    onTap: (){_getCityShow(city.id);},
                    child: SizedBox(
                      width: 100,
                      child: Column(
                        children: [
                          ClipOval(
                            child: Image.network(
                              city.images[0].image,
                              fit: BoxFit.cover,
                              width: 73,
                              height: 70,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            city.cityName,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            )
          ),
          const Padding(
            padding: EdgeInsets.only(right: 10,bottom: 5),
            child: Text('انشطة يجب القيام بها',style: TextStyle(fontSize: 20,color: Color(0xFFC08759),),),
          ),
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: places.length,
              itemBuilder: (context, index) {
                PlaceModel place = places[index];
                return InkWell(
                  onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> PlacePage(placeId: place.id)));},
                  child: Container(
                    width: 150,
                    margin: const EdgeInsets.only(right: 18,bottom: 11),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(1.0),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(5, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              place.images[0].image,
                              fit: BoxFit.cover,
                              height: 100,
                              width: double.infinity,
                            ),
                          ),
                        ),
                        Container(
                          padding:const EdgeInsets.only(top:5.0, left: 8, right: 8),
                          child: Text(
                            place.placeName,
                            style: const TextStyle(fontSize: 13,color: Color(0xff81400c),fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: SizedBox(
                            height:37,
                            child: Text(
                              place.description,
                              style: const TextStyle(fontSize: 13,color: Color(0xFFA76F47),  height: 1.2, ),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),


                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: const Color(0xFFA87247),
                          ),

                          child: const Padding(
                            padding: EdgeInsets.only(left: 22,right: 22,top: 2),
                            child: Text('تعرف اكثر',style: TextStyle(color: Colors.white,fontSize: 12),),
                          ),
                        ),

                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 10,bottom: 5),
            child: Text('افضل التجارب',style: TextStyle(fontSize: 20,color: Color(0xFFC08759),),),
          ),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: trips.length,
              itemBuilder: (context, index) {
                TripModel trip = trips[index];
                return InkWell(
                  onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> TripPage(tripId: trip.id)));},
                  child: Container(
                    width: 150,
                    height: 100,
                    margin: const EdgeInsets.only(right: 10, left:12, bottom: 11),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(1.0),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(5, 5),
                        ),
                      ],
                    ),
                    child: Row(
                      children:[
                        SizedBox(width: 10,),
                        Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: trip.image.isNotEmpty ? DecorationImage(
                              image:
                              NetworkImage(trip.image),
                              fit: BoxFit.cover,
                            ) : null,
                          ),
                        ),

                        Expanded(
                          child: Container(
                            padding:const EdgeInsets.only(top:5.0, left: 8, right: 8),
                            child: Text(
                              trip.subTitle,
                              style: const TextStyle(fontSize: 10,color: Color(0xff81400c),fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ]
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 50,),
        ],
      ),
    );
  }
}
