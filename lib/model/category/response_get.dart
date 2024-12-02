// To parse this JSON data, do
//
//     final modelResponseGetCategory = modelResponseGetCategoryFromJson(jsonString);

import 'dart:convert';

ModelResponseGetCategory modelResponseGetCategoryFromJson(String str) => ModelResponseGetCategory.fromJson(json.decode(str));

String modelResponseGetCategoryToJson(ModelResponseGetCategory data) => json.encode(data.toJson());

class ModelResponseGetCategory {
  final bool status;
  final String message;
  final List<Category> categories;

  ModelResponseGetCategory({
    required this.status,
    required this.message,
    required this.categories,
  });

  ModelResponseGetCategory copyWith({
    bool? status,
    String? message,
    List<Category>? categories,
  }) =>
      ModelResponseGetCategory(
        status: status ?? this.status,
        message: message ?? this.message,
        categories: categories ?? this.categories,
      );

  factory ModelResponseGetCategory.fromJson(Map<String, dynamic> json) => ModelResponseGetCategory(
    status: json["status"],
    message: json["message"],
    categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
  };
}

class Category {
  final int id;
  final String uuid;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;

  Category({
    required this.id,
    required this.uuid,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  Category copyWith({
    int? id,
    String? uuid,
    String? name,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Category(
        id: id ?? this.id,
        uuid: uuid ?? this.uuid,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    uuid: json["uuid"],
    name: json["name"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "name": name,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
