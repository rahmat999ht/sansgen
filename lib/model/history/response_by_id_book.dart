// To parse this JSON data, do
//
//     final modelResponseHistoryByIdBook = modelResponseHistoryByIdBookFromJson(jsonString);

import 'dart:convert';

import 'data_history.dart';

ModelResponseHistoryByIdBook modelResponseHistoryByIdBookFromJson(String str) => ModelResponseHistoryByIdBook.fromJson(json.decode(str));

String modelResponseHistoryByIdBookToJson(ModelResponseHistoryByIdBook data) => json.encode(data.toJson());

class ModelResponseHistoryByIdBook {
  final bool status;
  final String message;
  final DataHistory data;

  ModelResponseHistoryByIdBook({
    required this.status,
    required this.message,
    required this.data,
  });

  ModelResponseHistoryByIdBook copyWith({
    bool? status,
    String? message,
    DataHistory? data,
  }) =>
      ModelResponseHistoryByIdBook(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory ModelResponseHistoryByIdBook.fromJson(Map<String, dynamic> json) => ModelResponseHistoryByIdBook(
    status: json["status"],
    message: json["message"],
    data: DataHistory.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}
