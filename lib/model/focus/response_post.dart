// To parse this JSON data, do
//
//     final modelResponsePostFocus = modelResponsePostFocusFromJson(jsonString);

import 'dart:convert';

ModelResponsePostFocus modelResponsePostFocusFromJson(String str) => ModelResponsePostFocus.fromJson(json.decode(str));

String modelResponsePostFocusToJson(ModelResponsePostFocus data) => json.encode(data.toJson());

class ModelResponsePostFocus {
  final DataResponsePost data;

  ModelResponsePostFocus({
    required this.data,
  });

  ModelResponsePostFocus copyWith({
    DataResponsePost? data,
  }) =>
      ModelResponsePostFocus(
        data: data ?? this.data,
      );

  factory ModelResponsePostFocus.fromJson(Map<String, dynamic> json) => ModelResponsePostFocus(
    data: DataResponsePost.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
  };
}

class DataResponsePost {
  final int id;
  final String uuid;
  final String readings;
  final int manyBooks;
  final String focus;
  final User? user;

  DataResponsePost({
    required this.id,
    required this.uuid,
    required this.readings,
    required this.manyBooks,
    required this.focus,
     this.user,
  });

  DataResponsePost copyWith({
    int? id,
    String? uuid,
    String? readings,
    int? manyBooks,
    String? focus,
    User? user,
  }) =>
      DataResponsePost(
        id: id ?? this.id,
        uuid: uuid ?? this.uuid,
        readings: readings ?? this.readings,
        manyBooks: manyBooks ?? this.manyBooks,
        focus: focus ?? this.focus,
        user: user ?? this.user,
      );

  factory DataResponsePost.fromJson(Map<String, dynamic> json) => DataResponsePost(
    id: json["id"],
    uuid: json["uuid"],
    readings: json["readings"],
    manyBooks: json["manyBooks"],
    focus: json["focus"],
    // user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "readings": readings,
    "manyBooks": manyBooks,
    "focus": focus,
    // "user": user.toJson(),
  };
}

class User {
  final int id;
  final String uuid;
  final String name;

  User({
    required this.id,
    required this.uuid,
    required this.name,
  });

  User copyWith({
    int? id,
    String? uuid,
    String? name,
  }) =>
      User(
        id: id ?? this.id,
        uuid: uuid ?? this.uuid,
        name: name ?? this.name,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    uuid: json["uuid"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "name": name,
  };
}
