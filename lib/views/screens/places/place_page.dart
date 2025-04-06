import 'package:flutter/material.dart';
import 'package:yemen_travel_guid/colors/app_colors.dart';
import 'package:yemen_travel_guid/constant.dart';
import 'package:yemen_travel_guid/controllers/comment_controller.dart';
import 'package:yemen_travel_guid/controllers/places_controller.dart';
import 'package:yemen_travel_guid/controllers/user_controller.dart';
import 'package:yemen_travel_guid/models/api_response.dart';
import 'package:yemen_travel_guid/models/auth/profile_model.dart';
import 'package:yemen_travel_guid/models/comment_model.dart';
import 'package:yemen_travel_guid/models/place_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../controllers/trips_controller.dart';


class PlacePage extends StatefulWidget {
  final int placeId;
  const PlacePage({super.key,required this.placeId});

  @override
  State<PlacePage> createState() => _PlacePageState();
}

class _PlacePageState extends State<PlacePage> {
  ProfileModel? profile;
  late final PlaceModel place;
  late final CommentModel comment;
  bool loading = false;
  int rating = 0;
  int _editCommentId = 0;
  int editIndex = 0;
  final TextEditingController _txtCommentController = TextEditingController();


  void _getSharedPreferencesUser () async {
  profile = await getSharedPreferencesUser();
}
  @override
  void initState() {
    _getPlace();

    _getSharedPreferencesUser();

    super.initState();
  }



  Future<void> _placeRating() async {
    setState(() {
      loading = true;
    });
    var response = await createRating(rating.toString(), null, place.id.toString());
    if (response.error == null) {
      showSuccessSnackBar(context: context, message: response.message.toString(), );    }
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

  void _getPlace() async {
    setState(() {
      loading = true;
    });
    var response = await getPlace(widget.placeId);
    if (response.error == null) {
      place = response.data as PlaceModel;
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
  void _createComment() async {
    ApiResponse response = await createComment(_txtCommentController.text, place.id.toString(), null,);

    if(response.error == null){
      setState(() {
        _txtCommentController.clear();
        place.comments.add(response.data as CommentModel);
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
  void _editComment() async {
    ApiResponse response = await editComment(_editCommentId, _txtCommentController.text);

    if(response.error == null) {
      setState(() {
        _editCommentId = 0;
        _txtCommentController.clear();
        CommentModel comment = response.data as CommentModel;
        if (editIndex >= 0 && editIndex < place.comments.length) {
          place.comments[editIndex].comment = comment.comment;
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
  void _deleteComment(int commentId) async {
    ApiResponse response = await deleteComment(commentId);

    if(response.error == null){
      setState(() {
        place.comments.removeWhere((comment) => comment.id == commentId);
      });
    }
    else if(response.error == 'unauthorized'){
      unauthorizedLogout(context);
    }
    else {
      showErrorSnackBar(context: context,message: response.error.toString());
    }
  }



  // Create comment
  void _createFavorite() async {
    ApiResponse response = await createFavorite(placeId: place.id.toString() );

    if(response.error == null){
      PlaceModel _place = response.data as PlaceModel;
      setState(() {
          place.favorite= _place.favorite;
             });
    }
    else if(response.error == 'unauthorized'){
      unauthorizedLogout(context);
    }
    else {
      showErrorSnackBar(context: context, message:response.error.toString());
    }
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
                        itemCount: place.images.length,
                        itemBuilder: (BuildContext context, int index, int realIndex) {
                          return Container(
                            width: double.infinity,
                            child: Image.network(place.images[index].image, fit: BoxFit.cover),
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
                            Text(place.placeName,style: TextStyle(fontSize: 28,color: Color(0xffa76f47 )),)
                          ],
                        ),
                      ),

                      Positioned(
                        top: 40,
                        left: 10,
                        child: InkWell(
                          onTap: (){
                            print('object');
                            _createFavorite();
                          },
                          child: place.favorite  ? SvgPicture.asset(
                            height: 30,
                            width: 30,
                            'assets/images/home/heart_select.svg',
                            fit: BoxFit.cover,
                          ) : SvgPicture.asset(
                            height: 30,
                            width: 30,
                            'assets/images/home/heart.svg',
                            fit: BoxFit.cover,
                          ),
                        ),)
                    ],
                  ),
                  Container(
                      width: double.infinity,
                      child: Image.asset('assets/images/home/underbanner.png',fit: BoxFit.cover,)
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: Text('معلومات',style: TextStyle(fontSize: 32,color: Color(
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
                                      index < int.parse(place.ratings!) ? Icons.star : Icons.star_border,
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
                    padding: const EdgeInsets.all(16.0),
                    child: Text(place.description,style: TextStyle(fontSize: 16,),),
                  ),


                  if (place.isRating == false)
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 62,),


                    decoration: BoxDecoration(
                      color: AppColors.primary0,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [

                        SizedBox(height: 10,),
                        Text('تقييم المكان'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(5, (index) {
                            return IconButton(
                              icon: Icon(
                                index < rating ? Icons.star : Icons.star_border,
                                color: Colors.amber,
                              ),
                              onPressed: () {
                                setState(() {
                                  rating = index + 1;
                                });
                              },
                            );
                          }),
                        ),
                        Row(
                          children: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text('إلغاء'),
                            ),
                            TextButton(
                              onPressed: ()  {
                                _placeRating();
                              },
                              child: Text('تقييم'),
                            ),

                          ],
                        ),

                      ],
                    ),
                  ),


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
                      itemCount: place.comments.length,
                      itemBuilder:
                          (BuildContext context, int index) {
                        CommentModel comment = place.comments[index];
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
                    decoration: kInputDecoration('تعليق',),
                    controller: _txtCommentController,
                  ),
                ),
                SizedBox(width: 8,),
                InkWell(
                  child:SvgPicture.asset(
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
          ),
        ],
      ),

    );
  }






}
