// To parse this JSON data, do
//
//     final modelResponseGetChapter = modelResponseGetChapterFromJson(jsonString);

import 'dart:convert';

import 'data_chapter.dart';

ModelResponseGetChapter modelResponseGetChapterFromJson(String str) => ModelResponseGetChapter.fromJson(json.decode(str));

String modelResponseGetChapterToJson(ModelResponseGetChapter data) => json.encode(data.toJson());

class ModelResponseGetChapter {
  final bool status;
  final String message;
  final List<DataChapter> data;

  ModelResponseGetChapter({
    required this.status,
    required this.message,
    required this.data,
  });

  ModelResponseGetChapter copyWith({
    bool? status,
    String? message,
    List<DataChapter>? data,
  }) =>
      ModelResponseGetChapter(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory ModelResponseGetChapter.fromJson(Map<String, dynamic> json) => ModelResponseGetChapter(
    status: json["status"],
    message: json["message"],
    data: List<DataChapter>.from(json["data"].map((x) => DataChapter.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}
