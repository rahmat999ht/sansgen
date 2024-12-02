// import 'package:json/json.dart';
//
// @JsonCodable()
class ModelReqestLogin {
  final String email;
  final String password;

  ModelReqestLogin({
    required this.email,
    required this.password,
  });

  factory ModelReqestLogin.fromJson(Map<String, dynamic> json) {
    return ModelReqestLogin(
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}
