import 'package:yemen_travel_guid/models/image_model.dart';
import 'package:yemen_travel_guid/models/place_model.dart';
import 'package:yemen_travel_guid/models/trip_model.dart';

class CityModel {
  final int id;
  final String cityName;
  final String description;
  final double latitude;
  final double longitude;
  final List<PlaceModel> places;
  final List<TripModel> trips;
  final List<ImageModel> images;

  CityModel({
    required this.id,
    required this.cityName,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.places,
    required this.trips,
    required this.images,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      id: json['id'],
      cityName: json['city_name'],
      description: json['description'],
      latitude: double.parse(json['latitude']),
      longitude: double.parse(json['longitude']),
      places: List<PlaceModel>.from((json['places']??[]).map((place) => PlaceModel.fromJson(place))),
      trips: List<TripModel>.from((json['trip_packages']??[]).map((trip) => TripModel.fromJson(trip))),
      images: List<ImageModel>.from((json['images']??[]).map((image) => ImageModel.fromJson(image))),
    );
  }
}