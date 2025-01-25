// import 'package:dio/dio.dart';
// import 'package:http/http.dart'as http;
// import 'package:yemen_travel_guid/domain/models/auth/login_model.dart';
// import 'package:yemen_travel_guid/domain/models/auth/register_model.dart';
//
// import '../../../constant.dart';
//
// abstract class AuthRemoteDataSource{
//   Future<dynamic> login(LoginModel login);
//   Future<dynamic> register(RegisterModel register);
//   Future<dynamic> getUser();
// }
//
// class AuthRemoteDataSourceImpl implements AuthRemoteDataSource{
//   final http.Client client;
//   final dio = Dio();
//
//   AuthRemoteDataSourceImpl({required this.client});
//
//   @override
//   Future<dynamic> login (LoginModel login) async {
//
//     final response = await dio.post(loginURL,
//         options: Options(headers: {'Accept': 'application/json'}),
//         data: {'email': login.email , 'password': login.password}
//     );
//     return Future.value(response);
//
//   }
//
//   Future<dynamic> register (RegisterModel register) async {
//     print(register.name);
//     print(register.email);
//     print(register.password);
//     print(register.passwordConfirmation);
//     // print(register.phone);
//     print('==============t=');
//     Response response = await dio.post(registerURL,
//         options: Options(headers: {'Accept': 'application/json'}),
//         data: {
//           'user_name': register.name ,
//           'email': register.email,
//           'password': register.password,
//           'password_confirmation': register.passwordConfirmation,
//     }
//     );
// print('ppppppppppppppppppppppp');
//     print(response.data);
//     return Future.value(response);
//
//   }
//
//   @override
//   Future getUser() async {
//     final String? token = await getToken();
//     final response = await dio.get(profileURL,
//     options: Options(
//         headers: {
//           'Accept': 'application/json',
//           'Authorization': 'Bearer $token'
//         }
//
//     ));
//     return Future.value(response);
//   }
//
// }
