import 'package:flutter/material.dart';
import 'package:yemen_travel_guid/colors/app_colors.dart';
import 'package:yemen_travel_guid/constant.dart';
import 'package:yemen_travel_guid/controllers/bookings_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yemen_travel_guid/models/booking_model.dart';
import 'package:yemen_travel_guid/views/screens/trips/trip_page.dart';

class MyBookingsPage extends StatefulWidget {
  const MyBookingsPage({super.key});

  @override
  State<MyBookingsPage> createState() => _MyBookingsPageState();
}

class _MyBookingsPageState extends State<MyBookingsPage> {
  bool loading = true;
  List<BookingModel> bookings = [];
  @override
  void initState() {
    _getMyBookings();
    super.initState();
  }



  Future<void> _getMyBookings() async {
    print('--------------------------------');
    var response = await getMyBookings();
    if (response.error == null) {
      bookings = response.data as List<BookingModel>;
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
            color: AppColors.primary0,
            child:  Padding(
              padding:
              EdgeInsets.only(top: 50.0, right: 12, bottom: 10),
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
                  Text(
                    'حجوزاتي',
                    style: TextStyle(
                      fontSize: 22,
                      color: AppColors.titleColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          loading ? Expanded(child: Center(child: CircularProgressIndicator())) :

          Expanded(
            child: RefreshIndicator(
              onRefresh: ()  {return _getMyBookings();},
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 10,bottom: 50),
                itemCount: bookings.length ,
                itemBuilder: (context, index) {
                  BookingModel booking = bookings[index];

                  return Container(
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_) =>  TripPage(tripId:booking.trip.id)));
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
                                      NetworkImage(booking.trip.image),
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
                                        booking.trip.name,
                                        style: const TextStyle(
                                            fontSize: 20,
                                            color: AppColors.titleColor),
                                      ),
                                      Text(
                                        booking.trip.description,
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
      ),
    ) ;


  }
}
