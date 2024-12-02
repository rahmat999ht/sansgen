import 'dart:convert';

ModelRequestPatchUser modelRequestPatchUserFromJson(String str) =>
    ModelRequestPatchUser.fromJson(json.decode(str));

String modelRequestPatchUserToJson(ModelRequestPatchUser data) =>
    json.encode(data.toJson());

class ModelRequestPatchUser {
  final String? name;
  final dynamic image;
  final dynamic dateOfBirth;
  final String? rangeAge;
  final String? gender;
  final dynamic hobby;
  final List<int>? idCategory;

  ModelRequestPatchUser({
    this.name,
    this.image,
    this.dateOfBirth,
    this.rangeAge,
    this.gender,
    this.hobby,
    this.idCategory,
  });

  ModelRequestPatchUser copyWith({
    String? name,
    String? image,
    dynamic dateOfBirth,
    String? rangeAge,
    String? gender,
    dynamic hobby,
    List<int>? idCategory,
  }) =>
      ModelRequestPatchUser(
        name: name ?? this.name,
        image: image ?? this.image,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        rangeAge: rangeAge ?? this.rangeAge,
        gender: gender ?? this.gender,
        hobby: hobby ?? this.hobby,
        idCategory: idCategory ?? this.idCategory,
      );

  factory ModelRequestPatchUser.fromJson(Map<String, dynamic> json) =>
      ModelRequestPatchUser(
        name: json["name"],
        image: json["image"],
        dateOfBirth: json["dateOfBirth"],
        rangeAge: json["rangeAge"],
        gender: json["gender"],
        hobby: json["hobby"],
        idCategory: json["idCategory"] == null
            ? []
            : List<int>.from(json["idCategory"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "image": image,
        "dateOfBirth": dateOfBirth.toString(),
        "rangeAge": rangeAge,
        "gender": gender,
        "hobby": hobby,
        "idCategory": idCategory == null
            ? []
            : List.generate(idCategory!.length, (v) => v).toList(),
        // List<dynamic>.from(idCategory!.map((x) => x)),
      };

  Map<String, dynamic> toReference() => {
        "idCategory": idCategory,
        // List<dynamic>.from(idCategory!.map((x) => x)),
      };

  Map<String, dynamic> toOnBoarding() => {
        "rangeAge": rangeAge,
        "gender": gender,
        "idCategory": idCategory,
        // List<dynamic>.from(idCategory!.map((x) => x)),
      };

  Map<String, dynamic> toInfoPribadi() => {
        "name": name,
        // "image": image,
        "dateOfBirth": dateOfBirth.toString(),
        "hobby": hobby,
      };
}
