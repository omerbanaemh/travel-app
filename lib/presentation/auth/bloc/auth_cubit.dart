// import 'package:bloc/bloc.dart';
// import 'package:meta/meta.dart';
// import 'package:yemen_travel_guid/cor/error/failures.dart';
// import 'package:yemen_travel_guid/domain/models/auth/login_model.dart';
// import 'package:yemen_travel_guid/domain/models/auth/register_model.dart';
// import 'package:yemen_travel_guid/domain/models/auth/profile_model.dart';
// import 'package:yemen_travel_guid/domain/repository/auth/auth_repository.dart';
//
//
// part 'auth_state.dart';
//
// class AuthCubit extends Cubit<AuthState> {
//   final AuthRepository repository;
//   AuthCubit({required this.repository}) : super(AuthInitial());
//
//   Future<void> login(String email, String password) async {
//     emit(LoadingAuthState());
//     final failureOrDoneMessage = await repository.login(LoginModel(email: email, password: password));
//     failureOrDoneMessage.fold(
//             (failure) => emit(LoginErrorAuthState(failure as MessageFailure)),
//             (message) => emit(LoginSuccessfullyAuthState(message: message)),
//     );
//   }
//
//   Future<void> register({
//     required String name,
//     required String email,
//     // required String phone,
//     required String password,
//     required String passwordConfirmation,
//   }) async {
//     emit(LoadingAuthState());
//     (await repository.register(RegisterModel(
//             name: name,
//             email: email,
//             password: password,
//             passwordConfirmation: passwordConfirmation,
//             // phone: phone
//     )))
//         .fold((failure) {
//       emit(RegisterErrorAuthState(failure as MessageFailure));
//     },
//             (message) => emit(RegisterSuccessfullyAuthState(message)));
//   }
//
//   Future<void>getUser() async {
//     emit(LoadingUserState());
//     final response = await repository.getUser();
//     response.fold(
//         (failure) => emit(ErrorUserState()),
//         (user) => emit(SuccessUserState(user: user))
//     );
//
//   }
// }
