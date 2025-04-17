import 'package:yemen_travel_guid/models/auth/profile_model.dart';

class CommentModel {
  int id;
  String comment;
  final int? packageId;
  final int? placeId;
  ProfileModel user;
  String? createdAt;
  String? updatedAt;


  CommentModel({
    this.packageId,
    this.placeId,
    required this.id,
    required this.comment,
    this.createdAt,
    this.updatedAt,
    required this.user,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'],
      comment: json['comment'],
      packageId: json['package_id'],
      placeId: json['place_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      user: ProfileModel.fromJson(json['user']),
    );
  }
}

