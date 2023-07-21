import 'filter_data.dart';

class School {
  final bool? success;
  final Data? data;

  School({
    this.success,
    this.data,
  });

  School.fromJson(Map<String, dynamic> json)
      : success = json['success'] as bool?,
        data = (json['data'] as Map<String, dynamic>?) != null
            ? Data.fromJson(json['data'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() => {'success': success, 'data': data?.toJson()};

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is School && other.success == success && other.data == data;
  }

  @override
  int get hashCode => success.hashCode ^ data.hashCode;
}

class Data {
  final List<SchoolData>? results;
  final FilterData? filter;

  Data({
    this.results,
    this.filter,
  });

  Data.fromJson(Map<String, dynamic> json)
      : results = (json['results'] as List?)
            ?.map((dynamic e) => SchoolData.fromJson(e as Map<String, dynamic>))
            .toList(),
        filter = (json['filter'] as Map<String, dynamic>?) != null
            ? FilterData.fromJson(json['filter'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() => {
        'results': results?.map((e) => e.toJson()).toList(),
        'filter': filter?.toJson()
      };
}

class SchoolData {
  final int? id;
  final String? name;
  final String? about;
  final String? phone;
  final String? mobile;
  final String? email;
  final String? address;
  final String? mapLocation;
  final String? commercialRecord;
  final String? ownerId;
  final String? logo;
  final String? rate;
  final int? visits;
  final String? status;
  final String? cityId;
  final String? cityName;
  bool? isFavorite;
  final bool? canRate;
  final int? facilityTypeId;

  SchoolData(
      {this.id,
      this.name,
      this.about,
      this.phone,
      this.mobile,
      this.email,
      this.address,
      this.mapLocation,
      this.commercialRecord,
      this.ownerId,
      this.logo,
      this.rate,
      this.visits,
      this.status,
      this.cityId,
      this.cityName,
      this.isFavorite,
      this.canRate,
      this.facilityTypeId});

  SchoolData.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        about = json['about'] as String?,
        phone = json['phone'] as String?,
        mobile = json['mobile'] as String?,
        email = json['email'] as String?,
        address = json['address'] as String?,
        mapLocation = json['map_location'] as String?,
        commercialRecord = json['commercial_record'] as String?,
        ownerId = json['owner_id'] as String?,
        logo = json['logo'] as String?,
        rate = json['rate'] as String?,
        visits = json['visits'] as int?,
        status = json['status'] as String?,
        cityId = json['city_id'] as String?,
        cityName = json['city_name'] as String?,
        isFavorite = json['is_favorite'] as bool?,
        canRate = json['can_rate'] as bool?,
        facilityTypeId = json['facility_type_id'] as int?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'about': about,
        'phone': phone,
        'mobile': mobile,
        'email': email,
        'address': address,
        'map_location': mapLocation,
        'commercial_record': commercialRecord,
        'owner_id': ownerId,
        'logo': logo,
        'rate': rate,
        'visits': visits,
        'status': status,
        'city_id': cityId,
        'city_name': cityName,
        'is_favorite': isFavorite,
        'can_rate': canRate,
        'facility_type_id': facilityTypeId
      };
}
