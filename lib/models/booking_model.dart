import 'package:yemen_travel_guid/models/auth/user_model.dart';
import 'package:yemen_travel_guid/models/trip_model.dart';

class BookingModel {
  final int id;
  final DateTime date;
  final String status;
  final String image;
  final UserModel user;
  final TripModel trip;

  BookingModel({
    required this.id,
    required this.date,
    required this.status,
    required this.image,
    required this.user,
    required this.trip,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'],
      date: DateTime.parse(json['date']),
      status: json['status'],
      image: json['image'],
      user: UserModel.fromJson(json['user']),
      trip: TripModel.fromJson(json['package_id']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'status': status,
      'image': image,
      'user_id': user,
      'trip': trip.toJson(),
    };
  }
}