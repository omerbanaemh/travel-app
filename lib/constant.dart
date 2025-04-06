import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yemen_travel_guid/colors/app_colors.dart';
import 'package:yemen_travel_guid/controllers/user_controller.dart';
import 'package:yemen_travel_guid/models/auth/profile_model.dart';

// const baseURL = 'http://10.0.2.2:8000/api';
// const baseURL = 'http://127.0.0.1:8000';
// const baseURL = 'http://192.168.137.1:8000/api';
// const baseURL = 'http://bindowal-001-site24.jtempurl.com/api';
const baseURL = 'http://192.168.119.221:8000';


//AUTH
const loginURL = '$baseURL/api/login';
const registerURL = '$baseURL/api/register';
const profileURL = '$baseURL/api/profile';

const logoutURL = '$baseURL/api/logout';
const userURL = '$baseURL/api/user';
const usersURL = '$baseURL/api/login';
const postsURL = '$baseURL/api/posts';

//TRIPS
const getTripsURL = '$baseURL/api/trip_packages';
const createTripsURL = '$baseURL/api/trip_packages/store';
const updateTripsURL = '$baseURL/api/trip_packages';

//governorates
const governoratesURL = '$baseURL/api/governorates';


//OFFICE
const getMyOfficeURL = '$baseURL/api/offices/my_office';

//FAVORITES
const createFavoriteURL = '$baseURL/api/favorites/store';
const getMyFavoritesURL = '$baseURL/api/favorites/myFivorites';

//BOOKINGS
const createBookingURL = '$baseURL/api/bookings/store';
const getMyBookingsURL = '$baseURL/api/bookings/myBookings';
const getBookingURL = '$baseURL/api/bookings';


//PLACES
const getPlacesURL = '$baseURL/api/places';

//CITIES
const getCitiesURL = '$baseURL/api/cities';
const getCityShowURL = '$baseURL/api/cities/city_show';

//RATING
const ratingURL = '$baseURL/api/ratings/store';

//SEARCH
const searchURL = '$baseURL/api/search';

//COMMENTS
const createCommentURL = '$baseURL/api/comments/store';
const editCommentURL = '$baseURL/api/comments';
const deleteCommentURL = '$baseURL/api/comments';



// get token
Future<String?> getToken() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('token');
}

// get user
// Future<ProfileModel?> getProfilee() async {
//   ProfileModel user;
//   SharedPreferences pref = await SharedPreferences.getInstance();
//   if (pref.getString('profile') == null) {
//     var response = await getProfile();
//     if (response.error == null) {
//       user = response.data as ProfileModel;
//       return user;
//     }
//     return null;
//   }
//   else if (pref.getString('profile') != null) {
//     return ProfileModel.fromJson(jsonDecode(pref.getString('profile')!));
//   }
//  return null;
// }

// get user
Future<ProfileModel?> getSharedPreferencesUser() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String? result = pref.getString('user');
  if(result != null) {
    return ProfileModel.fromJson(jsonDecode(result));
  }
  return null;
}




// --- input decoration
InputDecoration kInputDecoration(String label) {
  return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color:AppColors.primary5),
      contentPadding: const EdgeInsets.all(10),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColors.primary5, ),
      ),


  focusedBorder: OutlineInputBorder(
  borderRadius: BorderRadius.circular(10),
  borderSide: BorderSide(color: AppColors.primary5, width:  1.3),
  ),  );
}



void showSuccessSnackBar({required String message,required BuildContext context}){
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message,style: const TextStyle(color: Colors.white),),
        backgroundColor: Colors.green,)
  );
}

void showErrorSnackBar({required String message,required BuildContext context}){
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message,style: const TextStyle(color: Colors.white),),
        backgroundColor: Colors.red,)
  );
}



void showCreateBooking({required String message,required BuildContext context}){
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message,style: const TextStyle(color: Colors.white),),
        backgroundColor: Colors.red,)
  );
}

