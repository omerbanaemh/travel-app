import 'dart:convert';

import 'package:yemen_travel_guid/constant.dart';
import 'package:yemen_travel_guid/models/api_response.dart';
import 'package:http/http.dart' as http;
import 'package:yemen_travel_guid/models/governorate_model.dart';





//trips
Future<ApiResponse> getGovernorates() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String? token = await getToken();
    final response = await http.get(
        Uri.parse(governoratesURL),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        });



    switch(response.statusCode){
      case 200:
        List<GovernorateModel> governorates = (jsonDecode(response.body)['data']as List).map((governorate) => GovernorateModel.fromJson(governorate)).toList();
        apiResponse.data = governorates;
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







//trip
Future<ApiResponse> getGovernorate(int id) async {
  ApiResponse apiResponse = ApiResponse();
  try {
  String? token = await getToken();
  final response = await http.get(
      Uri.parse('$governoratesURL/$id'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      });



  switch(response.statusCode){
    case 200:
      apiResponse.data = GovernorateModel.fromJson(jsonDecode(response.body)['data']);
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


