class Son {
  Son({
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

  late final int? currentPage;
  late final List<SonData>? data;
  late final String? firstPageUrl;
  late final int? from;
  late final int? lastPage;
  late final String? lastPageUrl;
  late final List<Links>? links;
  late final String? nextPageUrl;
  late final String? path;
  late final int? perPage;
  late final String? prevPageUrl;
  late final int? to;
  late final int? total;

  Son.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    data = List.from(json['data']).map((e) => SonData.fromJson(e)).toList();
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    links = List.from(json['links']).map((e) => Links.fromJson(e)).toList();
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['current_page'] = currentPage;
    _data['data'] = data?.map((e) => e.toJson()).toList();
    _data['first_page_url'] = firstPageUrl;
    _data['from'] = from;
    _data['last_page'] = lastPage;
    _data['last_page_url'] = lastPageUrl;
    _data['links'] = links?.map((e) => e.toJson()).toList();
    _data['next_page_url'] = nextPageUrl;
    _data['path'] = path;
    _data['per_page'] = perPage;
    _data['prev_page_url'] = prevPageUrl;
    _data['to'] = to;
    _data['total'] = total;
    return _data;
  }
}

class SonData {
  SonData({
    this.id,
    this.studentId,
    this.name,
    this.nameEn,
    this.image,
    this.gender,
    this.idNumber,
    this.idImage,
    this.certificateImage,
    this.birthDate,
    this.createdAt,
    this.updatedAt,
  });
  late final int? id;
  late final int? studentId;
  late final String? name;
  late final String? nameEn;
  late final String? image;
  late final String? gender;
  late final String? idNumber;
  late final String? idImage;
  late final String? certificateImage;
  late final String? birthDate;
  late final String? createdAt;
  late final String? updatedAt;

  SonData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    studentId = json['student_id'];
    name = json['name'];
    nameEn = null;
    image = json['image'];
    gender = json['gender'];
    idNumber = json['id_number'];
    idImage = json['id_image'];
    certificateImage = json['certificate_image'];
    birthDate = json['birth_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['student_id'] = studentId;
    _data['name'] = name;
    _data['name_en'] = nameEn;
    _data['image'] = image;
    _data['gender'] = gender;
    _data['id_number'] = idNumber;
    _data['id_image'] = idImage;
    _data['certificate_image'] = certificateImage;
    _data['birth_date'] = birthDate;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}

class Links {
  Links({
    this.url,
    required this.label,
    required this.active,
  });
  late final String? url;
  late final String label;
  late final bool active;

  Links.fromJson(Map<String, dynamic> json) {
    url = null;
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['url'] = url;
    _data['label'] = label;
    _data['active'] = active;
    return _data;
  }
}
