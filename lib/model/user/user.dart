// To parse this JSON data, do
//
//     final modelUser = modelUserFromJson(jsonString);

import 'dart:convert';

ModelUser modelUserFromJson(String str) => ModelUser.fromJson(json.decode(str));

String modelUserToJson(ModelUser data) => json.encode(data.toJson());

class ModelUser {
  final int id;
  final String uuid;
  final String email;
  final String name;
  final String? image;
  final String? dateOfBirth;
  final String? rangeAge;
  final String? gender;
  final String? hobby;
  final List<String> categories;
  final String isPremium;
  final String token;

  ModelUser({
    required this.id,
    required this.uuid,
    required this.email,
    required this.name,
    required this.image,
    required this.dateOfBirth,
    required this.rangeAge,
    required this.gender,
    required this.hobby,
    required this.categories,
    required this.isPremium,
    required this.token,
  });

  ModelUser copyWith({
    int? id,
    String? uuid,
    String? email,
    String? name,
    String? image,
    String? dateOfBirth,
    String? rangeAge,
    String? gender,
    String? hobby,
    List<String>? categories,
    String? isPremium,
    String? token,
  }) =>
      ModelUser(
        id: id ?? this.id,
        uuid: uuid ?? this.uuid,
        email: email ?? this.email,
        name: name ?? this.name,
        image: image ?? this.image,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        rangeAge: rangeAge ?? this.rangeAge,
        gender: gender ?? this.gender,
        hobby: hobby ?? this.hobby,
        categories: categories ?? this.categories,
        isPremium: isPremium ?? this.isPremium,
        token: token ?? this.token,
      );

  factory ModelUser.fromJson(Map<String, dynamic> json) => ModelUser(
    id: json["id"],
    uuid: json["uuid"],
    email: json["email"],
    name: json["name"],
    image: json["image"] ?? "",
    dateOfBirth: json["dateOfBirth"] ?? "",
    rangeAge: json["rangeAge"] ?? "",
    gender: json["gender"] ?? "",
    hobby: json["hobby"] ?? "",
    categories: List<String>.from(json["categories"].map((x) => x)),
    isPremium: json["isPremium"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "email": email,
    "name": name,
    "image": image,
    "dateOfBirth": dateOfBirth,
    "rangeAge": rangeAge,
    "gender": gender,
    "hobby": hobby,
    "categories": List<dynamic>.from(categories.map((x) => x)),
    "isPremium": isPremium,
    "token": token,
  };
}
