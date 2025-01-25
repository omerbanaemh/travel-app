import 'package:yemen_travel_guid/models/comment_model.dart';

class PlaceModel {
  final int id;
  final String placeName;
  final String description;
  final double latitude;
  final double longitude;
  final String? ratings;
  List<CommentModel> comments;

  PlaceModel({
    required this.id,
    required this.placeName,
    required this.description,
    required this.latitude,
    required this.longitude,
    this.ratings,
    required this.comments,
  });

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    return PlaceModel(
      id: json['id'],
      placeName: json['place_name'],
      description: json['description'],
      latitude: double.parse(json['latitude']),
      longitude: double.parse(json['longitude']),
      ratings: json['ratings'],
      comments: List<CommentModel>.from((json['comments']??[]).map((comment) => CommentModel.fromJson(comment))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'place_name': placeName,
      'description': description,
      'latitude': latitude.toString(),
      'longitude': longitude.toString(),
    };
  }
}