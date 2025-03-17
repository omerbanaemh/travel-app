import 'package:flutter/material.dart';
import 'package:yemen_travel_guid/constant.dart';
import 'dart:math' as math;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yemen_travel_guid/controllers/comment_controller.dart';
import 'package:yemen_travel_guid/controllers/trips_controller.dart';
import 'package:yemen_travel_guid/controllers/user_controller.dart';

import 'package:yemen_travel_guid/models/api_response.dart';
import 'package:yemen_travel_guid/models/auth/profile_model.dart';
import 'package:yemen_travel_guid/models/comment_model.dart';
import 'package:yemen_travel_guid/models/trip_model.dart';
import 'package:yemen_travel_guid/views/screens/bookings/my_bookings_page.dart';
import 'package:yemen_travel_guid/views/screens/trips/widgets/alert_dialog_create_booking.dart';
import 'package:yemen_travel_guid/views/screens/trips/widgets/alert_dialog_rating.dart';


class TripPage extends StatefulWidget {
  final int tripId;
  const TripPage({super.key,required this.tripId});

  @override
  State<TripPage> createState() => _TripPageState();
}

class _TripPageState extends State<TripPage> {
  ProfileModel? profile;
  late  TripModel trip;
  bool loading = false;

  int _editCommentId = 0;
  int editIndex = 0;
  final TextEditingController _txtCommentController = TextEditingController();


  void getProfile () async {
  profile = await getProfilee();
}
  @override
  void initState() {
    _getTrip();

    getProfile();


    super.initState();
  }




