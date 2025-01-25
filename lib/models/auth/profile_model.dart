class ProfileModel {
  final int id;
  final String userName;
  final String email;
  final String? emailVerifiedAt;

  ProfileModel({
    required this.id,
    required this.userName,
    required this.email,
    this.emailVerifiedAt,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'],
      userName: json['user_name'],
      email: json['email'],
      emailVerifiedAt: json['email_verified_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_name': userName,
      'email': email,
      'email_verified_at': emailVerifiedAt,
    };
  }
}