import 'dart:convert';

import '../user/user.dart';

ModelResponseUser modelResponseUserFromJson(String str) =>
    ModelResponseUser.fromJson(json.decode(str));

String modelResponseUserToJson(ModelResponseUser data) =>
    json.encode(data.toJson());

class ModelResponseUser {
  final ModelUser? data;

  ModelResponseUser({
    required this.data,
  });

  ModelResponseUser copyWith({
    ModelUser? data,
  }) =>
      ModelResponseUser(
        data: data ?? this.data,
      );

  factory ModelResponseUser.fromJson(Map<String, dynamic> json) =>
      ModelResponseUser(
        data: json["data"] == null
            ? ModelUser.fromJson({})
            : ModelUser.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
      };
}
