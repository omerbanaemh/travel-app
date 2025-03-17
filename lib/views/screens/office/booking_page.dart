import 'package:flutter/material.dart';
import 'package:yemen_travel_guid/constant.dart';
import 'dart:math' as math;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yemen_travel_guid/controllers/bookings_controller.dart';
import 'package:yemen_travel_guid/controllers/user_controller.dart';
import 'package:yemen_travel_guid/models/booking_model.dart';
import 'package:dio/dio.dart' as dio;

class BookingPage extends StatefulWidget {
  final int bookingId;
  const BookingPage({super.key,required this.bookingId});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  late  BookingModel booking;
  bool loading = false;

  int _editCommentId = 0;
  int editIndex = 0;
  final TextEditingController _txtCommentController = TextEditingController();




  @override
  void initState() {
    print(widget.bookingId);
    _getBooking();
    super.initState();
  }




  Future<void> _getBooking() async {
    print('--------------------------------');
    setState(() {
      loading = true;
    });
    var response = await getBooking(widget.bookingId);
    if (response.error == null) {
      booking = response.data as BookingModel;
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


  Future<void> _updateBooking(status) async {
    setState(() {
      loading = true;
    });
    var response = await updateBooking(widget.bookingId,status);
    if (response.error == null) {
      booking = response.data as BookingModel;
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
      body: RefreshIndicator(
        onRefresh: () {
          return _getBooking();
          },
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                            height: 230,
                            width: double.infinity,
                            child: Image.network(booking.image,fit: BoxFit.cover,)
                        ),
                        Positioned(
                            top: 40,
                            right: 10,
                            child:
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


                            ),
                      ],
                    ),

                        Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Text(' حجز ${booking.trip.name}',style: TextStyle(fontSize: 32,color: Color(
                              0xffa76f47)),),),


                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Text('معلومات الرحلة ',style: TextStyle(fontSize: 32,color: Color(
                          0xffa76f47)),),
                    ),
                    InkWell(
                      onTap: () {
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image:booking.trip.image.isNotEmpty
                                    ? DecorationImage(
                                  image: NetworkImage(booking.trip.image),
                                  fit: BoxFit.cover,
                                )
                                    : null,
                              ),
                            ),
                            Expanded(child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(booking.trip.name,style: TextStyle(fontSize: 24,),),
                            )),
                            SizedBox(),
                            Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.rotationY(math.pi),
                              child: Icon(Icons.arrow_back_ios_new_rounded,size: 20,),
                            ),              ],
                        ),
                      ),
                    ),


                    Padding(
                      padding: const EdgeInsets.only(top: 16, right: 16.0),
                      child: Text('معلومات حاجز الرحلة',style: TextStyle(fontSize: 24,color: Color(
                          0xffa76f47)),),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image:booking.trip.image.isNotEmpty
                                  ? DecorationImage(
                                image: NetworkImage(booking.trip.image),
                                fit: BoxFit.cover,
                              )
                                  : null,
                            ),
                          ),
                          Expanded(child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(booking.user.userName,style: TextStyle(fontSize: 24,),),
                          )),
                          SizedBox(),
                          Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.rotationY(math.pi),
                            child: Icon(Icons.arrow_back_ios_new_rounded,size: 20,),
                          ),              ],
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: booking.status == 'waiting' ? BottomAppBar(
        color: Color(0xffece0d9),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(width: 8,),
            InkWell(
              onTap: () {
                _updateBooking('Rejected');
              },
              child: Container(
                  width: 90,
                  height: 47,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey,
                  ),
                  child: Center(child: Text('رفض', style: TextStyle(fontSize: 24,color: Colors.white),))),
            ),
            SizedBox(width: 8,),
            InkWell(
              onTap: () {
                _updateBooking('acceptable');
              },
              child: Container(
                  width: 90,
                  height: 47,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xffa76f47),
                  ),
                  child: Center(child: Text('قبول', style: TextStyle(fontSize: 24,color: Colors.white),))),
            )
          ],
        ),
      )
          :  booking.status == 'Rejected' ? BottomAppBar(
        color: Color(0xfff5b4ac),
        child: Center(child: Text('تم الرفض')),

      ) : booking.status == 'acceptable' ? BottomAppBar(
        color: Color(0xffacf5bd),
        child: Center(child: Text('تم القبول')),

      ) : null );
  }






  void _showBottomSheet(BuildContext context, title, description) {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.only(left: 16.0,bottom: 16.0, right: 16.0,),
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 5,
                  width: 94,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                SizedBox(height: 10),
                Text(title,style: TextStyle(fontSize: 24 ),),
                SizedBox(height: 10),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(description,style: TextStyle(fontSize: 16 ),),
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
