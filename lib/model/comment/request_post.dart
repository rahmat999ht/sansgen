import 'dart:convert';

ModelRequestPostComment modelRequestPostCommentFromJson(String str) => ModelRequestPostComment.fromJson(json.decode(str));

String modelRequestPostCommentToJson(ModelRequestPostComment data) => json.encode(data.toJson());

class ModelRequestPostComment {
  final String comment;

  ModelRequestPostComment({
    required this.comment,
  });

  ModelRequestPostComment copyWith({
    String? comment,
  }) =>
      ModelRequestPostComment(
        comment: comment ?? this.comment,
      );

  factory ModelRequestPostComment.fromJson(Map<String, dynamic> json) => ModelRequestPostComment(
    comment: json["comment"],
  );

  Map<String, dynamic> toJson() => {
    "comment": comment,
  };
}
