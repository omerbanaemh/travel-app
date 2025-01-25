class LoginModel {
  String email;
  String password;

  LoginModel({required this.email, required this.password});

  //chang data to json object to send it to the api
  Future<Map<String, String>> get toJson async {
    return {
      'email': email,
      'password': password,
    };
  }
}
