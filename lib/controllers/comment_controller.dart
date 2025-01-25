
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:yemen_travel_guid/models/api_response.dart';
import 'package:yemen_travel_guid/models/comment_model.dart';
import 'package:yemen_travel_guid/models/trip/trip_model.dart';

import '../constant.dart';


// Get post comments
// Future<ApiResponse> getComments(int cardId) async {
//   print('===================getComments==============');
//   ApiResponse apiResponse = ApiResponse();
//   try {
//     String? token = await getToken();
//     final response = await http.get(Uri.parse('$cardsURL/$cardId/comments'),
//     headers: {
//       'Accept': 'application/json',
//       'Authorization': 'Bearer $token'
//     });
//
//     switch(response.statusCode){
//       case 200:
//         // map each comments to comment model
//         apiResponse.data = jsonDecode(response.body)['comments'].map((p) => CommentModel.fromJson(p)).toList();
//         apiResponse.data as List<dynamic>;
//         break;
//       case 403:
//         apiResponse.error = jsonDecode(response.body)['message'];
//         break;
//       case 401:
//         apiResponse.error = unauthorized;
//         break;
//       default:
//         apiResponse.error = somethingWentWrong;
//         break;
//     }
//   }
//   catch (e){
//     apiResponse.error = serverError;
//   }
//   return apiResponse;
// }



// Create comment
Future<ApiResponse> createComment(String? comment, String? placeId, String? packageId) async {
  print('===================createComment==============');
  ApiResponse apiResponse = ApiResponse();
  // try {
    String? token = await getToken();
    final response = await http.post(Uri.parse(createCommentURL),
    headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    }, body: {
      'comment': comment,
      if (placeId != null) 'place_id':placeId,
      if (packageId != null) 'package_id': packageId,
    });
    print(response.body);
    switch(response.statusCode){
      case 200:
        apiResponse.data = CommentModel.fromJson(jsonDecode(response.body)['data']);
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      case 401:
        apiResponse.error = 'unauthorized';
        break;
      default:
        apiResponse.error = 'somethingWentWrong';
        break;
    }
  // }
  // catch (e){
  //   apiResponse.error = 'serverError';
  // }
  return apiResponse;
}




// Edit comment
Future<ApiResponse> editComment(int commentId, String comment) async {
  print('===================editComment==============');
  ApiResponse apiResponse = ApiResponse();
  // try {
    String? token = await getToken();
    final response = await http.put(Uri.parse('$editCommentURL/$commentId'),
    headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    }, body: {
      'comment': comment
    });

    print(response.body);

    switch(response.statusCode){
      case 200:
        apiResponse.data = CommentModel.fromJson(jsonDecode(response.body)['data']);
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      case 401:
        apiResponse.error = 'unauthorized';
        break;
      default:
        apiResponse.error = 'somethingWentWrong';
        break;
    }
  // }
  // catch (e){
  //   apiResponse.error = 'serverError';
  // }
  return apiResponse;
}



// Delete comment
Future<ApiResponse> deleteComment(int commentId) async {
  print('===================deleteComment==============');
  ApiResponse apiResponse = ApiResponse();
  // try {
    String? token = await getToken();
    final response = await http.delete(Uri.parse('$deleteCommentURL/$commentId'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        });

    switch(response.statusCode){
      case 200:
        apiResponse.data = jsonDecode(response.body)['message'];
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      case 401:
        apiResponse.error = 'unauthorized';
        break;
      default:
        apiResponse.error = 'somethingWentWrong';
        break;
    }
  // }
  // catch (e){
  //   apiResponse.error = 'serverError';
  // }
  return apiResponse;
}