import 'package:flutter/material.dart';
import 'package:yemen_travel_guid/controllers/office_controller.dart';
import 'package:yemen_travel_guid/controllers/user_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yemen_travel_guid/models/office.dart';
import 'package:yemen_travel_guid/models/trip_model.dart';
import 'package:yemen_travel_guid/views/screens/office/create_trip.dart';
import 'package:yemen_travel_guid/views/screens/office/office_bookings_page.dart';
import 'package:yemen_travel_guid/views/screens/office/update_trip.dart';
import 'package:yemen_travel_guid/views/screens/trips/trip_page.dart';
import 'package:yemen_travel_guid/constant.dart';
class OfficePage extends StatefulWidget {
  const OfficePage({super.key});

  @override
  State<OfficePage> createState() => _OfficePageState();
}

class _OfficePageState extends State<OfficePage> {

  bool loading = false;
  bool loadingTrip = false;
  late OfficeModel office;
  @override
  void initState() {
    _getOffice();
    super.initState();
  }



  Future<void> _getOffice() async {
    setState(() {
      loading = true;
    });
    var response = await getOffice();
    if (response.error == null) {
      office = response.data as OfficeModel;
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
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: (){
          return _getOffice();
        },
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: const Color(0xFFECE0D9),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
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
                          'رحلات المكتب',
                          style: TextStyle(
                            fontSize: 22,
                            color: Color(0xFFA76F47),
                          ),
                        ),

                      ],
                    ),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.only(top: 50.0, right: 22, bottom: 10, left: 12),
                    child: Row(
                      children: [
                        InkWell(
                          child: const Icon(Icons.notifications_active, color: Color(0xFFA87247),),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_) =>  const OfficeBookingsPage()));
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            loading ? const Center(child: CircularProgressIndicator())
                :
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 10,bottom: 50),
                itemCount: office.trips.length ,
                itemBuilder: (context, index) {
                  TripModel trip = office.trips[index];

                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) =>  TripPage(tripId: trip.id)));
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
                                          color: Color(0xFFA76F47)),
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
                              IconButton(
                                  onPressed: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>  UpdateTrip(trip: trip))).then((_) {_getOffice();});
                                  },
                                  icon: const Icon(Icons.edit_note_outlined,size: 33, color: Color(0xFFCE9263)))
                            ],
                          ),
                        ),
                      ),
                      const Divider()
                    ],
                  );

                },
              ),
            )

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=> const CreateTrip())).then((_) {_getOffice();});
        },
        tooltip: 'إضافة رحلة',
        backgroundColor:  const Color(0xFFCE9263),
        child: const Icon(Icons.add),
      ),
    );
  }
}
