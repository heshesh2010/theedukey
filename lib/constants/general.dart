


import 'package:flutter/material.dart';

/// some constants Local Key
const kLocalKey = {
  "userInfo": "userInfo",
  "shippingAddress": "shippingAddress",
  "recentSearches": "recentSearches",
  "wishlist": "wishlist",
  "home": "home",
  "countries": "countries",
};



/// Logging config
const kLogTag = "[ تطبيق EduKey client]";
const kLogEnable = true;

void printLog(dynamic data) {
  if (kLogEnable) {
    /// "y-m-d h:min:sec.msZ"
    final String now = DateTime.now().toUtc().toString().split(' ').last;
    debugPrint("[$now]$kLogTag${data.toString()}");
  }
}



const ApiPageSize = 20;
