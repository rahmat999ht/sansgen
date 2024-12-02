// import 'package:json/json.dart';
//
// @JsonCodable()
class ModelReqestRegister {
  final String name;
  final String email;
  final String password;

  ModelReqestRegister({
    required this.name,
    required this.email,
    required this.password,
  });

  factory ModelReqestRegister.fromJson(Map<String, dynamic> json) {
    return ModelReqestRegister(
      name: json['name'],
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
    };
  }
}
