// import 'package:dartz/dartz.dart';
// import 'package:yemen_travel_guid/cor/error/failures.dart';
// import 'package:yemen_travel_guid/cor/strings/failure.dart';
// import 'package:yemen_travel_guid/data/trip/trip_remote_data_source.dart';
// import 'package:yemen_travel_guid/domain/models/trip/trip_model.dart';
// import 'package:yemen_travel_guid/domain/repository/trip/trip_repository.dart';
// import '../../../data/network/info/network_info.dart';
// import 'package:dio/dio.dart';
//
// class TripRepositoryImp implements TripRepository{
//   final TripRemoteDataSource remoteTripDataSource;
//   final NetworkInfo info;
//   TripRepositoryImp({ required this.info,required this.remoteTripDataSource});
//
//
//
//   @override
//   Future<Either<Failure, List<TripModel>>> getTrips() async {
//     if (await info.isConnected) {
//       try {
//         Response response = await remoteTripDataSource.getTrip();
//         print('0000000000000000000000');
//         print(response.data);
//         List<TripModel> trips = (response.data['data']as List).map((trip) => TripModel.fromJson(trip)).toList();
//         return Right(trips);
//       } on DioException catch (e) {
//         print('================================');
//         print('Error getting trips: $e');
//         print(e.response);
//         print(e.error);
//         return Left(MessageFailure.fromJson(e.response!.data));
//       }
//     } else {
//       return Left(MessageFailure(OFFLINE_FAILURE_MESSAGE));
//     }
//   }
//
//
//
// }