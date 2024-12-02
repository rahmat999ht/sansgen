// import 'package:json/json.dart';
//
// @JsonCodable()
class DataResponseRegister {
  final String token;
  final String name;
  final String email;

  DataResponseRegister({
    required this.token,
    required this.name,
    required this.email,
  });

  factory DataResponseRegister.fromJson(Map<String, dynamic> json) {
    return DataResponseRegister(
      token: json['token'],
      name: json['name'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'name': name,
      'email': email,
    };
  }
}
