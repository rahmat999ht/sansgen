import 'dart:convert';

ModelDataEmpty modelDataEmptyFromJson(String str) => ModelDataEmpty.fromJson(json.decode(str));

String modelDataEmptyToJson(ModelDataEmpty data) => json.encode(data.toJson());

class ModelDataEmpty {
  final Errors errors;

  ModelDataEmpty({
    required this.errors,
  });

  ModelDataEmpty copyWith({
    Errors? errors,
  }) =>
      ModelDataEmpty(
        errors: errors ?? this.errors,
      );

  factory ModelDataEmpty.fromJson(Map<String, dynamic> json) => ModelDataEmpty(
    errors: Errors.fromJson(json["errors"]),
  );

  Map<String, dynamic> toJson() => {
    "errors": errors.toJson(),
  };
}

class Errors {
  final String message;

  Errors({
    required this.message,
  });

  Errors copyWith({
    String? message,
  }) =>
      Errors(
        message: message ?? this.message,
      );

  factory Errors.fromJson(Map<String, dynamic> json) => Errors(
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };
}
