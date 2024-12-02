import 'dart:convert';

import '../user/user.dart';

ModelResponseLogin modelResponseLoginFromJson(String str) => ModelResponseLogin.fromJson(json.decode(str));

String modelResponseLoginToJson(ModelResponseLogin data) => json.encode(data.toJson());

class ModelResponseLogin {
  final ModelUser data;

  ModelResponseLogin({
    required this.data,
  });

  ModelResponseLogin copyWith({
    ModelUser? data,
  }) =>
      ModelResponseLogin(
        data: data ?? this.data,
      );

  factory ModelResponseLogin.fromJson(Map<String, dynamic> json) => ModelResponseLogin(
    data: ModelUser.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
  };
}
