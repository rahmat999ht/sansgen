
class DataFocus {
  final int id;
  final String uuid;
  final String readings;
  final String manyBooks;
  final String focus;
  final User user;

  DataFocus({
    required this.id,
    required this.uuid,
    required this.readings,
    required this.manyBooks,
    required this.focus,
    required this.user,
  });

  DataFocus copyWith({
    int? id,
    String? uuid,
    String? readings,
    String? manyBooks,
    String? focus,
    User? user,
  }) =>
      DataFocus(
        id: id ?? this.id,
        uuid: uuid ?? this.uuid,
        readings: readings ?? this.readings,
        manyBooks: manyBooks ?? this.manyBooks,
        focus: focus ?? this.focus,
        user: user ?? this.user,
      );

  factory DataFocus.fromJson(Map<String, dynamic> json) => DataFocus(
    id: json["id"],
    uuid: json["uuid"],
    readings: json["readings"],
    manyBooks: json["manyBooks"],
    focus: json["focus"],
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "readings": readings,
    "manyBooks": manyBooks,
    "focus": focus,
    "user": user.toJson(),
  };
}

class User {
  final int id;
  final String uuid;
  final String name;

  User({
    required this.id,
    required this.uuid,
    required this.name,
  });

  User copyWith({
    int? id,
    String? uuid,
    String? name,
  }) =>
      User(
        id: id ?? this.id,
        uuid: uuid ?? this.uuid,
        name: name ?? this.name,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    uuid: json["uuid"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "name": name,
  };
}
