import 'dart:convert';

import 'data_chapter.dart';

ModelResponseGetIdChapter modelResponseGetIdChapterFromJson(String str) => ModelResponseGetIdChapter.fromJson(json.decode(str));

String modelResponseGetIdChapterToJson(ModelResponseGetIdChapter data) => json.encode(data.toJson());

class ModelResponseGetIdChapter {
  final DataChapter data;

  ModelResponseGetIdChapter({
    required this.data,
  });

  ModelResponseGetIdChapter copyWith({
    DataChapter? data,
  }) =>
      ModelResponseGetIdChapter(
        data: data ?? this.data,
      );

  factory ModelResponseGetIdChapter.fromJson(Map<String, dynamic> json) => ModelResponseGetIdChapter(
    data: DataChapter.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
  };
}
