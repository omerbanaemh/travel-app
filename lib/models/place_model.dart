import 'package:yemen_travel_guid/models/comment_model.dart';
import 'package:yemen_travel_guid/models/image_model.dart';

class PlaceModel {
  final int id;
  final String placeName;
  final String description;
  final double latitude;
  final double longitude;
  String? ratings;
  bool favorite;
  bool? isRating;
  List<CommentModel> comments;
  List<ImageModel> images;

  PlaceModel({
    required this.id,
    required this.placeName,
    required this.description,
    required this.latitude,
    required this.longitude,
    this.ratings,
    required this.favorite,
    this.isRating,
    required this.comments,
    required this.images,
  });

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    return PlaceModel(
      id: json['id'],
      placeName: json['place_name'],
      description: json['description'],
      latitude: double.parse(json['latitude']),
      longitude: double.parse(json['longitude']),
      ratings: json['ratings'],
      favorite: json['favorite'],
      isRating: json['is_rating'],
      comments: List<CommentModel>.from((json['comments']??[]).map((comment) => CommentModel.fromJson(comment))),
      images: List<ImageModel>.from((json['images']??[]).map((image) => ImageModel.fromJson(image))),
    );
  }
}