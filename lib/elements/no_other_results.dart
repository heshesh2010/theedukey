import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoOtherResults extends StatelessWidget {
  const NoOtherResults({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(80),
          child: Center(child: Text("no_other_results".tr))),
    );
  }
}
