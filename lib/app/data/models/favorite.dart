import 'dart:convert';

class Favorite {
  Favorite({
    this.id,
    this.facilityId,
    this.studentId,
    this.createdAt,
    this.name,
    this.logo,
  });

  final int? id;
  final int? facilityId;
  final int? studentId;
  final String? createdAt;
  final String? name;
  final String? logo;

  factory Favorite.fromJson(String str) => Favorite.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Favorite.fromMap(Map<String, dynamic> json) => Favorite(
        id: json["id"],
        facilityId: json["facility_id"],
        studentId: json["student_id"],
        createdAt: json["created_at"],
        name: json["name"],
        logo: json["logo"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "facility_id": facilityId,
        "student_id": studentId,
        "created_at": createdAt,
        "name": name,
        "logo": logo,
      };
}
