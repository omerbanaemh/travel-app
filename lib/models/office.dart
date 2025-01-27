import 'package:yemen_travel_guid/models/trip_model.dart';

class OfficeModel {
  final int id;
  final String officeName;
  final String officeNumber;
  final String phoneNumber;
  final String commercialRegister;
  List<TripModel> trips;
  final int userId;


  OfficeModel({
    required this.id,
    required this.officeName,
    required this.officeNumber,
    required this.phoneNumber,
    required this.commercialRegister,
    required this.trips,
    required this.userId,
  });

  factory OfficeModel.fromJson(Map<String, dynamic> json) {
    return OfficeModel(
      id: json['id'],
      officeName: json['office_name'],
      officeNumber: json['office_number'],
      phoneNumber: json['phone_number'],
      commercialRegister: json['commercial_register'],
      trips: List<TripModel>.from((json['trip_packages']??[]).map((trip)=>TripModel.fromJson(trip))),
      userId: json['user_id'],
    );
  }

}