// import 'dart:convert';
//
// import 'package:dartz/dartz.dart';
// import 'package:yemen_travel_guid/cor/strings/failure.dart';
// import 'package:yemen_travel_guid/data/auth/auth_remote_data_source.dart';
// import 'package:dio/dio.dart';
// import 'package:yemen_travel_guid/domain/models/auth/profile_model.dart';
//
// import '../../../cor/error/failures.dart';
// import '../../../data/network/info/network_info.dart';
// import '../../models/auth/login_model.dart';
// import '../../models/auth/register_model.dart';
// import 'auth_repository.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// //Authentication Repository Implementer implements Authentication methods
// class AuthRepositoryImplementer implements AuthRepository {
//   final AuthRemoteDataSource remoteDataSource;
//   final NetworkInfo info;
//
//   AuthRepositoryImplementer({
//     required this.remoteDataSource,
//     required this.info,
//   });
//
//   @override
//   Future<Either<Failure, String>> login(LoginModel login) async {
//     SharedPreferences pref = await SharedPreferences.getInstance();
//
//     if (await info.isConnected) {
//       try {
//         Response response = await remoteDataSource.login(login);
//         await pref.setString(
//             'token', response.data['data']['token'].toString());
//         await pref.setString('user', response.data['data'].toString());
//         return Right(response.data['message'] ?? 'error');
//       } on DioException catch (e) {
//         print('pppppppppppppppppppppp2');
//         print(e.response);
//         return Left(e.response != null
//             ? MessageFailure.fromJson(e.response!.data)
//             : MessageFailure(SERVER_FAILURE_MESSAGE));
//       }
//     } else {
//       return Left(MessageFailure(OFFLINE_FAILURE_MESSAGE));
//     }
//   }
//
//   @override
//   Future<Either<Failure, String>> register(RegisterModel register) async {
//     if (await info.isConnected) {
//       //check if there is internet connection
//       try {
//         Response response = await remoteDataSource.register(register);
//         await Future.wait([
//           // preferences.setUser(response.data.user.json), //save current user
//           // preferences.setToken(response.data.token), //save token
//         ]);
//         return Right(response.data['message'] ?? 'error');
//       } on DioException catch (e) {
//         print(e);
//         print('pppppppppppppppppppppp1');
//         print(e.response);
//         print('pppppppppppppppppppppp2');
//         print(e.response!.data);
//         final errors = ApiValidation.fromJson(jsonDecode(e.response!.data));
//         return Left(MessageFailure(null, errors: errors));
//         // return Left( e.response != null ? MessageFailure.fromJson(e.response!.data) : MessageFailure('SERVER_FAILURE_MESSAGE'));
//       }
//     } else {
//       //return if there is no internet connection
//       return Left(MessageFailure(OFFLINE_FAILURE_MESSAGE));
//     }
//   }
//
//   @override
//   Future<Either<Failure, ProfileModel>> getUser() async {
//     if (await info.isConnected) {
//       try {
//         Response response = await remoteDataSource.getUser();
//         print(response.data);
//         return Right(ProfileModel.fromJson(response.data));
//       } on DioException catch (e) {
//         return Left(e.response != null
//             ? MessageFailure.fromJson(e.response!.data)
//             : MessageFailure(SERVER_FAILURE_MESSAGE));
//       }
//     } else {
//       return Left(MessageFailure(OFFLINE_FAILURE_MESSAGE));
//     }
//   }
// }
