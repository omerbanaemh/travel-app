import 'package:yemen_travel_guid/models/trip_model.dart';

class BookingModel {
  final int id;
  final DateTime date;
  final bool status;
  final String image;
  final int userId;
  final TripModel trip;

  BookingModel({
    required this.id,
    required this.date,
    required this.status,
    required this.image,
    required this.userId,
    required this.trip,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'],
      date: DateTime.parse(json['date']),
      status: json['status'] == 1,
      image: json['image'],
      userId: json['user_id'],
      trip: TripModel.fromJson(json['package_id']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'status': status ? 1 : 0,
      'image': image,
      'user_id': userId,
      'trip': trip.toJson(),
    };
  }
}