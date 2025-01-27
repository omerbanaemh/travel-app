import 'package:yemen_travel_guid/models/comment_model.dart';

class TripModel {
  final int id;
  final String name;
  final String subTitle;
  final String image;
  final String description;
  final String tripContent;
  final String itinerary;
  final String price;
  final String? ratings;
  List<CommentModel> comments;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  TripModel({
    required this.id,
    required this.name,
    required this.subTitle,
    required this.image,
    required this.description,
    required this.tripContent,
    required this.itinerary,
    required this.price,
     this.ratings,
    required this.comments,
    this.createdAt,
    this.updatedAt,
  });

  factory TripModel.fromJson(Map<String, dynamic> json) {
    return TripModel(
      id: json['id'],
      name: json['name'],
      subTitle: json['sub_title'],
      image: json['image'],
      description: json['description'],
      tripContent: json['trip_content'],
      itinerary: json['itinerary'],
      price: json['price'],
      ratings: json['ratings'],
      comments: List<CommentModel>.from((json['comments']??[]).map((comment) => CommentModel.fromJson(comment))),
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'sub_title': subTitle,
      'image': image,
      'description': description,
      'trip_content': tripContent,
      'itinerary': itinerary,
      'price': price,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}