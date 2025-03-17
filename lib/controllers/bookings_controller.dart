import 'package:yemen_travel_guid/constant.dart';
import 'package:yemen_travel_guid/models/api_response.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:yemen_travel_guid/models/booking_model.dart';
import 'package:dio/dio.dart';


Future<ApiResponse> getMyBookings() async {
  ApiResponse apiResponse = ApiResponse();
  // try {
  String? token = await getToken();
  final response = await http.get(
      Uri.parse(getMyBookingsURL),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      });

  print(response.body);

  switch(response.statusCode){
    case 200:
      List<BookingModel> bookings = (jsonDecode(response.body)['data']as List).map((booking) => BookingModel.fromJson(booking)).toList();
      apiResponse.data = bookings;
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



Future<ApiResponse> getBooking(int id) async {
  ApiResponse apiResponse = ApiResponse();
  try {
  String? token = await getToken();
  final response = await http.get(
      Uri.parse('$getBookingURL/$id'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      });

  print(response.body);

  switch(response.statusCode){
    case 200:
      apiResponse.data = BookingModel.fromJson(jsonDecode(response.body)['data']);
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





//CreateTrip
Future<ApiResponse> updateBooking(int id,String status) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String? token = await getToken();
    final response = await http.post(
        Uri.parse('$getBookingURL/$id'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: {
          'status':status,
          '_method':'put',
        }
    );

    print(response.body);

    switch(response.statusCode){
      case 200:
        apiResponse.data = BookingModel.fromJson(jsonDecode(response.body)['data']);
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