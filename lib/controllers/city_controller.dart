import 'dart:convert';

import 'package:yemen_travel_guid/constant.dart';
import 'package:yemen_travel_guid/models/api_response.dart';
import 'package:http/http.dart' as http;
import 'package:yemen_travel_guid/models/city_model.dart';
import 'package:yemen_travel_guid/models/place_model.dart';



//place
Future<ApiResponse> getCity(int id) async {
  ApiResponse apiResponse = ApiResponse();
  // try {
  String? token = await getToken();
  final response = await http.get(
      Uri.parse('$getCitiesURL/$id'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      });

  print(response.body);

  switch(response.statusCode){
    case 200:
      apiResponse.data = CityModel.fromJson(jsonDecode(response.body)['data']);
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



//trips
Future<ApiResponse> getCities() async {
  ApiResponse apiResponse = ApiResponse();
  // try {
  String? token = await getToken();
  final response = await http.get(
      Uri.parse(getCitiesURL),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      });

  print(response.body);

  switch(response.statusCode){
    case 200:
      List<CityModel> cities = (jsonDecode(response.body)['data']as List).map((city) => CityModel.fromJson(city)).toList();
      apiResponse.data = cities;
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

