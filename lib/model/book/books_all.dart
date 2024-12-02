// To parse this JSON data, do
//
//     final bookModel = bookModelFromJson(jsonString);

import 'dart:convert';

import 'books.dart';

ModelBooks booksModelFromJson(String str) => ModelBooks.fromJson(json.decode(str));

String booksModelToJson(ModelBooks data) => json.encode(data.toJson());

class ModelBooks {
  final bool status;
  final String message;
  final List<DataBook> data;

  ModelBooks({
    required this.status,
    required this.message,
    required this.data,
  });

  ModelBooks copyWith({
    bool? status,
    String? message,
    List<DataBook>? data,
  }) =>
      ModelBooks(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory ModelBooks.fromJson(Map<String, dynamic> json) => ModelBooks(
    status: json["status"],
    message: json["message"],
    data: List<DataBook>.from(json["data"].map((x) => DataBook.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}
