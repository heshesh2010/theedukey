import 'package:flutter/foundation.dart';
import 'package:theedukey/app/data/models/payment_method.dart';
import 'package:theedukey/app/data/models/stage.dart';

class FilterData {
  final bool? status;
  final FilterDataData? data;

  FilterData({
    this.status,
    this.data,
  });

  FilterData.fromJson(Map<String, dynamic> json)
      : status = json['status'] as bool?,
        data = (json['data'] as Map<String, dynamic>?) != null
            ? FilterDataData.fromJson(json['data'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() => {'status': status, 'data': data?.toJson()};

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FilterData && other.status == status && other.data == data;
  }

  @override
  int get hashCode => status.hashCode ^ data.hashCode;
}

class FilterDataData {
  final List<Stage>? stages;
  final List<PaymentMethod>? paymentMethods;
  List<int>? ratings = [1, 2, 3, 4, 5];

  FilterDataData({this.stages, this.paymentMethods, this.ratings});

  FilterDataData.fromJson(Map<String, dynamic> json)
      : stages = (json['stages'] as List?)
            ?.map((dynamic e) => Stage.fromMap(e as Map<String, dynamic>))
            .toList(),
        paymentMethods = (json['payment_methods'] as List?)
            ?.map(
                (dynamic e) => PaymentMethod.fromMap(e as Map<String, dynamic>))
            .toList();
  //   ratings = (json['ratings'] as List<int>?);
  Map<String, dynamic> toJson() => {
        'stages': stages?.map((e) => e.toJson()).toList(),
        'payment_methods': paymentMethods?.map((e) => e.toJson()).toList(),
        'ratings': ratings,
      };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FilterDataData &&
        listEquals(other.stages, stages) &&
        listEquals(other.paymentMethods, paymentMethods) &&
        listEquals(other.ratings, ratings);
  }

  @override
  int get hashCode =>
      stages.hashCode ^ paymentMethods.hashCode ^ ratings.hashCode;
}
