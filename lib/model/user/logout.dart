// To parse this JSON data, do
//
//     final modelResponsePostLogOut = modelResponsePostLogOutFromJson(jsonString);

import 'dart:convert';

ModelResponsePostLogOut modelResponsePostLogOutFromJson(String str) => ModelResponsePostLogOut.fromJson(json.decode(str));

String modelResponsePostLogOutToJson(ModelResponsePostLogOut data) => json.encode(data.toJson());

class ModelResponsePostLogOut {
  final bool success;
  final String message;

  ModelResponsePostLogOut({
    required this.success,
    required this.message,
  });

  ModelResponsePostLogOut copyWith({
    bool? success,
    String? message,
  }) =>
      ModelResponsePostLogOut(
        success: success ?? this.success,
        message: message ?? this.message,
      );

  factory ModelResponsePostLogOut.fromJson(Map<String, dynamic> json) => ModelResponsePostLogOut(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}
