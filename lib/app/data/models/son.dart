import 'package:dio/dio.dart';

///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class SonDataLinks {
/*
{
  "url": null,
  "label": "&laquo; السابق",
  "active": false
} 
*/

  String? url;
  String? label;
  bool? active;

  SonDataLinks({
    this.url,
    this.label,
    this.active,
  });
  SonDataLinks.fromJson(Map<String, dynamic> json) {
    url = json['url']?.toString();
    label = json['label']?.toString();
    active = json['active'];
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['url'] = url;
    data['label'] = label;
    data['active'] = active;
    return data;
  }
}

class SonDataData {
/*
{
  "id": 2,
  "student_id": 1,
  "name": null,
  "gender": "male",
  "id_number": "44444444444444444444444444",
  "birth_date": "0000-00-00",
  "image": "https://dev17.toplinedev.com/theedukey/public/uploads/childrens/profile/16433011035209.jpg",
  "id_image": "https://dev17.toplinedev.com/theedukey/public/uploads/childrens/id_image/16433011037945.jpg",
  "certificate_image": "https://dev17.toplinedev.com/theedukey/public/uploads/childrens/certificate_image/16433011039104.jpg"
} 
*/

  int? id;
  int? studentId;
  String? name;
  String? gender;
  String? idNumber;
  String? birthDate;
  String? image;
  String? idImage;
  String? certificateImage;
  String? nameEn;
  SonDataData({
    this.id,
    this.studentId,
    this.name,
    this.gender,
    this.idNumber,
    this.birthDate,
    this.image,
    this.idImage,
    this.certificateImage,
    this.nameEn,
  });
  SonDataData.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    studentId = json['student_id']?.toInt();
    name = json['name']?.toString();
    nameEn = json['name_en']?.toString();
    gender = json['gender']?.toString();
    idNumber = json['id_number']?.toString();
    birthDate = json['birth_date']?.toString();
    image = json['image']?.toString();
    idImage = json['id_image']?.toString();
    certificateImage = json['certificate_image']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['student_id'] = studentId;
    data['name'] = name;
    data['name_en'] = nameEn;
    data['gender'] = gender;
    data['id_number'] = idNumber;
    data['birth_date'] = birthDate;
    return data;
  }

  toFormData() async {
    return FormData.fromMap({
      'student_id': studentId,
      'name': name,
      'gender': gender,
      'id_number': idNumber,
      'birth_date': birthDate,
      "id_image": MultipartFile.fromFile(idImage!),
      "certificate_image": await MultipartFile.fromFile(certificateImage!),
      "image": await MultipartFile.fromFile(image!),
    });
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SonDataData &&
        other.id == id &&
        other.studentId == studentId &&
        other.name == name &&
        other.gender == gender &&
        other.idNumber == idNumber &&
        other.birthDate == birthDate &&
        other.image == image &&
        other.idImage == idImage &&
        other.certificateImage == certificateImage &&
        other.nameEn == nameEn;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        studentId.hashCode ^
        name.hashCode ^
        gender.hashCode ^
        idNumber.hashCode ^
        birthDate.hashCode ^
        image.hashCode ^
        idImage.hashCode ^
        certificateImage.hashCode ^
        nameEn.hashCode;
  }
}

class SonData {
/*
{
  "current_page": 1,
  "data": [
    {
      "id": 2,
      "student_id": 1,
      "name": null,
      "gender": "male",
      "id_number": "44444444444444444444444444",
      "birth_date": "0000-00-00",
      "image": "https://dev17.toplinedev.com/theedukey/public/uploads/childrens/profile/16433011035209.jpg",
      "id_image": "https://dev17.toplinedev.com/theedukey/public/uploads/childrens/id_image/16433011037945.jpg",
      "certificate_image": "https://dev17.toplinedev.com/theedukey/public/uploads/childrens/certificate_image/16433011039104.jpg"
    }
  ],
  "first_page_url": "https://dev17.toplinedev.com/theedukey/public/api/student-auth/children?page=1",
  "from": 1,
  "last_page": 1,
  "last_page_url": "https://dev17.toplinedev.com/theedukey/public/api/student-auth/children?page=1",
  "links": [
    {
      "url": null,
      "label": "&laquo; السابق",
      "active": false
    }
  ],
  "next_page_url": null,
  "path": "https://dev17.toplinedev.com/theedukey/public/api/student-auth/children",
  "per_page": 10,
  "prev_page_url": null,
  "to": 7,
  "total": 7
} 
*/

  int? currentPage;
  List<SonDataData?>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<SonDataLinks?>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  SonData({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });
  SonData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page']?.toInt();
    if (json['data'] != null) {
      final v = json['data'];
      final arr0 = <SonDataData>[];
      v.forEach((v) {
        arr0.add(SonDataData.fromJson(v));
      });
      data = arr0;
    }
    firstPageUrl = json['first_page_url']?.toString();
    from = json['from']?.toInt();
    lastPage = json['last_page']?.toInt();
    lastPageUrl = json['last_page_url']?.toString();
    if (json['links'] != null) {
      links = List<SonDataLinks>.from(
          json['links'].map((model) => SonDataLinks.fromJson(model)));
    }
    nextPageUrl = json['next_page_url']?.toString();
    path = json['path']?.toString();
    perPage = json['per_page']?.toInt();
    prevPageUrl = json['prev_page_url']?.toString();
    to = json['to']?.toInt();
    total = json['total']?.toInt();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (this.data != null) {
      final v = this.data;
      final arr0 = [];
      for (var v in v!) {
        arr0.add(v!.toJson());
      }
      data['data'] = arr0;
    }
    data['first_page_url'] = firstPageUrl;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['last_page_url'] = lastPageUrl;
    if (links != null) {
      final v = links;
      final arr0 = [];
      for (var v in v!) {
        arr0.add(v!.toJson());
      }
      data['links'] = arr0;
    }
    data['next_page_url'] = nextPageUrl;
    data['path'] = path;
    data['per_page'] = perPage;
    data['prev_page_url'] = prevPageUrl;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

class Son {
/*
{
  "status": true,
  "data": {
    "current_page": 1,
    "data": [
      {
        "id": 2,
        "student_id": 1,
        "name": null,
        "gender": "male",
        "id_number": "44444444444444444444444444",
        "birth_date": "0000-00-00",
        "image": "https://dev17.toplinedev.com/theedukey/public/uploads/childrens/profile/16433011035209.jpg",
        "id_image": "https://dev17.toplinedev.com/theedukey/public/uploads/childrens/id_image/16433011037945.jpg",
        "certificate_image": "https://dev17.toplinedev.com/theedukey/public/uploads/childrens/certificate_image/16433011039104.jpg"
      }
    ],
    "first_page_url": "https://dev17.toplinedev.com/theedukey/public/api/student-auth/children?page=1",
    "from": 1,
    "last_page": 1,
    "last_page_url": "https://dev17.toplinedev.com/theedukey/public/api/student-auth/children?page=1",
    "links": [
      {
        "url": null,
        "label": "&laquo; السابق",
        "active": false
      }
    ],
    "next_page_url": null,
    "path": "https://dev17.toplinedev.com/theedukey/public/api/student-auth/children",
    "per_page": 10,
    "prev_page_url": null,
    "to": 7,
    "total": 7
  }
} 
*/

  bool? status;
  SonData? data;

  Son({
    this.status,
    this.data,
  });
  Son.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = (json['data'] != null) ? SonData.fromJson(json['data']) : null;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['data'] = this.data!.toJson();
    return data;
  }
}
