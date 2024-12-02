// To parse this JSON data, do
//
//     final dataIdBook = dataIdBookFromJson(jsonString);

import 'dart:convert';

import 'package:sansgen/utils/ext_string.dart';

DataIdBook dataIdBookFromJson(String str) =>
    DataIdBook.fromJson(json.decode(str));

String dataIdBookToJson(DataIdBook data) => json.encode(data.toJson());

class DataIdBook {
  final int id;
  final String uuid;
  final String title;
  final String image;
  final String synopsis;
  final String language;
  final String gender;
  final String rangeAge;
  final String? category;
  final String writer;
  final String publisher;
  // final DateTime createdAt;
  final String? music;
  final int manyLikes;
  final int manyRatings;
  final int manyChapters;
  final int manyComments;
  final double averageRate;
  final List<Chapter> chapters;
  final List<Comment> comments;
  final List<Like> likes;

  DataIdBook({
    required this.id,
    required this.uuid,
    required this.title,
    required this.image,
    required this.synopsis,
    required this.language,
    required this.gender,
    required this.rangeAge,
    required this.category,
    required this.writer,
    required this.publisher,
    // required this.createdAt,
    required this.music,
    required this.manyLikes,
    required this.manyRatings,
    required this.manyChapters,
    required this.manyComments,
    required this.averageRate,
    required this.chapters,
    required this.comments,
    required this.likes,
  });

  DataIdBook copyWith({
    int? id,
    String? uuid,
    String? title,
    String? image,
    String? synopsis,
    String? language,
    String? gender,
    String? rangeAge,
    String? category,
    String? writer,
    String? publisher,
    // DateTime? createdAt,
    String? music,
    int? manyLikes,
    int? manyRatings,
    int? manyChapters,
    int? manyComments,
    double? averageRate,
    List<Chapter>? chapters,
    List<Comment>? comments,
    List<Like>? likes,
  }) =>
      DataIdBook(
        id: id ?? this.id,
        uuid: uuid ?? this.uuid,
        title: title ?? this.title,
        image: image ?? this.image,
        synopsis: synopsis ?? this.synopsis,
        language: language ?? this.language,
        gender: gender ?? this.gender,
        rangeAge: rangeAge ?? this.rangeAge,
        category: category ?? this.category,
        writer: writer ?? this.writer,
        publisher: publisher ?? this.publisher,
        // createdAt: createdAt ?? this.createdAt,
        music: music ?? this.music,
        manyLikes: manyLikes ?? this.manyLikes,
        manyRatings: manyRatings ?? this.manyRatings,
        manyChapters: manyChapters ?? this.manyChapters,
        manyComments: manyComments ?? this.manyComments,
        averageRate: averageRate ?? this.averageRate,
        chapters: chapters ?? this.chapters,
        comments: comments ?? this.comments,
        likes: likes ?? this.likes,
      );

  factory DataIdBook.fromJson(Map<String, dynamic> json) => DataIdBook(
        id: json["id"],
        uuid: json["uuid"],
        title: json["title"],
        image: json["image"].toString().formattedUrl,
        synopsis: json["synopsis"],
        language: json["language"],
        gender: json["gender"],
        rangeAge: json["rangeAge"],
        category: json["category"] ?? "-",
        writer: json["writer"],
        publisher: json["publisher"],
        // createdAt: DateTime.parse(json["created_at"]),
        music: json["music"] == null ? '' : json["music"].toString().formattedUrl,
        manyLikes: json["manyLikes"],
        manyRatings: json["manyRatings"],
        manyChapters: json["manyChapters"],
        manyComments: json["manyComments"],
        averageRate: json["average_rate"] == null
            ? 0.0
            : double.parse(json["average_rate"]),
        chapters: List<Chapter>.from(
            json["chapters"].map((x) => Chapter.fromJson(x))),
        comments: List<Comment>.from(
            json["comments"].map((x) => Comment.fromJson(x))),
        likes: List<Like>.from(json["likes"].map((x) => Like.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uuid": uuid,
        "title": title,
        "image": image,
        "synopsis": synopsis,
        "language": language,
        "gender": gender,
        "rangeAge": rangeAge,
        "category": category,
        "writer": writer,
        "publisher": publisher,
        // "created_at": "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
        "music": music,
        "manyLikes": manyLikes,
        "manyRatings": manyRatings,
        "manyChapters": manyChapters,
        "manyComments": manyComments,
        "average_rate": averageRate,
        "chapters": List<dynamic>.from(chapters.map((x) => x.toJson())),
        "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
        "likes": List<dynamic>.from(likes.map((x) => x.toJson())),
      };
}

class Chapter {
  final int id;
  final String uuid;
  final String number;
  final String title;
  final String? audio;

  Chapter({
    required this.id,
    required this.uuid,
    required this.number,
    required this.title,
    required this.audio,
  });

  Chapter copyWith({
    int? id,
    String? uuid,
    String? number,
    String? title,
    String? audio,
  }) =>
      Chapter(
        id: id ?? this.id,
        uuid: uuid ?? this.uuid,
        number: number ?? this.number,
        title: title ?? this.title,
        audio: audio ?? this.audio,
      );

  factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
        id: json["id"],
        uuid: json["uuid"],
        number: json["number"],
        title: json["title"],
        audio: json["audio"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uuid": uuid,
        "number": number,
        "title": title,
        "audio": audio,
      };
}

class Comment {
  final int id;
  final String comment;

  // final DateTime createdAt;
  final String timeElapsed;
  final User user;

  Comment({
    required this.id,
    required this.comment,
    // required this.createdAt,
    required this.timeElapsed,
    required this.user,
  });

  Comment copyWith({
    int? id,
    String? comment,
    DateTime? createdAt,
    String? timeElapsed,
    User? user,
  }) =>
      Comment(
        id: id ?? this.id,
        comment: comment ?? this.comment,
        // createdAt: createdAt ?? this.createdAt,
        timeElapsed: timeElapsed ?? this.timeElapsed,
        user: user ?? this.user,
      );

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"],
        comment: json["comment"],
        // createdAt: DateTime.parse(json["created_at"]),
        timeElapsed: json["time_elapsed"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "comment": comment,
        // "created_at": "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
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
    this.image,
  });

  User copyWith({
    int? id,
    String? uuid,
    String? name,
    String? image,
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
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uuid": uuid,
        "name": name,
        "image": image,
      };
}

class Like {
  final int id;

  // final DateTime createdAt;
  final String timeElapsed;
  final User user;

  Like({
    required this.id,
    // required this.createdAt,
    required this.timeElapsed,
    required this.user,
  });

  Like copyWith({
    int? id,
    // DateTime? createdAt,
    String? timeElapsed,
    User? user,
  }) =>
      Like(
        id: id ?? this.id,
        // createdAt: createdAt ?? this.createdAt,
        timeElapsed: timeElapsed ?? this.timeElapsed,
        user: user ?? this.user,
      );

  factory Like.fromJson(Map<String, dynamic> json) => Like(
        id: json["id"],
        // createdAt: DateTime.parse(json["created_at"]),
        timeElapsed: json["time_elapsed"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        // "created_at": "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
        "time_elapsed": timeElapsed,
        "user": user.toJson(),
      };
}
