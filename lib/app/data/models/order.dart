///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class OrderDataLinks {
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

  OrderDataLinks({
    this.url,
    this.label,
    this.active,
  });
  OrderDataLinks.fromJson(Map<String, dynamic> json) {
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

class OrderDataData {
/*
{
  "order_num": 8,
  "order_child_id": 1,
  "order_status": "new",
  "InvoiceId": null,
  "service_provider": "lovely school",
  "service_name": "test price",
  "from": "2021-03-16",
  "to": "2021-03-16",
  "price_after_discount": "400",
  "price_before_discount": "500",
  "class": "3rd secondary",
  "stage": "High-school",
  "subscription_typr": "Semester Early",
  "orderd_at": "2022-02-01 17:34:29",
  "last_update": "2022-02-01 17:34:29",
  "normal_status": ""
} 
*/

  int? orderNum;
  int? orderChildId;
  String? orderStatus;
  String? InvoiceId;
  String? serviceProvider;
  String? serviceName;
  String? from;
  String? to;
  String? priceAfterDiscount;
  String? priceBeforeDiscount;
  String? theClass;
  String? stage;
  String? subscriptionTypr;
  String? orderdAt;
  String? lastUpdate;
  String? normalStatus;

  OrderDataData(
      {this.orderNum,
      this.orderChildId,
      this.orderStatus,
      this.InvoiceId,
      this.serviceProvider,
      this.serviceName,
      this.from,
      this.to,
      this.priceAfterDiscount,
      this.priceBeforeDiscount,
      this.theClass,
      this.stage,
      this.subscriptionTypr,
      this.orderdAt,
      this.lastUpdate,
      this.normalStatus});
  OrderDataData.fromJson(Map<String, dynamic> json) {
    orderNum = json['order_num']?.toInt();
    orderChildId = json['order_child_id']?.toInt();
    orderStatus = json['order_status']?.toString();
    InvoiceId = json['InvoiceId']?.toString();
    serviceProvider = json['service_provider']?.toString();
    serviceName = json['service_name']?.toString();
    from = json['from']?.toString();
    to = json['to']?.toString();
    priceAfterDiscount = json['price_after_discount']?.toString();
    priceBeforeDiscount = json['price_before_discount']?.toString();
    theClass = json['class']?.toString();
    stage = json['stage']?.toString();
    subscriptionTypr = json['subscription_typr']?.toString();
    orderdAt = json['orderd_at']?.toString();
    lastUpdate = json['last_update']?.toString();
    normalStatus = json['normal_status']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['order_num'] = orderNum;
    data['order_child_id'] = orderChildId;
    data['order_status'] = orderStatus;
    data['InvoiceId'] = InvoiceId;
    data['service_provider'] = serviceProvider;
    data['service_name'] = serviceName;
    data['from'] = from;
    data['to'] = to;
    data['price_after_discount'] = priceAfterDiscount;
    data['price_before_discount'] = priceBeforeDiscount;
    data['class'] = theClass;
    data['stage'] = stage;
    data['subscription_typr'] = subscriptionTypr;
    data['orderd_at'] = orderdAt;
    data['last_update'] = lastUpdate;
    data['normal_status'] = normalStatus;

    return data;
  }
}

class OrderData {
/*
{
  "current_page": 1,
  "data": [
    {
      "order_num": 8,
      "order_child_id": 1,
      "order_status": "new",
      "InvoiceId": null,
      "service_provider": "lovely school",
      "service_name": "test price",
      "from": "2021-03-16",
      "to": "2021-03-16",
      "price_after_discount": "400",
      "price_before_discount": "500",
      "class": "3rd secondary",
      "stage": "High-school",
      "subscription_typr": "Semester Early",
      "orderd_at": "2022-02-01 17:34:29",
      "last_update": "2022-02-01 17:34:29",
      "normal_status": ""
    }
  ],
  "first_page_url": "https://dev17.toplinedev.com/theedukey/public/api/student-auth/orders?page=1",
  "from": 1,
  "last_page": 1,
  "last_page_url": "https://dev17.toplinedev.com/theedukey/public/api/student-auth/orders?page=1",
  "links": [
    {
      "url": null,
      "label": "&laquo; السابق",
      "active": false
    }
  ],
  "next_page_url": null,
  "path": "https://dev17.toplinedev.com/theedukey/public/api/student-auth/orders",
  "per_page": 10,
  "prev_page_url": null,
  "to": 8,
  "total": 8
} 
*/

  int? currentPage;
  List<OrderDataData?>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<OrderDataLinks?>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  OrderData({
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
  OrderData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page']?.toInt();
    if (json['data'] != null) {
      final v = json['data'];
      final arr0 = <OrderDataData>[];
      v.forEach((v) {
        arr0.add(OrderDataData.fromJson(v));
      });
      data = arr0;
    }
    firstPageUrl = json['first_page_url']?.toString();
    from = json['from']?.toInt();
    lastPage = json['last_page']?.toInt();
    lastPageUrl = json['last_page_url']?.toString();
    if (json['links'] != null) {
      final v = json['links'];
      final arr0 = <OrderDataLinks>[];
      v.forEach((v) {
        arr0.add(OrderDataLinks.fromJson(v));
      });
      links = arr0;
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

class Order {
/*
{
  "status": true,
  "data": {
    "current_page": 1,
    "data": [
      {
        "order_num": 8,
        "order_child_id": 1,
        "order_status": "new",
        "InvoiceId": null,
        "service_provider": "lovely school",
        "service_name": "test price",
        "from": "2021-03-16",
        "to": "2021-03-16",
        "price_after_discount": "400",
        "price_before_discount": "500",
        "class": "3rd secondary",
        "stage": "High-school",
        "subscription_typr": "Semester Early",
        "orderd_at": "2022-02-01 17:34:29",
        "last_update": "2022-02-01 17:34:29",
        "normal_status": ""
      }
    ],
    "first_page_url": "https://dev17.toplinedev.com/theedukey/public/api/student-auth/orders?page=1",
    "from": 1,
    "last_page": 1,
    "last_page_url": "https://dev17.toplinedev.com/theedukey/public/api/student-auth/orders?page=1",
    "links": [
      {
        "url": null,
        "label": "&laquo; السابق",
        "active": false
      }
    ],
    "next_page_url": null,
    "path": "https://dev17.toplinedev.com/theedukey/public/api/student-auth/orders",
    "per_page": 10,
    "prev_page_url": null,
    "to": 8,
    "total": 8
  }
} 
*/

  bool? status;
  OrderData? data;

  Order({
    this.status,
    this.data,
  });
  Order.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = (json['data'] != null) ? OrderData.fromJson(json['data']) : null;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['data'] = this.data!.toJson();
    return data;
  }
}
