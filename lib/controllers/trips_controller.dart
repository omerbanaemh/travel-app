import 'dart:convert';

import 'package:yemen_travel_guid/constant.dart';
import 'package:yemen_travel_guid/models/api_response.dart';
import 'package:http/http.dart' as http;
import 'package:yemen_travel_guid/models/trip/trip_model.dart';
import 'package:dio/dio.dart';




//trips
Future<ApiResponse> getTrips() async {
  ApiResponse apiResponse = ApiResponse();
  // try {
    String? token = await getToken();
    final response = await http.get(
        Uri.parse(getTripsURL),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        });

      print(response.body);

    switch(response.statusCode){
      case 200:
        List<TripModel> trips = (jsonDecode(response.body)['data']as List).map((trip) => TripModel.fromJson(trip)).toList();
        apiResponse.data = trips;
        break;
      case 401:
        apiResponse.error = 'unauthorized';
        break;
      default:
        apiResponse.error = 'somethingWentWrong';
        break;
    }
  // }
  // catch(e) {
  //   apiResponse.error = 'serverError';
  // }
  return apiResponse;
}







//trip
Future<ApiResponse> getTrip(int id) async {
  ApiResponse apiResponse = ApiResponse();
  // try {
  String? token = await getToken();
  final response = await http.get(
      Uri.parse('$getTripsURL/$id'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      });

  print(response.body);

  switch(response.statusCode){
    case 200:
      apiResponse.data = TripModel.fromJson(jsonDecode(response.body)['data']);
      break;
    case 401:
      apiResponse.error = 'unauthorized';
      break;
    default:
      apiResponse.error = 'somethingWentWrong';
      break;
  }
  // }
  // catch(e) {
  //   apiResponse.error = 'serverError';
  // }
  return apiResponse;
}


//CreateBooking
Future<ApiResponse> createBooking(MultipartFile? image,  int id) async {
  ApiResponse apiResponse = ApiResponse();
  // try {
  String? token = await getToken();
  Dio dio = Dio();
  dio.options=BaseOptions(
    headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    },
    validateStatus: (status) {
      return status! < 500;
    },
  );
  final response = await dio.post(createBookingURL,
    data: FormData.fromMap({
      'image' : image,
      'package_id': id,
    }),
  );




  print(response.data);

  switch(response.statusCode){
    case 200:
      apiResponse.message = response.data['message'];
      break;
      case 409:
      apiResponse.error = response.data['message'];
      break;
    case 401:
      apiResponse.error = 'unauthorized';
      break;
    default:
      apiResponse.error = 'somethingWentWrong';
      break;
  }
  // }
  // catch(e) {
  //   apiResponse.error = 'serverError';
  // }
  return apiResponse;
}



//CreateRating
Future<ApiResponse> createRating(String rating , String? tripId, String? placeId) async {
  ApiResponse apiResponse = ApiResponse();
  // try {
  String? token = await getToken();
  final response = await http.post(
      Uri.parse(ratingURL),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body:{
        'rating':rating,
        if (tripId != null)'package_id':tripId,
        if(placeId != null) 'place_id':placeId,
      }
      );

  print(response.body);

  switch(response.statusCode){
    case 200:
      apiResponse.message = jsonDecode(response.body)['message'] ;
      break;
    case 401:
      apiResponse.error = 'unauthorized';
      break;
    default:
      apiResponse.error = 'somethingWentWrong';
      break;
  }
  // }
  // catch(e) {
  //   apiResponse.error = 'serverError';
  // }
  return apiResponse;
}