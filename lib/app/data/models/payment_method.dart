import 'dart:convert';

class PaymentMethod {
  PaymentMethod(
      {this.id, this.name, this.min, this.max, this.image, this.method});

  final int? id;
  final String? name;
  final int? min;
  final int? max;
  final String? image;
  final String? method;

  factory PaymentMethod.fromJson(String str) =>
      PaymentMethod.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PaymentMethod.fromMap(Map<String, dynamic> json) => PaymentMethod(
        id: json["id"],
        name: json["name"],
        min: json["min"],
        max: json["max"],
        image: json["image"],
        method: json["method"],
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaymentMethod &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          min == other.min &&
          max == other.max &&
          method == other.method &&
          image == other.image;

  @override
  int get hashCode => id.hashCode ^ name.hashCode;

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "min": min,
        "max": max,
        "image": image,
        "method": method,
      };
}
