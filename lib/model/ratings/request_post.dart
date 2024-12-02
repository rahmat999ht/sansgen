import 'dart:convert';

ModelRequestPostRate modelRequestPostRateFromJson(String str) => ModelRequestPostRate.fromJson(json.decode(str));

String modelRequestPostRateToJson(ModelRequestPostRate data) => json.encode(data.toJson());

class ModelRequestPostRate {
  final double rate;

  ModelRequestPostRate({
    required this.rate,
  });

  ModelRequestPostRate copyWith({
    double? rate,
  }) =>
      ModelRequestPostRate(
        rate: rate ?? this.rate,
      );

  factory ModelRequestPostRate.fromJson(Map<String, dynamic> json) => ModelRequestPostRate(
    rate: json["rate"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "rate": rate,
  };
}