  Future<void> _getTrip() async {
    print('--------------------------------');
    setState(() {
      loading = true;
    });
    var response = await getTrip(widget.tripId);
    if (response.error == null) {
      trip = response.data as TripModel;
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

  // Create comment
  Future<void> _createComment() async {
    ApiResponse response = await createComment(_txtCommentController.text, null, trip.id.toString());

    if(response.error == null){
      setState(() {
        _txtCommentController.clear();
        trip.comments.add(response.data as CommentModel);
      });
    }
    else if(response.error == 'unauthorized'){
      unauthorizedLogout(context);
    }
    else {
      showErrorSnackBar(context: context, message:response.error.toString());
    }
  }

  // edit comment
  Future<void> _editComment() async {
    ApiResponse response = await editComment(_editCommentId, _txtCommentController.text);

    if(response.error == null) {
      setState(() {
        _editCommentId = 0;
        _txtCommentController.clear();
        CommentModel comment = response.data as CommentModel;
        if (editIndex >= 0 && editIndex < trip.comments.length) {
          trip.comments[editIndex].comment = comment.comment;
        }
      });
    }
    else if(response.error == 'unauthorized'){
      unauthorizedLogout(context);
    }
    else {
      showErrorSnackBar(context: context,message:response.error.toString());
    }
  }

  //Delete comment
  Future<void> _deleteComment(int commentId) async {
    ApiResponse response = await deleteComment(commentId);

    if(response.error == null){
      setState(() {
        trip.comments.removeWhere((comment) => comment.id == commentId);
      });
    }
    else if(response.error == 'unauthorized'){
      unauthorizedLogout(context);
    }
    else {
      showErrorSnackBar(context: context,message: response.error.toString());
    }
  }


  @override
  Widget build(BuildContext context) {
    return loading ? Scaffold(body: Center(child: CircularProgressIndicator())) :
    Scaffold(
      body: RefreshIndicator(
        onRefresh: () {
          return _getTrip();
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
                            child: Image.network(trip.image,fit: BoxFit.cover,)
                        ),

                        Positioned(
                          top: 40,
                          right: 10,
                          child:
                          Row(
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
                              Text(trip.name,style: TextStyle(fontSize: 28,color: Color(0xffa76f47 )),)
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Text('نظرة عامة',style: TextStyle(fontSize: 32,color: Color(
                              0xffa76f47)),),
                        ),

                        Row(
                          children: [
                            Row(
                              children: List.generate(5, (index) {
                                return Row(
                                  children: [
                                    SizedBox(
                                      width: 25,
                                      child: Icon(
                                        index < int.parse(trip.ratings!) ? Icons.star : Icons.star_border,
                                        color: Colors.amber,
                                      ),
                                    ),
                                  ],
                                );
                              }),
                            ),
                            SizedBox(width: 15,),
                          ],
                        ),

                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: Text(trip.subTitle,style: TextStyle(fontSize: 20,color: Color(
                          0xffa76f47)),),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(trip.description,style: TextStyle(fontSize: 16,),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Text('معلومات الرحلة ',style: TextStyle(fontSize: 32,color: Color(
                          0xffa76f47)),),
                    ),
                    Divider(),
                    InkWell(
                      onTap: () {
                        print(trip.image);
                        _showBottomSheet(context, 'خط سير الرحلة', trip.itinerary);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('خط سير الرحلة',style: TextStyle(fontSize: 24,),),
                            Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.rotationY(math.pi),
                              child: Icon(Icons.arrow_back_ios_new_rounded,size: 20,),
                            ),              ],
                        ),
                      ),
                    ),
                    Divider(),
                    InkWell(
                      onTap: () {
                        _showBottomSheet(context, 'محتويات الرحلة', trip.tripContent);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('محتويات الرحلة',style: TextStyle(fontSize: 24,),),
                            Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.rotationY(math.pi),
                              child: Icon(Icons.arrow_back_ios_new_rounded,size: 20,),
                            ),              ],
                        ),
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0,top: 8,bottom: 6),
                      child: const Text("التعليقات",  style: TextStyle(
                        fontSize: 22,
                        color: Color(0xffa66e47),
                        fontWeight: FontWeight.bold,),),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0 ),
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: trip.comments.length,
                        itemBuilder:
                            (BuildContext context, int index) {
                          CommentModel comment = trip.comments[index];
                          return Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor:
                                        Color(0xffeaded8),
                                        radius: 15,
                                        child:  Text(
                                          comment.user.userName
                                              .isNotEmpty
                                              ? comment
                                              .user.userName[0]
                                              : '',
                                          style:
                                          const TextStyle(
                                            fontWeight:
                                            FontWeight.w600,
                                            fontSize: 16,
                                          ),
                                        ),

                                      ),
                                      const SizedBox(
                                        width: 8.0,
                                      ),
                                      Text(
                                        comment.user.userName,
                                        style: const TextStyle(
                                            fontWeight:
                                            FontWeight.w600,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  // comment['userId'] == userId ?
                                  comment.user.id == profile?.id
                                      ? PopupMenuButton(
                                    child: const Padding(
                                        padding:
                                        EdgeInsets.only(
                                            right: 10),
                                        child: Icon(
                                          Icons.more_vert,
                                          color: Color(0xff734c31),
                                        )),
                                    itemBuilder: (context) => [
                                      const PopupMenuItem(
                                          value: 'edit',
                                          child: Text('تعديل')),
                                      const PopupMenuItem(
                                          value: 'delete',
                                          child: Text('حذف'))
                                    ],
                                    onSelected: (val) {
                                      if (val == 'edit') {
                                        setState(() {
                                          _editCommentId = comment.id;
                                          _txtCommentController.text = comment.comment;
                                          editIndex = index;
                                        });
                                      } else {
                                        _deleteComment(
                                            comment.id);
                                      }
                                    },
                                  )
                                      : const SizedBox()
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 38.0, left: 21),
                                child: Text(comment.comment),
                              ),
                              const SizedBox(
                                height: 10,
                              )
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: kInputDecoration('تعليق'),
                      controller: _txtCommentController,
                    ),
                  ),
                  SizedBox(width: 8,),
                  InkWell(
                    child: SvgPicture.asset(
                      height: 40,
                      width: 40,
                      'assets/images/Message.svg',
                      fit: BoxFit.cover,
                    ),
                    onTap: (){
                      if(_txtCommentController.text.isNotEmpty){
                        FocusScope.of(context).requestFocus(FocusNode());
                        if (_editCommentId > 0){
                          _editComment();
                        } else {
                          _createComment();
                        }
                      }
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color(0xffece0d9),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(child: Text('السعر ${trip.price} ر.س', style: TextStyle(fontSize: 24,),)),
            SizedBox(width: 8,),
            trip.reserved! ?
            Container(
              width: 127,
              height: 47,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.lightGreen,
              ),
                child: Center(child: Text('تم الحجز', style: TextStyle(fontSize: 24,color: Colors.white),))):
            InkWell(
              onTap: () {
                 showDialog(
                 context: context,
                 builder: (BuildContext context) {
                   return AlertDialogCreateBooking(tripId: trip.id,);
                 }).then((value) => {
                   if (value == true) {
                     showDialog(
                         context: context,
                         builder: (BuildContext context) {
                           return AlertDialogRating(tripId: trip.id,);
                         }),
                     _getTrip(),
                   }
                 });
              },
              child: Container(
                width: 127,
                height: 47,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xffa76f47),
                ),
                  child: Center(child: Text('أحجز الآن', style: TextStyle(fontSize: 24,color: Colors.white),))),
            )
          ],
        ),
      ),
    );
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
