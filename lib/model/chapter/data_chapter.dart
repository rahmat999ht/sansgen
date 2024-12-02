import 'dart:convert';

DataChapter dataChapterFromJson(String str) => DataChapter.fromJson(json.decode(str));

String dataChapterToJson(DataChapter data) => json.encode(data.toJson());

class DataChapter {
  final int id;
  final String uuid;
  final String number;
  final String title;
  final String content;
  final String? audio;
  final DateTime createdAt;

  DataChapter({
    required this.id,
    required this.uuid,
    required this.number,
    required this.title,
    required this.content,
    required this.audio,
    required this.createdAt,
  });

  DataChapter copyWith({
    int? id,
    String? uuid,
    String? number,
    String? title,
    String? content,
    String? audio,
    DateTime? createdAt,
  }) =>
      DataChapter(
        id: id ?? this.id,
        uuid: uuid ?? this.uuid,
        number: number ?? this.number,
        title: title ?? this.title,
        content: content ?? this.content,
        audio: audio ?? this.audio,
        createdAt: createdAt ?? this.createdAt,
      );

  factory DataChapter.fromJson(Map<String, dynamic> json) => DataChapter(
    id: json["id"],
    uuid: json["uuid"],
    number: json["number"],
    title: json["title"],
    content: json["content"],
    audio: json["audio"],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "number": number,
    "title": title,
    "content": content,
    "audio": audio,
    "created_at": "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
  };
}
