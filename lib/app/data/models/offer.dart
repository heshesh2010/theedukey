class Offer {
  Offer({
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
  late final List<OfferData>? data;
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

  Offer.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    data = List.from(json['data']).map((e) => OfferData.fromJson(e)).toList();
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

class OfferData {
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
  late final int? id;
  late final String? title;
  late final String? image;
  late final String? text;
  late final String? price;
  late final String? priceAfterDiscount;
  late final String? startDate;
  late final String? endDate;
  late final int? subscribersAllowedNumber;
  late final String? createdAt;
  late final String? updatedAt;

  OfferData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    text = json['text'];
    price = json['price'];
    priceAfterDiscount = json['price_after_discount'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    subscribersAllowedNumber = json['subscribers_allowed_number'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['image'] = image;
    _data['text'] = text;
    _data['price'] = price;
    _data['price_after_discount'] = priceAfterDiscount;
    _data['start_date'] = startDate;
    _data['end_date'] = endDate;
    _data['subscribers_allowed_number'] = subscribersAllowedNumber;
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
