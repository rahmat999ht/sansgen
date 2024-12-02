// To parse this JSON data, do
//
//     final modelRequestPostLupaPass = modelRequestPostLupaPassFromJson(jsonString);

import 'dart:convert';

ModelRequestPostLupaPass modelRequestPostLupaPassFromJson(String str) => ModelRequestPostLupaPass.fromJson(json.decode(str));

String modelRequestPostLupaPassToJson(ModelRequestPostLupaPass data) => json.encode(data.toJson());

class ModelRequestPostLupaPass {
  final String email;

  ModelRequestPostLupaPass({
    required this.email,
  });

  ModelRequestPostLupaPass copyWith({
    String? email,
  }) =>
      ModelRequestPostLupaPass(
        email: email ?? this.email,
      );

  factory ModelRequestPostLupaPass.fromJson(Map<String, dynamic> json) => ModelRequestPostLupaPass(
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
  };
}
