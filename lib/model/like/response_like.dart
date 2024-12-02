// To parse this JSON data, do
//
//     final modelResponseLikeBook = modelResponseLikeBookFromJson(jsonString);

import 'dart:convert';

import 'data_like.dart';

ModelResponseGetLike modelResponseGetLikeFromJson(String str) => ModelResponseGetLike.fromJson(json.decode(str));

String modelResponseGetLikeToJson(ModelResponseGetLike data) => json.encode(data.toJson());

class ModelResponseGetLike {
  final bool status;
  final String message;
  final List<UserLike> data;

  ModelResponseGetLike({
    required this.status,
    required this.message,
    required this.data,
  });

  ModelResponseGetLike copyWith({
    bool? status,
    String? message,
    List<UserLike>? data,
  }) =>
      ModelResponseGetLike(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory ModelResponseGetLike.fromJson(Map<String, dynamic> json) => ModelResponseGetLike(
    status: json["status"],
    message: json["message"],
    data: List<UserLike>.from(json["data"].map((x) => UserLike.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}
