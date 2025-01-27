import 'package:flutter/material.dart';
import 'package:yemen_travel_guid/colors/app_colors.dart';
import 'package:yemen_travel_guid/constant.dart';
import 'package:yemen_travel_guid/controllers/office_controller.dart';
import 'package:yemen_travel_guid/controllers/user_controller.dart';
import 'package:yemen_travel_guid/cor/util/snackbar_message.dart';
import 'package:yemen_travel_guid/models/office.dart';
import 'package:yemen_travel_guid/models/trip_model.dart';
import 'package:yemen_travel_guid/views/screens/office/create_update_trip.dart';
import 'package:yemen_travel_guid/views/screens/office/widgets/alert_dialog_create_trip.dart';
import 'package:yemen_travel_guid/views/screens/trips/trip_page.dart';

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



  void _getOffice() async {
    print('--------------------------------');
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
      backgroundColor: Colors.white,
      body: Column(
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
              itemCount: office.trips.length ,
              itemBuilder: (context, index) {
                TripModel trip = office.trips[index];

                return Container(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) =>  CreateUpdateTrip()));
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialogCreateTrip();
              });
        },
        tooltip: 'إضافة رحلة',
        backgroundColor: const Color(0xffffff),
        child: const Icon(Icons.add),
      ),
    );
  }
}
