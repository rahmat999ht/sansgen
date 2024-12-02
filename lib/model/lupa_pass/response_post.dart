// To parse this JSON data, do
//
//     final modelResponsePostLupaPass = modelResponsePostLupaPassFromJson(jsonString);

import 'dart:convert';

ModelResponsePostLupaPass modelResponsePostLupaPassFromJson(String str) => ModelResponsePostLupaPass.fromJson(json.decode(str));

String modelResponsePostLupaPassToJson(ModelResponsePostLupaPass data) => json.encode(data.toJson());

class ModelResponsePostLupaPass {
  final bool status;
  final String message;

  ModelResponsePostLupaPass({
    required this.status,
    required this.message,
  });

  ModelResponsePostLupaPass copyWith({
    bool? status,
    String? message,
  }) =>
      ModelResponsePostLupaPass(
        status: status ?? this.status,
        message: message ?? this.message,
      );

  factory ModelResponsePostLupaPass.fromJson(Map<String, dynamic> json) => ModelResponsePostLupaPass(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
