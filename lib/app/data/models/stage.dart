import 'dart:convert';

class Stage {
  Stage({
    this.id,
    this.name,
  });

  final int? id;
  final String? name;

  factory Stage.fromJson(String str) => Stage.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Stage.fromMap(Map<String, dynamic> json) => Stage(
        id: json["id"],
        name: json["name"],
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Stage &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name;

  @override
  int get hashCode => id.hashCode ^ name.hashCode;

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
      };
}
