import 'package:flutter/material.dart';
import 'package:yemen_travel_guid/constant.dart';
import 'package:yemen_travel_guid/controllers/places_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yemen_travel_guid/models/place_model.dart';
import 'package:yemen_travel_guid/views/screens/places/place_page.dart';

class FavoritePlacesPage extends StatefulWidget {
  const FavoritePlacesPage({super.key});

  @override
  State<FavoritePlacesPage> createState() => _FavoritePlacesPageState();
}

class _FavoritePlacesPageState extends State<FavoritePlacesPage> {
  bool loading = true;
  List<PlaceModel> places = [];
  @override
  void initState() {
    _getFavoritePlaces();
    super.initState();
  }



  Future<void> _getFavoritePlaces() async {
    var response = await getFavoritePlaces();
    if (response.error == null) {
      places = response.data as List<PlaceModel>;
    } else {
      showErrorSnackBar(context: context, message: response.error.toString(), );
    }
    setState(() {
      loading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
            children: [
              Container(
                width: double.infinity,
                color: const Color(0xFFECE0D9),
                child:  Padding(
                  padding:
                      const EdgeInsets.only(top: 50.0, right: 12, bottom: 10,left: 22),
                  child: Row(
                    children: [
                            InkWell(
                              onTap: () => Navigator.pop(context),
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: SvgPicture.asset(
                                  'assets/images/back.svg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                      const Text(
                        'مفضلتي',
                        style: TextStyle(
                          fontSize: 22,
                          color: Color(0xFFA76F47),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              loading ? const Expanded(child: Center(child: CircularProgressIndicator())) :

          Expanded(
                child: RefreshIndicator(
                  onRefresh: ()  {return _getFavoritePlaces();},
                  child: ListView.builder(
                    padding: const EdgeInsets.only(top: 10,bottom: 50),
                    itemCount: places.length ,
                    itemBuilder: (context, index) {
                      PlaceModel place = places[index];

                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (_) =>  PlacePage(placeId:place.id)));
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 22),
                                child: Row(
                                  children: [
                                    if (place.images.isNotEmpty)
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(18),
                                        image: DecorationImage(
                                          image:
                                          NetworkImage(place.images[0].image),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      width: 90,
                                      height: 76,
                                      // child: Image.asset(item[index]['image']!),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            place.placeName,
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: Color(0xFFA76F47)),
                                          ),
                                          Text(
                                            place.description,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.black54),
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Divider()
                          ],
                        );

                    },
                  ),
                ),
              )

            ],
          ),
    ) ;


  }

  // void _listener(BuildContext context, TripState state) {
  //
  // }
}
