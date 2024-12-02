import 'dart:convert';

ModelResponseError modelResponseErrorFromJson(String str) => ModelResponseError.fromJson(json.decode(str));

String modelResponseErrorToJson(ModelResponseError data) => json.encode(data.toJson());

class ModelResponseError {
  final Errors errors;

  ModelResponseError({
    required this.errors,
  });

  ModelResponseError copyWith({
    Errors? errors,
  }) =>
      ModelResponseError(
        errors: errors ?? this.errors,
      );

  factory ModelResponseError.fromJson(Map<String, dynamic> json) => ModelResponseError(
    errors: Errors.fromJson(json["errors"]),
  );

  Map<String, dynamic> toJson() => {
    "errors": errors.toJson(),
  };
}

class Errors {
  final List<String> message;

  Errors({
    required this.message,
  });

  Errors copyWith({
    List<String>? message,
  }) =>
      Errors(
        message: message ?? this.message,
      );

  factory Errors.fromJson(Map<String, dynamic> json) => Errors(
    message: List<String>.from(json["message"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "message": List<dynamic>.from(message.map((x) => x)),
  };
}
