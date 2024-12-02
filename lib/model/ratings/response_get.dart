import 'dart:convert';

ModelResponseGetRate modelResponseGetRateFromJson(String str) =>
    ModelResponseGetRate.fromJson(json.decode(str));

String modelResponseGetRateToJson(ModelResponseGetRate data) =>
    json.encode(data.toJson());

class ModelResponseGetRate {
  final bool status;
  final String message;
  final DataResponseGetRate data;

  ModelResponseGetRate({
    required this.status,
    required this.message,
    required this.data,
  });

  ModelResponseGetRate copyWith({
    bool? status,
    String? message,
    DataResponseGetRate? data,
  }) =>
      ModelResponseGetRate(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory ModelResponseGetRate.fromJson(Map<String, dynamic> json) =>
      ModelResponseGetRate(
        status: json["status"],
        message: json["message"],
        data: DataResponseGetRate.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class DataResponseGetRate {
  final dynamic averageRate;
  final List<Rating> ratings;

  DataResponseGetRate({
    required this.averageRate,
    required this.ratings,
  });

  DataResponseGetRate copyWith({
    double? averageRate,
    List<Rating>? ratings,
  }) =>
      DataResponseGetRate(
        averageRate: averageRate ?? this.averageRate,
        ratings: ratings ?? this.ratings,
      );

  factory DataResponseGetRate.fromJson(Map<String, dynamic> json) =>
      DataResponseGetRate(
        averageRate: json["average_rate"] == null
            ? 0.0
            : double.parse(json["average_rate"].toString()),
        ratings:
            List<Rating>.from(json["ratings"].map((x) => Rating.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "average_rate": averageRate,
        "ratings": List<dynamic>.from(ratings.map((x) => x.toJson())),
      };
}

class Rating {
  final int id;
  final String uuid;
  final String rate;
  final DateTime createdAt;
  final String timeElapsed;
  final User user;
  final Book book;

  Rating({
    required this.id,
    required this.uuid,
    required this.rate,
    required this.createdAt,
    required this.timeElapsed,
    required this.user,
    required this.book,
  });

  Rating copyWith({
    int? id,
    String? uuid,
    String? rate,
    DateTime? createdAt,
    String? timeElapsed,
    User? user,
    Book? book,
  }) =>
      Rating(
        id: id ?? this.id,
        uuid: uuid ?? this.uuid,
        rate: rate ?? this.rate,
        createdAt: createdAt ?? this.createdAt,
        timeElapsed: timeElapsed ?? this.timeElapsed,
        user: user ?? this.user,
        book: book ?? this.book,
      );

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        id: json["id"],
        uuid: json["uuid"],
        rate: json["rate"],
        createdAt: DateTime.parse(json["created_at"]),
        timeElapsed: json["time_elapsed"],
        user: User.fromJson(json["user"]),
        book: Book.fromJson(json["book"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uuid": uuid,
        "rate": rate,
        "created_at":
            "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
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
