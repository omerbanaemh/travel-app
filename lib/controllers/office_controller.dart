
import 'dart:convert';

import 'package:yemen_travel_guid/constant.dart';
import 'package:yemen_travel_guid/models/api_response.dart';
import 'package:http/http.dart' as http;
import 'package:yemen_travel_guid/models/office.dart';
import 'package:dio/dio.dart';
import 'package:yemen_travel_guid/models/trip_model.dart';


//Office
Future<ApiResponse> getOffice() async {
  ApiResponse apiResponse = ApiResponse();
  // try {
  String? token = await getToken();
  final response = await http.get(
      Uri.parse(getMyOfficeURL),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      });

  print(response.statusCode);
  print(response.body);

  switch(response.statusCode){
    case 200:
      OfficeModel office =  OfficeModel.fromJson(jsonDecode(response.body)['data']);
      apiResponse.data = office;
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



