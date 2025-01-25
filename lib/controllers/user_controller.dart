import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:yemen_travel_guid/constant.dart';
import 'package:yemen_travel_guid/models/api_response.dart';
import 'package:yemen_travel_guid/models/auth/profile_model.dart';
import 'package:yemen_travel_guid/models/auth/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yemen_travel_guid/views/screens/users/login.dart';


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
  print('=======================login =================');
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
  print('=======================register =================');
  ApiResponse apiResponse = ApiResponse();
  // try {
  final response = await http.post(
      Uri.parse(registerURL),
      headers: {'Accept': 'application/json'},
      body: {
        'user_name': name,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
      });
  print(response.body);
  switch(response.statusCode) {
    case 200:
      // apiResponse.data = UserModel.fromJson(jsonDecode(response.body));
      break;
    case 422:
      final errors = jsonDecode(response.body)['errors'];
      apiResponse.error = errors[errors.keys.elementAt(0)][0];
      break;
    default:
      apiResponse.error = 'somethingWentWrong';
      break;
  }
  // }
  // catch (e) {
  //   apiResponse.error = 'serverError';
  // }
  return apiResponse;
}



//RegisterAgent
Future<ApiResponse> registerAgent(String name, String email, String password ,String passwordConfirmation,String? officeName,String? officeNumber, String? phoneNumber,String? commercialRegister) async {
  print('=======================register =================');
  ApiResponse apiResponse = ApiResponse();
  // try {
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
  print(response.body);
  switch(response.statusCode) {
    case 200:
      // apiResponse.data = UserModel.fromJson(jsonDecode(response.body));
      break;
    case 422:
      final errors = jsonDecode(response.body)['errors'];
      apiResponse.error = errors[errors.keys.elementAt(0)][0];
      break;
    default:
      apiResponse.error = 'somethingWentWrong';
      break;
  }
  // }
  // catch (e) {
  //   apiResponse.error = 'serverError';
  // }
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

    print(response.body);
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


//
// // Users
// Future<ApiResponse> getAllUsers(int pageNumber, String? search) async {
//   print('=======================getAllUsers =================');
//   ApiResponse apiResponse = ApiResponse();
//   try {
//     String? token = await getToken();
//     final response;
//     if (search != null) {
//        response = await http.get(
//            Uri.parse('$usersURL?page=$pageNumber &search=$search'),
//           headers: {
//             'Accept': 'application/json',
//             'Authorization': 'Bearer $token'
//           });
//     }else{
//        response = await http.get(
//           Uri.parse('$usersURL?page=$pageNumber'),
//           headers: {
//             'Accept': 'application/json',
//             'Authorization': 'Bearer $token'
//           });
//     }
//
//     switch(response.statusCode){
//       case 200:
//         apiResponse.data = jsonDecode(response.body)['users']['data'].map((p) => UserModel.fromJson(p)).toList();
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
//
//
// Future<ApiResponse> getFreeUsers(int pageNumber) async {
//   print('=======================getFreeUsers =================');
//   ApiResponse apiResponse = ApiResponse();
//   try {
//   String? token = await getToken();
//   final response = await http.get(
//       Uri.parse('$freeUsersURL?page=$pageNumber'),
//       headers: {
//         'Accept': 'application/json',
//         'Authorization': 'Bearer $token'
//       });
//
//   switch(response.statusCode){
//     case 200:
//       apiResponse.data = jsonDecode(response.body)['users']['data'].map((p) => UserModel.fromJson(p)).toList();
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
//
//
//
// Future<ApiResponse> getBusyUsers(int pageNumber) async {
//   print('=======================getBusyUsers =================');
//   ApiResponse apiResponse = ApiResponse();
//   try {
//   String? token = await getToken();
//   final response = await http.get(
//       Uri.parse('$busyUsersURL?page=$pageNumber'),
//       headers: {
//         'Accept': 'application/json',
//         'Authorization': 'Bearer $token'
//       });
//
//   switch(response.statusCode){
//     case 200:
//       apiResponse.data = jsonDecode(response.body)['users']['data'].map((p) => UserModel.fromJson(p)).toList();
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
//
// // Users by boardId
// Future<ApiResponse> getBoardUsers(boardId) async {
//   print('======================getBoardUsers================');
//   ApiResponse apiResponse = ApiResponse();
//   try {
//   String? token = await getToken();
//   final response = await http.get(
//       Uri.parse('$baseURL/board/$boardId/users'),
//       headers: {
//         'Accept': 'application/json',
//         'Authorization': 'Bearer $token'
//       });
//
//   switch(response.statusCode){
//     case 200:
//       apiResponse.data = jsonDecode(response.body)['board_users'].map((p) => UsersB.fromJson(p)).toList();
//       apiResponse.data as List<dynamic>;
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
//
// // Users by boardId
// Future<ApiResponse> getCardUsers(cardId) async {
//   print('======================getCardUsers================');
//   ApiResponse apiResponse = ApiResponse();
//   try {
//   String? token = await getToken();
//   final response = await http.get(
//       Uri.parse('$baseURL/card/$cardId/users'),
//       headers: {
//         'Accept': 'application/json',
//         'Authorization': 'Bearer $token'
//       });
//   switch(response.statusCode){
//     case 200:
//       apiResponse.data = jsonDecode(response.body)['card_users'].map((p) => UserModel.fromJson(p)).toList();
//       apiResponse.data as List<dynamic>;
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
//
//
// // User
// Future<ApiResponse> getUserDetail() async {
//   print('=======================getUserDetail =================');
//   ApiResponse apiResponse = ApiResponse();
//   try {
//     String? token = await getToken();
//     final response = await http.get(
//       Uri.parse(userURL),
//       headers: {
//         'Accept': 'application/json',
//         'Authorization': 'Bearer $token'
//       });
//     SharedPreferences pref = await SharedPreferences.getInstance();
//
//     switch(response.statusCode){
//       case 200:
//         apiResponse.data = UserModel.fromJson(jsonDecode(response.body));
//         await pref.setString('user', jsonEncode(apiResponse.data));
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
//
// Future<ApiResponse> getUserDetail2(int userId) async {
//   print('=======================getUserDetail2 =================');
//   ApiResponse apiResponse = ApiResponse();
//   try {
//     String? token = await getToken();
//     final response = await http.get(
//         Uri.parse('$userURL/$userId'),
//         headers: {
//           'Accept': 'application/json',
//           'Authorization': 'Bearer $token'
//         });
//     switch(response.statusCode){
//       case 200:
//         apiResponse.data = UserModel.fromJson(jsonDecode(response.body));
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
//
// // Update user
// Future<ApiResponse> updateUser({required int id, String? name,String? email, MultipartFile? image, String? stats, String? tokenMessaging}) async {
//   print('=======================updateUser =================');
//   ApiResponse apiResponse = ApiResponse();
//   Map<String, dynamic> data ={};
//   if(name != null) data.addAll({"name":name});
//   if(email != null) data.addAll({"email":email});
//   if(image!=null) data.addAll({"image": image});
//   if(stats != null) data.addAll({"stats":stats});
//   if(tokenMessaging != null) data.addAll({"tokenMessaging":tokenMessaging});
//
//
//   try {
//
//     String? token = await getToken();
//
//     Dio dio = Dio();
//     dio.options=BaseOptions(
//       headers: {
//         'Accept': 'application/json',
//         'Authorization': 'Bearer $token'
//       },
//     );
//     final response = await dio.post(
//       '$userURL/$id',
//       data: FormData.fromMap(data),
//     );
//
//
//       // user can update his/her name or name and image
//     switch(response.statusCode) {
//       case 200:
//         apiResponse.data = UserModel.fromJson(response.data['user']);
//         apiResponse.message = response.data['message'];
//         break;
//       case 401:
//         apiResponse.error = unauthorized;
//         break;
//       default:
//         apiResponse.error = somethingWentWrong;
//         break;
//     }
//   }
//   catch (e) {
//     apiResponse.error = serverError;
//   }
//   return apiResponse;
// }
//
// // delete user
// Future<ApiResponse> deleteUser({required int id,}) async {
//   print('=======================deleteUser =================');
//   ApiResponse apiResponse = ApiResponse();
//   try {
//     String? token = await getToken();
//     final response = await http.delete(
//       Uri.parse('$userURL/$id'),
//       headers: {
//         'Accept': 'application/json',
//         'Authorization': 'Bearer $token'
//       },
//     );
//
//     switch(response.statusCode) {
//       case 200:
//         apiResponse.data =jsonDecode(response.body)['message'];
//         break;
//       case 401:
//         apiResponse.error = unauthorized;
//         break;
//       default:
//         apiResponse.error = somethingWentWrong;
//         break;
//     }
//   }
//   catch (e) {
//     apiResponse.error = serverError;
//   }
//   return apiResponse;
// }
//
//
//
// // Update user
// Future<ApiResponse> deleteUserImage({required int id,}) async {
//   print('=======================deleteUserImage =================');
//   ApiResponse apiResponse = ApiResponse();
//   try {
//   String? token = await getToken();
//   final response = await http.put(
//     Uri.parse('$userURL/image/$id'),
//     headers: {
//       'Accept': 'application/json',
//       'Authorization': 'Bearer $token'
//     },
//   );
//
//   switch(response.statusCode) {
//     case 200:
//       apiResponse.data =UserModel.fromJson(jsonDecode(response.body)['user']) ;
//       apiResponse.message =jsonDecode(response.body)['message'];
//       break;
//     case 401:
//       apiResponse.error = unauthorized;
//       break;
//     default:
//       apiResponse.error = somethingWentWrong;
//       break;
//   }
//   }
//   catch (e) {
//     apiResponse.error = serverError;
//   }
//   return apiResponse;
// }
//
//
// // get token
// Future<String?> getToken() async {
//   SharedPreferences pref = await SharedPreferences.getInstance();
//   return pref.getString('token');
// }
//
//
// // get user id
// Future<int> getUserId() async {
//   SharedPreferences pref = await SharedPreferences.getInstance();
//   return pref.getInt('userId') ?? 0;
// }
//
//
//
//
// // get user
// Future<UserModel?> getSharedPreferencesUser() async {
//   SharedPreferences pref = await SharedPreferences.getInstance();
//   String? result = pref.getString('user');
//   if(result != null) {
//     return UserModel.fromJson(jsonDecode(result!));
//   }
//   return null;
// }
//
//
// // Future<UserModel?> get sharedPreferencesUser async {
// //   SharedPreferences pref = await SharedPreferences.getInstance();
// //   String? result = pref.getString('user');
// //   if (result != null) {
// //     return UserModel.fromJson(jsonDecode(result));
// //   }
// //   return null;
// // }
//
//
//
//
//






//
//
// // Get base64 encoded image
// String? getStringImage(file) {
//   if (file == null) return null ;
//   if(kIsWeb) return base64Encode(file);
//   return base64Encode(file.readAsBytesSync());
// }
//
//
// // // Get base64 encoded image
// // Future<String?> getStringImage(file) async{
// //   if (file == null) return null ;
// //   if(kIsWeb) return base64Encode(await file.readAsBytes());
// //   return base64Encode(file.readAsBytesSync());
// // }
//
// Future<ApiResponse> emailVerification(String email,String code,) async {
//   print('=======================emailVerification =================');
//   ApiResponse apiResponse = ApiResponse();
//   try {
//     String? token = await getToken();
//     final response = await http.post(
//         Uri.parse('$baseURL/email-verification'),
//         headers: {
//           'Accept': 'application/json',
//           'Authorization': 'Bearer $token'
//         },
//         body: {
//           'email': email,
//           'otp': code,
//         });
//
//     switch(response.statusCode) {
//       case 200:
//         apiResponse.data = UserModel.fromJson(jsonDecode(response.body));
//         // apiResponse.data =jsonDecode(response.body)['success'];
//         break;
//       case 401:
//         final errors = jsonDecode(response.body)['errors'];
//         apiResponse.error = errors[errors.keys.elementAt(1)];
//         break;
//       case 422:
//         final errors = jsonDecode(response.body)['errors'];
//         apiResponse.error = errors[errors.keys.elementAt(0)][0];
//         break;
//       default:
//         apiResponse.error = somethingWentWrong;
//         break;
//     }
//   }
//   catch (e) {
//     apiResponse.error = serverError;
//   }
//   return apiResponse;
// }
//
//
// Future<ApiResponse> sendEmailVerification() async {
//   print('=======================sendEmailVerification =================');
//   ApiResponse apiResponse = ApiResponse();
//   try {
//   String? token = await getToken();
//   final response = await http.get(
//       Uri.parse('$baseURL/email-verification'),
//       headers: {
//         'Accept': 'application/json',
//         'Authorization': 'Bearer $token'
//       },
// );
//
//
//   switch(response.statusCode) {
//     case 200:
//     // apiResponse.data = UserModel.fromJson(jsonDecode(response.body));
//       apiResponse.data =jsonDecode(response.body)['message'];
//       break;
//     case 422:
//       final errors = jsonDecode(response.body)['errors'];
//       apiResponse.error = errors[errors.keys.elementAt(0)][0];
//       break;
//     default:
//       apiResponse.error = somethingWentWrong;
//       break;
//   }
//   }
//   catch (e) {
//     apiResponse.error = serverError;
//   }
//   return apiResponse;
// }
//
// //send code for forgetPassword
// Future<ApiResponse> forgetPassword(email) async {
//   print('=======================forgetPassword =================');
//   ApiResponse apiResponse = ApiResponse();
//   try {
//   String? token = await getToken();
//   final response = await http.post(
//     Uri.parse('$baseURL/password/forget-password'),
//     headers: {
//       'Accept': 'application/json',
//       'Authorization': 'Bearer $token'
//     },
//     body: {
//       'email': email
//     }
//   );
//
//   switch(response.statusCode) {
//     case 200:
//     // apiResponse.data = UserModel.fromJson(jsonDecode(response.body));
//       apiResponse.data =jsonDecode(response.body)['message'];
//       break;
//     case 422:
//       final errors = jsonDecode(response.body)['errors'];
//       apiResponse.error = errors[errors.keys.elementAt(0)][0];
//       break;
//     default:
//       apiResponse.error = somethingWentWrong;
//       break;
//   }
//   }
//   catch (e) {
//     apiResponse.error = serverError;
//   }
//   return apiResponse;
// }
//
//
// Future<ApiResponse> otpResetPassword(String email,String code,) async {
//   print('=======================otpResetPassword =================');
//   ApiResponse apiResponse = ApiResponse();
//   try {
//   String? token = await getToken();
//   final response = await http.post(
//       Uri.parse('$baseURL/password/otp'),
//       headers: {
//         'Accept': 'application/json',
//         'Authorization': 'Bearer $token'
//       },
//       body: {
//         'email': email,
//         'otp': code,
//       });
//
//   switch(response.statusCode) {
//     case 200:
//       // return response.statusCode;
//       apiResponse.data =jsonDecode(response.body)['success'];
//       break;
//     case 401:
//       final errors = jsonDecode(response.body)['error'];
//       apiResponse.error = errors[errors.keys.elementAt(1)];
//       break;
//     default:
//       apiResponse.error = somethingWentWrong;
//       break;
//   }
//   }
//   catch (e) {
//     apiResponse.error = serverError;
//   }
//   return apiResponse;
// }
//
//
// Future<ApiResponse> resetPassword({required String email, required String password,}) async {
//   print('=======================resetPassword =================');
//   ApiResponse apiResponse = ApiResponse();
//   try {
//   String? token = await getToken();
//   final response = await http.post(
//       Uri.parse('$baseURL/password/reset'),
//       headers: {
//         'Accept': 'application/json',
//         'Authorization': 'Bearer $token'
//       },
//       body: {
//         'email': email,
//         'password': password,
//       });
//   switch(response.statusCode) {
//     case 200:
//       // apiResponse.data = UserModel.fromJson(jsonDecode(response.body));
//       apiResponse.data =jsonDecode(response.body)['message'];
//       break;
//     case 422:
//       final errors = jsonDecode(response.body)['errors'];
//       apiResponse.error = errors[errors.keys.elementAt(0)][0];
//       break;
//     default:
//       apiResponse.error = somethingWentWrong;
//       break;
//   }
//   }
//   catch (e) {
//     apiResponse.error = serverError;
//   }
//   return apiResponse;
// }
