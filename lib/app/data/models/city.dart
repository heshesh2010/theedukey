import 'dart:convert';

class City {
  City({this.id, this.name});

  final int? id;
  final String? name;

  factory City.fromJson(String str) => City.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory City.fromMap(Map<String, dynamic> json) => City(
        id: json["id"],
        name: json["name"],
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is City &&
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
