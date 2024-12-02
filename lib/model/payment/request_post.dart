// To parse this JSON data, do
//
//     final modelRequestPostPayment = modelRequestPostPaymentFromJson(jsonString);

import 'dart:convert';

ModelRequestPostPayment modelRequestPostPaymentFromJson(String str) => ModelRequestPostPayment.fromJson(json.decode(str));

String modelRequestPostPaymentToJson(ModelRequestPostPayment data) => json.encode(data.toJson());

class ModelRequestPostPayment {
  final String account;
  final String details;
  final String referenceNum;
  final int price;
  final int adminFee;
  final int totalPrice;

  ModelRequestPostPayment({
    required this.account,
    required this.details,
    required this.referenceNum,
    required this.price,
    required this.adminFee,
    required this.totalPrice,
  });

  ModelRequestPostPayment copyWith({
    String? account,
    String? details,
    String? referenceNum,
    int? price,
    int? adminFee,
    int? totalPrice,
  }) =>
      ModelRequestPostPayment(
        account: account ?? this.account,
        details: details ?? this.details,
        referenceNum: referenceNum ?? this.referenceNum,
        price: price ?? this.price,
        adminFee: adminFee ?? this.adminFee,
        totalPrice: totalPrice ?? this.totalPrice,
      );

  factory ModelRequestPostPayment.fromJson(Map<String, dynamic> json) => ModelRequestPostPayment(
    account: json["account"],
    details: json["details"],
    referenceNum: json["referenceNum"],
    price: json["price"],
    adminFee: json["adminFee"],
    totalPrice: json["totalPrice"],
  );

  Map<String, dynamic> toJson() => {
    "account": account,
    "details": details,
    "referenceNum": referenceNum,
    "price": price,
    "adminFee": adminFee,
    "totalPrice": totalPrice,
  };
}
