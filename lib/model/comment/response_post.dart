// To parse this JSON data, do
//
//     final modelResponsePostComment = modelResponsePostCommentFromJson(jsonString);

import 'dart:convert';

import 'package:sansgen/model/comment/user_comment.dart';

ModelResponsePostComment modelResponsePostCommentFromJson(String str) => ModelResponsePostComment.fromJson(json.decode(str));

String modelResponsePostCommentToJson(ModelResponsePostComment data) => json.encode(data.toJson());

class ModelResponsePostComment {
  final UserComment data;

  ModelResponsePostComment({
    required this.data,
  });

  ModelResponsePostComment copyWith({
    UserComment? data,
  }) =>
      ModelResponsePostComment(
        data: data ?? this.data,
      );

  factory ModelResponsePostComment.fromJson(Map<String, dynamic> json) => ModelResponsePostComment(
    data: UserComment.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
  };
}
