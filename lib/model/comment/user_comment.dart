// To parse this JSON data, do
//
//     final userCommet = userCommetFromJson(jsonString);

import 'dart:convert';

UserComment userCommetFromJson(String str) =>
    UserComment.fromJson(json.decode(str));

String userCommetToJson(UserComment data) => json.encode(data.toJson());

class UserComment {
  final int? id;
  final String? uuid;
  final String? comment;
  final String? createdAt;
  final String? timeElapsed;
  final User user;

  UserComment({
    required this.id,
    required this.uuid,
    required this.comment,
    required this.createdAt,
    required this.timeElapsed,
    required this.user,
  });

  UserComment copyWith({
    int? id,
    String? uuid,
    String? comment,
    String? createdAt,
    String? timeElapsed,
    User? user,
  }) =>
      UserComment(
        id: id ?? this.id,
        uuid: uuid ?? this.uuid,
        comment: comment ?? this.comment,
        createdAt: createdAt ?? this.createdAt,
        timeElapsed: timeElapsed ?? this.timeElapsed,
        user: user ?? this.user,
      );

  factory UserComment.fromJson(Map<String, dynamic> json) => UserComment(
        id: json["id"] ?? 0,
        uuid: json["uuid"] ?? "",
        comment: json["comment"] ?? "",
        createdAt: json["created_at"] ?? "",
        timeElapsed: json["time_elapsed"] ?? "F",
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uuid": uuid,
        "comment": comment,
        "created_at": createdAt,
        "time_elapsed": timeElapsed,
        "user": user.toJson(),
      };
}

class User {
  final int id;
  final String uuid;
  final String name;
  final String? image;

  User({
    required this.id,
    required this.uuid,
    required this.name,
    required this.image,
  });

  User copyWith({
    int? id,
    String? uuid,
    String? name,
    dynamic image,
  }) =>
      User(
        id: id ?? this.id,
        uuid: uuid ?? this.uuid,
        name: name ?? this.name,
        image: image ?? this.image,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        uuid: json["uuid"],
        name: json["name"],
        image: json["image"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uuid": uuid,
        "name": name,
        "image": image,
      };
}
