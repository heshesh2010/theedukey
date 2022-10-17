// To parse this JSON data, do
//
//     final welcome = welcomeFromMap(jsonString);

import 'dart:convert';

import 'city.dart';

class User {
  User({
    this.id,
    this.name,
    this.nameEn,
    this.token,
    this.guardianName,
    this.image,
    this.idNumber,
    this.guardianIdNumber,
    this.idImage,
    this.familyIdImage,
    this.certificateImage,
    this.phone,
    this.mobile,
    this.email,
    this.city,
    this.mapLocation,
    this.legalAgreement,
    this.emailVerifiedAt,
    this.oldPassword,
    this.password,
    this.passwordConfirmation,
  });

  final int? id;
  final String? name;
  final String? nameEn;
  String? token;
  final dynamic guardianName;
  final String? image;
  final String? idNumber;
  final dynamic guardianIdNumber;
  final String? idImage;
  final String? familyIdImage;
  final String? certificateImage;
  final String? phone;
  final String? mobile;
  final String? email;
  final City? city;
  final String? mapLocation;
  final String? legalAgreement;
  final dynamic emailVerifiedAt;
  String? oldPassword;
  String? password;
  String? passwordConfirmation;
  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        nameEn: json["name_en"],
        token: json['token'],
        guardianName: json["guardian_name"],
        image: json["image"],
        idNumber: json["id_number"],
        guardianIdNumber: json["guardian_id_number"],
        idImage: json["id_image"],
        familyIdImage: json["family_id_image"],
        certificateImage: json["certificate_image"],
        phone: json["phone"],
        mobile: json["mobile"],
        email: json["email"],
        city: json["city"] != null ? City.fromMap(json["city"]) : null,
        mapLocation: json["map_location"],
        legalAgreement: json["legal_agreement"],
        emailVerifiedAt: json["email_verified_at"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "name_en": nameEn,
        "old_password": oldPassword,
        "password": password,
        "password_confirmation": passwordConfirmation,
        "token": token,
        "guardian_name": guardianName,
        "image": image,
        "id_number": idNumber,
        "guardian_id_number": guardianIdNumber,
        "id_image": idImage,
        "family_id_image": familyIdImage,
        "certificate_image": certificateImage,
        "phone": phone,
        "mobile": mobile,
        "email": email,
        "city": city?.name,
        "map_location": mapLocation,
        "legal_agreement": legalAgreement,
        "email_verified_at": emailVerifiedAt,
      };
}
