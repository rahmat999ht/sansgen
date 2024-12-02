// To parse this JSON data, do
//
//     final modelRequestPutFocus = modelRequestPutFocusFromJson(jsonString);

import 'dart:convert';

ModelRequestPutFocus modelRequestPutFocusFromJson(String str) => ModelRequestPutFocus.fromJson(json.decode(str));

String modelRequestPutFocusToJson(ModelRequestPutFocus data) => json.encode(data.toJson());

class ModelRequestPutFocus {
  final String readings;
  // final int manyBooks;
  final String focus;

  ModelRequestPutFocus({
    required this.readings,
    // required this.manyBooks,
    required this.focus,
  });

  ModelRequestPutFocus copyWith({
    String? readings,
    // int? manyBooks,
    String? focus,
  }) =>
      ModelRequestPutFocus(
        readings: readings ?? this.readings,
        // manyBooks: manyBooks ?? this.manyBooks,
        focus: focus ?? this.focus,
      );

  factory ModelRequestPutFocus.fromJson(Map<String, dynamic> json) => ModelRequestPutFocus(
    readings: json["readings"],
    // manyBooks: json["manyBooks"],
    focus: json["focus"],
  );

  Map<String, dynamic> toJson() => {
    "readings": readings.toString(),
    // "manyBooks": manyBooks.toInt(),
    "focus": focus.toString(),
  };
}
