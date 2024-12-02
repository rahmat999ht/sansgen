// To parse this JSON data, do
//
//     final modelResponseGetHistory = modelResponseGetHistoryFromJson(jsonString);

import 'dart:convert';
import 'data_history.dart';

ModelResponseGetHistory modelResponseGetHistoryFromJson(String str) => ModelResponseGetHistory.fromJson(json.decode(str));

String modelResponseGetHistoryToJson(ModelResponseGetHistory data) => json.encode(data.toJson());

class ModelResponseGetHistory {
  final bool status;
  final String message;
  final List<DataHistory> data;

  ModelResponseGetHistory({
    required this.status,
    required this.message,
    required this.data,
  });

  ModelResponseGetHistory copyWith({
    bool? status,
    String? message,
    List<DataHistory>? data,
  }) =>
      ModelResponseGetHistory(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory ModelResponseGetHistory.fromJson(Map<String, dynamic> json) => ModelResponseGetHistory(
    status: json["status"],
    message: json["message"],
    data: List<DataHistory>.from(json["data"].map((x) => DataHistory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}
