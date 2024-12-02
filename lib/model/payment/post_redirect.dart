// To parse this JSON data, do
//
//     final modelResponsePostRedirectPayment = modelResponsePostRedirectPaymentFromJson(jsonString);

import 'dart:convert';

ModelResponsePostRedirectPayment modelResponsePostRedirectPaymentFromJson(String str) => ModelResponsePostRedirectPayment.fromJson(json.decode(str));

String modelResponsePostRedirectPaymentToJson(ModelResponsePostRedirectPayment data) => json.encode(data.toJson());

class ModelResponsePostRedirectPayment {
  final bool status;
  final String message;
  final String? activeUntil;
  final dynamic checkoutLink;

  ModelResponsePostRedirectPayment({
    required this.status,
    required this.message,
    required this.activeUntil,
    required this.checkoutLink,
  });

  ModelResponsePostRedirectPayment copyWith({
    bool? status,
    String? message,
    String? activeUntil,
    dynamic checkoutLink,
  }) =>
      ModelResponsePostRedirectPayment(
        status: status ?? this.status,
        message: message ?? this.message,
        activeUntil: activeUntil ?? this.activeUntil,
        checkoutLink: checkoutLink ?? this.checkoutLink,
      );

  factory ModelResponsePostRedirectPayment.fromJson(Map<String, dynamic> json) => ModelResponsePostRedirectPayment(
    status: json["status"],
    message: json["message"],
    activeUntil: json["active_until"] ?? "",
    checkoutLink: json["checkout_link"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "active_until": activeUntil,
    "checkout_link": checkoutLink,
  };
}
