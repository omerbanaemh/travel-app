class UserModel {
  final int id;
  final String? token;
  final String userName;
  final String email;
  final String? emailVerifiedAt;
  final String? officeName;
  final String? role;


  UserModel({
    required this.id,
    this.token,
    required this.userName,
    required this.email,
    this.emailVerifiedAt,
    this.officeName,
    this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      token: json['token'],
      userName: json['user_name'],
      email: json['email'],
      emailVerifiedAt: json['email_verified_at'],
      officeName: json['office_name'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'token': token,
      'user_name': userName,
      'email': email,
      'email_verified_at': emailVerifiedAt,
      'office_name': officeName,
      'role': role,
    };
  }
}