// To parse this JSON data, do
//
//     final modelResponsePostRate = modelResponsePostRateFromJson(jsonString);

import 'dart:convert';

ModelResponsePostRate modelResponsePostRateFromJson(String str) => ModelResponsePostRate.fromJson(json.decode(str));

String modelResponsePostRateToJson(ModelResponsePostRate data) => json.encode(data.toJson());

class ModelResponsePostRate {
  final DataResponsePostRate data;

  ModelResponsePostRate({
    required this.data,
  });

  ModelResponsePostRate copyWith({
    DataResponsePostRate? data,
  }) =>
      ModelResponsePostRate(
        data: data ?? this.data,
      );

  factory ModelResponsePostRate.fromJson(Map<String, dynamic> json) => ModelResponsePostRate(
    data: DataResponsePostRate.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
  };
}

class DataResponsePostRate {
  final int id;
  final String uuid;
  final double rate;
  final DateTime createdAt;
  final String timeElapsed;
  final User user;
  final Book book;

  DataResponsePostRate({
    required this.id,
    required this.uuid,
    required this.rate,
    required this.createdAt,
    required this.timeElapsed,
    required this.user,
    required this.book,
  });

  DataResponsePostRate copyWith({
    int? id,
    String? uuid,
    double? rate,
    DateTime? createdAt,
    String? timeElapsed,
    User? user,
    Book? book,
  }) =>
      DataResponsePostRate(
        id: id ?? this.id,
        uuid: uuid ?? this.uuid,
        rate: rate ?? this.rate,
        createdAt: createdAt ?? this.createdAt,
        timeElapsed: timeElapsed ?? this.timeElapsed,
        user: user ?? this.user,
        book: book ?? this.book,
      );

  factory DataResponsePostRate.fromJson(Map<String, dynamic> json) => DataResponsePostRate(
    id: json["id"],
    uuid: json["uuid"],
    rate: json["rate"]?.toDouble(),
    createdAt: DateTime.parse(json["created_at"]),
    timeElapsed: json["time_elapsed"],
    user: User.fromJson(json["user"]),
    book: Book.fromJson(json["book"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "rate": rate,
    "created_at": "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
    "time_elapsed": timeElapsed,
    "user": user.toJson(),
    "book": book.toJson(),
  };
}

class Book {
  final int id;
  final String uuid;
  final String title;

  Book({
    required this.id,
    required this.uuid,
    required this.title,
  });

  Book copyWith({
    int? id,
    String? uuid,
    String? title,
  }) =>
      Book(
        id: id ?? this.id,
        uuid: uuid ?? this.uuid,
        title: title ?? this.title,
      );

  factory Book.fromJson(Map<String, dynamic> json) => Book(
    id: json["id"],
    uuid: json["uuid"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "title": title,
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
