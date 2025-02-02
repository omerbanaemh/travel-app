import 'package:flutter/material.dart';
import 'package:yemen_travel_guid/constant.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yemen_travel_guid/controllers/city_controller.dart';
import 'package:yemen_travel_guid/controllers/comment_controller.dart';
import 'package:yemen_travel_guid/controllers/places_controller.dart';
import 'package:yemen_travel_guid/controllers/user_controller.dart';
import 'package:yemen_travel_guid/cor/util/snackbar_message.dart';
import 'package:yemen_travel_guid/models/api_response.dart';
import 'package:yemen_travel_guid/models/auth/profile_model.dart';
import 'package:yemen_travel_guid/models/city_model.dart';
import 'package:yemen_travel_guid/models/comment_model.dart';
import 'package:yemen_travel_guid/models/place_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:yemen_travel_guid/views/screens/places/place_page.dart';



class CityPage extends StatefulWidget {
  final int cityId;
  const CityPage({super.key,required this.cityId});

  @override
  State<CityPage> createState() => _CityPageState();
}

class _CityPageState extends State<CityPage> {
  ProfileModel? profile;
  late final CityModel city;
  late final CommentModel comment;
  bool loading = false;

  int _editCommentId = 0;
  int editIndex = 0;
  final TextEditingController _txtCommentController = TextEditingController();


  void getProfile () async {
  profile = await getProfilee();
}
  @override
  void initState() {
    _getCity();

    getProfile();

    super.initState();
  }




  void _getCity() async {
    setState(() {
      loading = true;
    });
    var response = await getCity(widget.cityId);
    if (response.error == null) {
      city = response.data as CityModel;
    }
    else if(response.error == 'unauthorized'){
      unauthorizedLogout(context);
    }
    else {
      showErrorSnackBar(context: context, message: response.error.toString(), );
    }
    setState(() {
      loading = false;
    });
  }



  @override
  Widget build(BuildContext context) {
    return loading ? Scaffold(body: Center(child: CircularProgressIndicator())) :
    Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      CarouselSlider.builder(
                        itemCount: city.images.length,
                        itemBuilder: (BuildContext context, int index, int realIndex) {
                          return Container(
                            width: double.infinity,
                            child: Image.network(city.images[index].image, fit: BoxFit.cover),
                          );
                        },
                        options: CarouselOptions(
                          height: 230,
                          viewportFraction: 1.0,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 3),
                          enlargeCenterPage: false,
                        ),
                      ),
                      Positioned(
                          top: 35,
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () => Navigator.pop(context),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: SvgPicture.asset(
                                    'assets/images/back.svg',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Text(city.cityName,style: TextStyle(fontSize: 32,color: Color(0xffa76f47 )),),
                            ],
                          ))
                    ],
                  ),
                  Container(
                      width: double.infinity,
                      child: Image.asset('assets/images/home/underbanner.png',fit: BoxFit.cover,)
                  ),


                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(city.description,style: TextStyle(fontSize: 16,),),
                  ),



                  Padding(
                    padding: const EdgeInsets.only(right: 16.0,top: 8, bottom: 8),
                    child: const Text("أماكن يفضل زيارتها",  style: TextStyle(
                      fontSize: 22,
                      color: Color(0xffa66e47),
                      fontWeight: FontWeight.bold,),),
                  ),
                  GridView.builder(
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: city.places.length,
                    itemBuilder: (context, index) {
                      PlaceModel place = city.places[index];
                      return InkWell(
                        onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => PlacePage(placeId: place.id)));},
                        child: Column(
                          children: [
                            Text(place.placeName,),
                            Container(
                              height: 150,
                              margin: EdgeInsets.only(right: 5, left:5, ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(1.0),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: Offset(5, 5),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network( place.images[0].image,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),






                ],
              ),
            ),
          ),

        ],
      ),

    );
  }






}
