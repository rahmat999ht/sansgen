// To parse this JSON data, do
//
//     final modelResponseGetComment = modelResponseGetCommentFromJson(jsonString);

import 'dart:convert';

import 'package:sansgen/model/comment/user_comment.dart';

ModelResponseGetComment modelResponseGetCommentFromJson(String str) => ModelResponseGetComment.fromJson(json.decode(str));

String modelResponseGetCommentToJson(ModelResponseGetComment data) => json.encode(data.toJson());

class ModelResponseGetComment {
  final bool status;
  final String message;
  final List<UserComment> data;

  ModelResponseGetComment({
    required this.status,
    required this.message,
    required this.data,
  });

  ModelResponseGetComment copyWith({
    bool? status,
    String? message,
    List<UserComment>? data,
  }) =>
      ModelResponseGetComment(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory ModelResponseGetComment.fromJson(Map<String, dynamic> json) => ModelResponseGetComment(
    status: json["status"],
    message: json["message"],
    data: List<UserComment>.from(json["data"].map((x) => UserComment.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}
