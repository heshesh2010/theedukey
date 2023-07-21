// To parse this JSON data, do
//
//     final welcome = welcomeFromMap(jsonString);

import 'dart:convert';

import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/phone_number.dart';

import 'city.dart';

class User {
  User(
      {this.id,
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
      this.email,
      this.city,
      this.mapLocation,
      this.legalAgreement,
      this.emailVerifiedAt,
      this.oldPassword,
      this.password,
      this.passwordConfirmation,
      this.verificationId,
      this.auth = false,
      this.verifiedPhone = 0});

  final int? id;
  String? name;
  String? nameEn;
  String? token;
  final dynamic guardianName;
  final String? image;
  final String? idNumber;
  final dynamic guardianIdNumber;
  final String? idImage;
  String? familyIdImage;
  final String? certificateImage;
  String? phone;
  String? email;
  City? city;
  final String? mapLocation;
  final String? legalAgreement;
  final dynamic emailVerifiedAt;
  String? oldPassword;
  String? password;
  String? passwordConfirmation;
  String? verificationId;
  bool auth;
  int verifiedPhone;

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
        email: json["email"],
        city: json["city"] != null ? City.fromMap(json["city"]) : null,
        mapLocation: json["map_location"],
        legalAgreement: json["legal_agreement"],
        emailVerifiedAt: json["email_verified_at"],
        verificationId: json["verificationId"],
        auth: json["auth"] ?? false,
        verifiedPhone: json["phone_verify"] ?? 0,
      );

  Map<String, dynamic> toMapSginUp() => {
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
        "email": email,
        "city": city?.id.toString(),
        "map_location": mapLocation,
        "legal_agreement": legalAgreement,
        "email_verified_at": emailVerifiedAt,
        "verificationId": verificationId,
        "auth": auth,
        "verifiedPhone": verifiedPhone,
      };

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
        "email": email,
        "city": city?.toMap(),
        "map_location": mapLocation,
        "legal_agreement": legalAgreement,
        "email_verified_at": emailVerifiedAt,
        "verificationId": verificationId,
        "auth": auth,
        "verifiedPhone": verifiedPhone,
      };

  PhoneNumber getMobileNumber() {
    if (phone != null) {
      phone = phone?.replaceAll(' ', '');
      String? dialCode1 = phone?.substring(1, 2);
      String? dialCode2 = phone?.substring(1, 3);
      String? dialCode3 = phone?.substring(1, 4);
      for (int i = 0; i < countries.length; i++) {
        if (countries[i].dialCode == dialCode1) {
          return PhoneNumber(
              countryISOCode: countries[i].code,
              countryCode: dialCode1 ?? "",
              number: phone?.substring(2) ?? "");
        } else if (countries[i].dialCode == dialCode2) {
          return PhoneNumber(
              countryISOCode: countries[i].code,
              countryCode: dialCode2 ?? "",
              number: phone?.substring(3) ?? "");
        } else if (countries[i].dialCode == dialCode3) {
          return PhoneNumber(
              countryISOCode: countries[i].code,
              countryCode: dialCode3 ?? "",
              number: phone?.substring(4) ?? "");
        }
      }
    }
    return PhoneNumber(countryISOCode: "SA", countryCode: '966', number: '');
  }

  String getMobileNumberString() {
    if (phone != null) {
      phone = phone?.replaceAll(' ', '');
      String? dialCode1 = phone?.substring(1, 2);
      String? dialCode2 = phone?.substring(1, 3);
      String? dialCode3 = phone?.substring(1, 4);
      for (int i = 0; i < countries.length; i++) {
        if (countries[i].dialCode == dialCode1) {
          return phone?.substring(2) ?? "";
        } else if (countries[i].dialCode == dialCode2) {
          return phone?.substring(3) ?? "";
        } else if (countries[i].dialCode == dialCode3) {
          return phone?.substring(4) ?? "";
        }
      }
    }
    return "";
  }

  // override toString to have a beautiful log of User object
  @override
  String toString() {
    return '{ $id, $name, $nameEn, $token, $guardianName, $image, $idNumber, $guardianIdNumber, $idImage, $familyIdImage, $certificateImage, $phone, $email, $city, $mapLocation, $legalAgreement, $emailVerifiedAt, $oldPassword, $password, $passwordConfirmation, $verificationId, $auth, $verifiedPhone }';
  }

  // equals comparison for objects
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          nameEn == other.nameEn &&
          token == other.token &&
          guardianName == other.guardianName &&
          image == other.image &&
          idNumber == other.idNumber &&
          guardianIdNumber == other.guardianIdNumber &&
          idImage == other.idImage &&
          familyIdImage == other.familyIdImage &&
          certificateImage == other.certificateImage &&
          phone == other.phone &&
          email == other.email &&
          city == other.city &&
          mapLocation == other.mapLocation &&
          legalAgreement == other.legalAgreement &&
          emailVerifiedAt == other.emailVerifiedAt &&
          oldPassword == other.oldPassword &&
          password == other.password &&
          passwordConfirmation == other.passwordConfirmation &&
          verificationId == other.verificationId &&
          auth == other.auth &&
          verifiedPhone == other.verifiedPhone;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      nameEn.hashCode ^
      token.hashCode ^
      guardianName.hashCode ^
      image.hashCode ^
      idNumber.hashCode ^
      guardianIdNumber.hashCode ^
      idImage.hashCode ^
      familyIdImage.hashCode ^
      certificateImage.hashCode ^
      phone.hashCode ^
      email.hashCode ^
      city.hashCode ^
      mapLocation.hashCode ^
      legalAgreement.hashCode ^
      emailVerifiedAt.hashCode ^
      oldPassword.hashCode ^
      password.hashCode ^
      passwordConfirmation.hashCode ^
      verificationId.hashCode ^
      auth.hashCode ^
      verifiedPhone.hashCode;
}
