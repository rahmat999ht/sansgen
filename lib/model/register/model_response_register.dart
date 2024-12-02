import 'dart:convert';

import 'package:sansgen/model/register/response_error_regis.dart';

import 'data_response_register.dart';

ModelResponseRegister modelResponseRegisterFromJson(String str) =>
    ModelResponseRegister.fromJson(json.decode(str));

String modelResponseRegisterToJson(ModelResponseRegister data) =>
    json.encode(data.toJson());

class ModelResponseRegister {
  final bool success;
  final String message;
  final dynamic data;

  ModelResponseRegister({
    required this.success,
    required this.message,
    this.data,
  });

  factory ModelResponseRegister.fromJson(Map<String, dynamic> json) {
    return ModelResponseRegister(
      success: json['success'],
      message: json['message'],
      data: json['success'] == true
          ? DataResponseRegister.fromJson(json['data'])
          : DataErrorRegis.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data!.toJson(),
    };
  }
}
