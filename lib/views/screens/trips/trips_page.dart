import 'package:flutter/material.dart';
import 'package:yemen_travel_guid/colors/app_colors.dart';
import 'package:yemen_travel_guid/constant.dart';
import 'package:yemen_travel_guid/controllers/trips_controller.dart';
import 'package:yemen_travel_guid/controllers/user_controller.dart';

import 'package:yemen_travel_guid/models/trip_model.dart';
import 'package:yemen_travel_guid/views/screens/bookings/my_bookings_page.dart';
import 'package:yemen_travel_guid/views/screens/trips/trip_page.dart';

class TripsPage extends StatefulWidget {
  const TripsPage({super.key});

  @override
  State<TripsPage> createState() => _TripsPageState();
}

class _TripsPageState extends State<TripsPage> {
  bool loading = true;
  List<TripModel> trips = [];
  @override
  void initState() {
    _getTrips();
    super.initState();
  }



  Future<void> _getTrips() async {
    print('--------------------------------');
    var response = await getTrips();
    if (response.error == null) {
      trips = response.data as List<TripModel>;
    }else if(response.error == 'unauthorized'){
      unauthorizedLogout(context);
    } else {
      showErrorSnackBar(context: context, message: response.error.toString(), );
    }
    setState(() {
      loading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Column(
          children: [
            Container(
              width: double.infinity,
              color: AppColors.primary0,
              child:  Padding(
                padding:
                    EdgeInsets.only(top: 50.0, right: 22, bottom: 10,left: 22),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'البكجات المتوفرة',
                      style: TextStyle(
                        fontSize: 22,
                        color: AppColors.titleColor,
                      ),
                    ),
                InkWell(
                  child: Image.asset(
                    height:50,
                    width: 50,
                    'assets/images/img.png',
                    fit: BoxFit.cover,
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) =>  MyBookingsPage()));
                  },
                ),
                  ],
                ),
              ),
            ),
            loading ? Expanded(child: Center(child: CircularProgressIndicator())) :

        Expanded(
              child: RefreshIndicator(
                onRefresh: ()  {return _getTrips();},
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 10,bottom: 50),
                  itemCount: trips.length ,
                  itemBuilder: (context, index) {
                    TripModel trip = trips[index];

                      return Container(
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (_) =>  TripPage(tripId:trip.id)));
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 22),
                                child: Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        image: DecorationImage(
                                          image:
                                          NetworkImage(trip.image),
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
                                            trip.name,
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: AppColors.titleColor),
                                          ),
                                          Text(
                                            trip.description,
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
                        ),
                      );

                  },
                ),
              ),
            )

          ],
        ) ;


  }

  // void _listener(BuildContext context, TripState state) {
  //
  // }
}
