class Offer {
  bool? success;
  Data? data;

  Offer({
    this.success,
    this.data,
  });

  Offer.fromJson(Map<String, dynamic> json) {
    success = json['success'] as bool?;
    data = (json['data'] as Map<String, dynamic>?) != null
        ? Data.fromJson(json['data'] as Map<String, dynamic>)
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['success'] = success;
    json['data'] = data?.toJson();
    return json;
  }
}

class Data {
  int? currentPage;
  List<OfferData>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  Data({
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

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'] as int?;
    data = (json['data'] as List?)
        ?.map((dynamic e) => OfferData.fromJson(e as Map<String, dynamic>))
        .toList();
    firstPageUrl = json['first_page_url'] as String?;
    from = json['from'] as int?;
    lastPage = json['last_page'] as int?;
    lastPageUrl = json['last_page_url'] as String?;
    links = (json['links'] as List?)
        ?.map((dynamic e) => Links.fromJson(e as Map<String, dynamic>))
        .toList();
    nextPageUrl = json['next_page_url'];
    path = json['path'] as String?;
    perPage = json['per_page'] as int?;
    prevPageUrl = json['prev_page_url'];
    to = json['to'] as int?;
    total = json['total'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['current_page'] = currentPage;
    json['data'] = data?.map((e) => e.toJson()).toList();
    json['first_page_url'] = firstPageUrl;
    json['from'] = from;
    json['last_page'] = lastPage;
    json['last_page_url'] = lastPageUrl;
    json['links'] = links?.map((e) => e.toJson()).toList();
    json['next_page_url'] = nextPageUrl;
    json['path'] = path;
    json['per_page'] = perPage;
    json['prev_page_url'] = prevPageUrl;
    json['to'] = to;
    json['total'] = total;
    return json;
  }
}

class OfferData {
  int? id;
  String? title;
  String? image;
  String? text;
  String? price;
  String? priceAfterDiscount;
  String? startDate;
  String? endDate;
  int? subscribersAllowedNumber;
  String? createdAt;
  String? updatedAt;

  OfferData({
    this.id,
    this.title,
    this.image,
    this.text,
    this.price,
    this.priceAfterDiscount,
    this.startDate,
    this.endDate,
    this.subscribersAllowedNumber,
    this.createdAt,
    this.updatedAt,
  });

  OfferData.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    title = json['title'] as String?;
    image = json['image'] as String?;
    text = json['text'] as String?;
    price = json['price'] as String?;
    priceAfterDiscount = json['price_after_discount'] as String?;
    startDate = json['start_date'] as String?;
    endDate = json['end_date'] as String?;
    subscribersAllowedNumber = json['subscribers_allowed_number'] as int?;
    createdAt = json['created_at'] as String?;
    updatedAt = json['updated_at'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['title'] = title;
    json['image'] = image;
    json['text'] = text;
    json['price'] = price;
    json['price_after_discount'] = priceAfterDiscount;
    json['start_date'] = startDate;
    json['end_date'] = endDate;
    json['subscribers_allowed_number'] = subscribersAllowedNumber;
    json['created_at'] = createdAt;
    json['updated_at'] = updatedAt;
    return json;
  }
}

class Links {
  dynamic url;
  String? label;
  bool? active;

  Links({
    this.url,
    this.label,
    this.active,
  });

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'] as String?;
    active = json['active'] as bool?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['url'] = url;
    json['label'] = label;
    json['active'] = active;
    return json;
  }
}
