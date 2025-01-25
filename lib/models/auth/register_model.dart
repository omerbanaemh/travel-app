class RegisterModel {
  String name;
  String email;
  String password;
  String passwordConfirmation;
  // String phone;

  RegisterModel({
    required this.email,
    required this.name,
    required this.password,
    required this.passwordConfirmation,
    // required this.phone,
  });

  //chang data to json object to send it to the api
  Future<Map<String, String>> get toJson async {
    return {
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation,
    };
  }
}
