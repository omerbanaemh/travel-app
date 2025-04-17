import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:yemen_travel_guid/constant.dart';
import 'package:yemen_travel_guid/models/api_response.dart';
import 'package:yemen_travel_guid/models/auth/profile_model.dart';
import 'package:yemen_travel_guid/models/auth/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yemen_travel_guid/models/city_model.dart';
import 'package:yemen_travel_guid/models/place_model.dart';
import 'package:yemen_travel_guid/models/trip_model.dart';
import 'package:yemen_travel_guid/views/screens/login/login.dart';


// Future<ApiResponse> getAllStats() async {
//   print('=======================getAllStats =================');
//   ApiResponse apiResponse = ApiResponse();
//   try {
//     String? token = await getToken();
//     final response = await http.get(
//         Uri.parse('$baseURL/stats'),
//         headers: {
//           'Accept': 'application/json',
//           'Authorization': 'Bearer $token'
//         });
//     switch(response.statusCode){
//       case 200:
//         apiResponse.data = jsonDecode(response.body)['stats'].map((p) => StatModel.fromJson(p)).toList();
//         apiResponse.data as List<dynamic>;
//         // apiResponse.data = Users.fromJson(jsonDecode(response.body));
//         break;
//       case 401:
//         apiResponse.error = unauthorized;
//         break;
//       default:
//         apiResponse.error = somethingWentWrong;
//         break;
//     }
//   }
//   catch(e) {
//     apiResponse.error = serverError;
//   }
//   return apiResponse;
// }
// Future getAllTasks(int id) async {
//   print('=======================getAllTasks =================');
//   ApiResponse apiResponse = ApiResponse();
//   try {
//   String? token = await getToken();
//   final response = await http.get(
//       Uri.parse('$baseURL/stats/$id/tasks'),
//       headers: {
//         'Accept': 'application/json',
//         'Authorization': 'Bearer $token'
//       });
//   switch(response.statusCode){
//     case 200:
//       apiResponse.data =Board.fromList(jsonDecode(response.body)['data']) ;
//       apiResponse.data as List<dynamic>;
//       // apiResponse.data = Users.fromJson(jsonDecode(response.body));
//       break;
//     case 401:
//       apiResponse.error = unauthorized;
//       break;
//     default:
//       apiResponse.error = somethingWentWrong;
//       break;
//   }
//   }
//   catch(e) {
//     apiResponse.error = serverError;
//   }
//   return apiResponse;
// }


//Login
Future login (String email, String password) async {
  ApiResponse apiResponse = ApiResponse();
  try{
    http.Response response = await http.post(
      Uri.parse(loginURL),
      headers: {'Accept': 'application/json'},
      body: {'email': email, 'password': password}
    );

    switch(response.statusCode){
      case 200:
        apiResponse.data = UserModel.fromJson(jsonDecode(response.body)['data']);
        break;
      case 401:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      default:
        apiResponse.error = 'somethingWentWrong';
        break;
    }
  }
  catch(e){
    apiResponse.error = 'serverError';
  }

  return apiResponse;
}


//RegisterUser
Future<ApiResponse> registerUser(String name, String email, String password ,String passwordConfirmation) async {
  ApiResponse apiResponse = ApiResponse();
  try {
  final response = await http.post(
      Uri.parse(registerURL),
      headers: {'Accept': 'application/json'},
      body: {
        'user_name': name,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
      });

  final Map<String, dynamic> responseBody = jsonDecode(response.body);

  switch(response.statusCode) {
    case 200:
      apiResponse.data = UserModel.fromJson(jsonDecode(response.body)['data']);
      break;
    case 400:
      if (responseBody.containsKey('email')) {
        apiResponse.error = responseBody['email'][0]; // استخرج أول رسالة خطأ للبريد الإلكتروني
      } else {
        apiResponse.error = 'Invalid input'; // رسالة بديلة في حال عدم وجود أخطاء للبريد الإلكتروني
      }
      break;
    default:
      apiResponse.error = 'somethingWentWrong';
      break;
  }
  }
  catch (e) {
    apiResponse.error = 'serverError';
  }
  return apiResponse;
}



//RegisterAgent
Future<ApiResponse> registerAgent(String name, String email, String password ,String passwordConfirmation,String? officeName,String? officeNumber, String? phoneNumber,String? commercialRegister) async {
  ApiResponse apiResponse = ApiResponse();
  try {
  final response = await http.post(
      Uri.parse(registerURL),
      headers: {'Accept': 'application/json'},
      body: {
        'user_name': name,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
        'office_name': officeName,
        'office_number': officeNumber,
        'phone_number': phoneNumber,
        'commercial_register':   commercialRegister,
      });

  switch(response.statusCode) {
    case 200:
      apiResponse.data = UserModel.fromJson(jsonDecode(response.body)['data']);
      break;
    case 400:
      final errors = jsonDecode(response.body);
      apiResponse.error = errors[errors.keys.elementAt(0)][0];
      break;
    default:
      apiResponse.error = 'somethingWentWrong';
      break;
  }
  }
  catch (e) {
    apiResponse.error = 'serverError';
  }
  return apiResponse;
}


//Profile
Future<ApiResponse> getProfile() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String? token = await getToken();
    final response = await http.get(
        Uri.parse(profileURL),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        });
    SharedPreferences pref = await SharedPreferences.getInstance();

    switch(response.statusCode){
      case 200:
        apiResponse.data = ProfileModel.fromJson(jsonDecode(response.body));
        await pref.setString('profile', jsonEncode(apiResponse.data));
        break;
      case 401:
        apiResponse.error = 'unauthorized';
        break;
      default:
        apiResponse.error = 'somethingWentWrong';
        break;
    }
  }
  catch(e) {
    apiResponse.error = 'serverError';
  }
  return apiResponse;
}




// logout
Future<bool> logout() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  await pref.remove('user');
  await pref.remove('token');
  return true;
}

unauthorizedLogout(BuildContext context){
  logout().then((value) => {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const Login()),
            (route) => false)
  });
}




//city
Future<ApiResponse> search(String? searchText) async {
  ApiResponse apiResponse = ApiResponse();
  try {
  String? token = await getToken();
  final response = await http.post(
      Uri.parse(searchURL),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },body: {
        if(searchText != null) 'search' : searchText,
      }
      );

  switch(response.statusCode){
    case 200:
      List<CityModel> cities = (jsonDecode(response.body)['data']['cities']as List).map((city) => CityModel.fromJson(city)).toList();
      List<PlaceModel> places = (jsonDecode(response.body)['data']['places']as List).map((place) => PlaceModel.fromJson(place)).toList();
      List<TripModel> trips = (jsonDecode(response.body)['data']['packages']as List).map((trip) => TripModel.fromJson(trip)).toList();
      apiResponse.mapData = {'cities': cities,'places': places, 'trips': trips,};
      break;
    case 401:
      apiResponse.error = 'unauthorized';
      break;
    default:
      apiResponse.error = 'somethingWentWrong';
      break;
  }
  }
  catch(e) {
    apiResponse.error = 'serverError';
  }
  return apiResponse;
}


