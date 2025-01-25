// import 'package:bloc/bloc.dart';
// import 'package:meta/meta.dart';
// import 'package:yemen_travel_guid/cor/error/failures.dart';
// import 'package:yemen_travel_guid/domain/models/trip/trip_model.dart';
// import 'package:yemen_travel_guid/domain/repository/trip/trip_repository.dart';
//
// part 'trip_state.dart';
//
// class TripCubit extends Cubit<TripState> {
//   final TripRepository tripRepository;
//
//   TripCubit({required this.tripRepository}) : super(TripInitial());
//
//
//   Future<void> retrieveTrips() async {
//     emit(LoadingTripsState());
//     var response = await tripRepository.getTrips();
//       response.fold(
//             (failure) => emit(ErrorRetrieveTripsState(failure as MessageFailure)),
//             (List<TripModel> trips) {
//               emit(SuccessRetrieveTripsState(trips:trips));
//             },
//       );
//
//
//   }
//
//
//
// }
