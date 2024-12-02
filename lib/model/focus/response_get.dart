import 'dart:convert';

import 'data_focus.dart';

ModelResponseGetFocus modelResponseGetFocusFromJson(String str) =>
    ModelResponseGetFocus.fromJson(json.decode(str));

String modelResponseGetFocusToJson(ModelResponseGetFocus data) =>
    json.encode(data.toJson());

class ModelResponseGetFocus {
  final DataFocus? data;

  ModelResponseGetFocus({
    required this.data,
  });

  ModelResponseGetFocus copyWith({
    DataFocus? data,
  }) =>
      ModelResponseGetFocus(
        data: data ?? this.data,
      );

  factory ModelResponseGetFocus.fromJson(Map<String, dynamic> json) =>
      ModelResponseGetFocus(
        data: json["data"] == null
            ? DataFocus.fromJson({})
            : DataFocus.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
      };
}
