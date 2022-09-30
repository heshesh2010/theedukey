import 'package:theedukey/app/data/models/school.dart';

class Facility {
  final SchoolData? school;
  final List<Gallery>? gallery;
  final List<Stages>? stages;
  final List<Prices>? prices;
  final List<SchoolData>? related;

  Facility({
    this.school,
    this.gallery,
    this.stages,
    this.prices,
    this.related,
  });

  Facility.fromJson(Map<String, dynamic> json)
      : school = (json['facility'] as Map<String, dynamic>?) != null
            ? SchoolData.fromJson(json['facility'] as Map<String, dynamic>)
            : null,
        gallery = (json['gallery'] as List?)
            ?.map((dynamic e) => Gallery.fromJson(e as Map<String, dynamic>))
            .toList(),
        stages = (json['stages'] as List?)
            ?.map((dynamic e) => Stages.fromJson(e as Map<String, dynamic>))
            .toList(),
        prices = (json['prices'] as List?)
            ?.map((dynamic e) => Prices.fromJson(e as Map<String, dynamic>))
            .toList(),
        related = (json['related'] as List?)
            ?.map((dynamic e) => SchoolData.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() => {
        'facility': school?.toJson(),
        'gallery': gallery?.map((e) => e.toJson()).toList(),
        'stages': stages?.map((e) => e.toJson()).toList(),
        'prices': prices?.map((e) => e.toJson()).toList(),
        'related': related?.map((e) => e.toJson()).toList(),
      };
}

class Gallery {
  final int? id;
  final int? facilityId;
  final String? image;
  final String? createdAt;
  final String? updatedAt;

  Gallery({
    this.id,
    this.facilityId,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  Gallery.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        facilityId = json['facility_id'] as int?,
        image = json['image'] as String?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'facility_id': facilityId,
        'image': image,
        'created_at': createdAt,
        'updated_at': updatedAt
      };
}

class Stages {
  final int? id;
  final String? name;

  Stages({
    this.id,
    this.name,
  });

  Stages.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?;

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}

class Prices {
  final int? id;
  final int? facilityId;
  final String? name;
  final String? priceBeforeDiscount;
  final String? priceAfterDiscount;
  final String? numberOfAllowedStudent;
  final String? start;
  final String? end;
  final String? note;
  final int? stageId;
  final String? stageName;
  final int? classId;
  final String? className;
  final int? paymentMethodId;
  final String? paymentMethod;

  Prices({
    this.id,
    this.facilityId,
    this.name,
    this.priceBeforeDiscount,
    this.priceAfterDiscount,
    this.numberOfAllowedStudent,
    this.start,
    this.end,
    this.note,
    this.stageId,
    this.stageName,
    this.classId,
    this.className,
    this.paymentMethodId,
    this.paymentMethod,
  });

  Prices.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        facilityId = json['facility_id'] as int?,
        name = json['name'] as String?,
        priceBeforeDiscount = json['price_before_discount '] as String?,
        priceAfterDiscount = json['price_after_discount'] as String?,
        numberOfAllowedStudent = json['number_of_allowed_student'] as String?,
        start = json['start'] as String?,
        end = json['end'] as String?,
        note = json['note'] as String?,
        stageId = json['stage_id'] as int?,
        stageName = json['stage_name'] as String?,
        classId = json['class_id'] as int?,
        className = json['class_name'] as String?,
        paymentMethodId = json['payment_method_id'] as int?,
        paymentMethod = json['payment_method'] as String?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'facility_id': facilityId,
        'name': name,
        'price_before_discount ': priceBeforeDiscount,
        'price_after_discount': priceAfterDiscount,
        'number_of_allowed_student': numberOfAllowedStudent,
        'start': start,
        'end': end,
        'note': note,
        'stage_id': stageId,
        'stage_name': stageName,
        'class_id': classId,
        'class_name': className,
        'payment_method_id': paymentMethodId,
        'payment_method': paymentMethod
      };
}
