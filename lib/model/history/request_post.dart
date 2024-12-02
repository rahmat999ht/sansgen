import 'dart:convert';

ModelRequestPostHistory modelRequestPostHistoryFromJson(String str) => ModelRequestPostHistory.fromJson(json.decode(str));

String modelRequestPostHistoryToJson(ModelRequestPostHistory data) => json.encode(data.toJson());

class ModelRequestPostHistory {
  // final bool isFinished;
  final int lastChapter;

  ModelRequestPostHistory({
    // required this.isFinished,
    required this.lastChapter,
  });

  ModelRequestPostHistory copyWith({
    bool? isFinished,
    int? lastChapter,
  }) =>
      ModelRequestPostHistory(
        // isFinished: isFinished ?? this.isFinished,
        lastChapter: lastChapter ?? this.lastChapter,
      );

  factory ModelRequestPostHistory.fromJson(Map<String, dynamic> json) => ModelRequestPostHistory(
    // isFinished: json["isFinished"],
    lastChapter: json["lastChapter"],
  );

  Map<String, dynamic> toJson() => {
    // "isFinished": isFinished,
    "lastChapter": lastChapter,
  };
}
