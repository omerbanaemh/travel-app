import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yemen_travel_guid/controllers/user_controller.dart';
import 'package:yemen_travel_guid/models/auth/profile_model.dart';

// const baseURL = 'http://10.0.2.2:8000/api';
// const baseURL = 'http://192.168.137.1:8000/api';
// const baseURL = 'http://bindowal-001-site24.jtempurl.com/api';
const baseURL = 'http://192.168.65.121:2025';


//AUTH
const loginURL = '$baseURL/api/login';
const registerURL = '$baseURL/api/register';
const profileURL = '$baseURL/api/profile';

const logoutURL = '$baseURL/api/logout';
const userURL = '$baseURL/api/user';
const usersURL = '$baseURL/api/users';
const postsURL = '$baseURL/api/posts';

//TRIPS
const getTripsURL = '$baseURL/api/trip_packages';

//BOOKINGS
const createBookingURL = '$baseURL/api/bookings/store';


//PLACES
const getPlacesURL = '$baseURL/api/places';

//RATING
const ratingURL = '$baseURL/api/ratings/store';

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
Future<ProfileModel?> getProfilee() async {
  ProfileModel user;
  SharedPreferences pref = await SharedPreferences.getInstance();
  if (pref.getString('profile') == null) {
    var response = await getProfile();
    if (response.error == null) {
      user = response.data as ProfileModel;
      return user;
    }
    return null;
  }
  else if (pref.getString('profile') != null) {
    return ProfileModel.fromJson(jsonDecode(pref.getString('profile')!));
  }
 return null;
}

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
      contentPadding: const EdgeInsets.all(10),
      border: const OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.black))
  );
}

