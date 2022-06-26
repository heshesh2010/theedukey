class Notification {
  bool? status;
  Data? data;

  Notification({
    this.status,
    this.data,
  });

  Notification.fromJson(Map<String, dynamic> json) {
    status = json['status'] as bool?;
    data = (json['data'] as Map<String, dynamic>?) != null
        ? Data.fromJson(json['data'] as Map<String, dynamic>)
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['status'] = status;
    json['data'] = data?.toJson();
    return json;
  }
}

class Data {
  int? currentPage;
  List<NotificationData>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
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
        ?.map(
            (dynamic e) => NotificationData.fromJson(e as Map<String, dynamic>))
        .toList();
    firstPageUrl = json['first_page_url'] as String?;
    from = json['from'] as int?;
    lastPage = json['last_page'] as int?;
    lastPageUrl = json['last_page_url'] as String?;
    links = (json['links'] as List?)
        ?.map((dynamic e) => Links.fromJson(e as Map<String, dynamic>))
        .toList();
    nextPageUrl = json['next_page_url'] as String?;
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

class NotificationData {
  int? id;
  dynamic title;
  dynamic text;
  int? status;
  String? createdAt;

  NotificationData({
    this.id,
    this.title,
    this.text,
    this.status,
    this.createdAt,
  });

  NotificationData.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    title = json['title'];
    text = json['text'];
    status = json['status'] as int?;
    createdAt = json['created_at'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['title'] = title;
    json['text'] = text;
    json['status'] = status;
    json['created_at'] = createdAt;
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
