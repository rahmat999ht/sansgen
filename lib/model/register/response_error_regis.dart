// To parse this JSON data, do
//
//     final modelResponseErrorRegister = modelResponseErrorRegisterFromJson(jsonString);

class DataErrorRegis {
  final List<String> email;

  DataErrorRegis({
    required this.email,
  });

  DataErrorRegis copyWith({
    List<String>? email,
  }) =>
      DataErrorRegis(
        email: email ?? this.email,
      );

  factory DataErrorRegis.fromJson(Map<String, dynamic> json) => DataErrorRegis(
    email: List<String>.from(json["email"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "email": List<dynamic>.from(email.map((x) => x)),
  };
}
