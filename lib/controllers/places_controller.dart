import 'dart:convert';

import 'package:yemen_travel_guid/constant.dart';
import 'package:yemen_travel_guid/models/api_response.dart';
import 'package:http/http.dart' as http;
import 'package:yemen_travel_guid/models/place_model.dart';



//place
Future<ApiResponse> getPlace(int id) async {
  ApiResponse apiResponse = ApiResponse();
  try {
  String? token = await getToken();
  final response = await http.get(
      Uri.parse('$getPlacesURL/$id'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      });



  switch(response.statusCode){
    case 200:
      apiResponse.data = PlaceModel.fromJson(jsonDecode(response.body)['data']);
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



//CreateRating
Future<ApiResponse> createFavorite({
  required String placeId,
}) async {
  ApiResponse apiResponse = ApiResponse();
  try {
  String? token = await getToken();
  final response = await http.post(
      Uri.parse(createFavoriteURL),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body:{
      'place_id':placeId,
      }
  );

  switch(response.statusCode){
    case 200:
      apiResponse.data = PlaceModel.fromJson(jsonDecode(response.body)['data']);
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



//trips
Future<ApiResponse> getFavoritePlaces() async {
  ApiResponse apiResponse = ApiResponse();
  try {
  String? token = await getToken();
  final response = await http.get(
      Uri.parse(getMyFavoritesURL),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      });



  switch(response.statusCode){
    case 200:
      List<PlaceModel> cities = (jsonDecode(response.body)['data']as List).map((place) => PlaceModel.fromJson(place)).toList();
      apiResponse.data = cities;
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
