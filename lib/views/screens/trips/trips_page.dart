import 'package:flutter/material.dart';
import 'package:yemen_travel_guid/colors/app_colors.dart';
import 'package:yemen_travel_guid/constant.dart';
import 'package:yemen_travel_guid/controllers/trips_controller.dart';
import 'package:yemen_travel_guid/cor/util/snackbar_message.dart';
import 'package:yemen_travel_guid/models/trip_model.dart';
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
    print('[[[[[[[[[[[[object]]]]]]]]]]]]');
    _getTrips();
    super.initState();
  }



  void _getTrips() async {
    print('--------------------------------');
    var response = await getTrips();
    if (response.error == null) {
      trips = response.data as List<TripModel>;
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
              child: const Padding(
                padding:
                    EdgeInsets.only(top: 50.0, right: 22, bottom: 10),
                child: Text(
                  'البكاجات المتوفرة',
                  style: TextStyle(
                    fontSize: 22,
                    color: AppColors.titleColor,
                  ),
                ),
              ),
            ),
            loading ? Center(child: CircularProgressIndicator())
          :
        Expanded(
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
                                      borderRadius: BorderRadius.circular(18),
                                      image: DecorationImage(
                                        image:
                                        NetworkImage('$baseURL${trip.image}'),
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
            )

          ],
        ) ;


  }

  // void _listener(BuildContext context, TripState state) {
  //
  // }
}
