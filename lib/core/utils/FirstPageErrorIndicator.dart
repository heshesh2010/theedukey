import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/src/ui/default_indicators/first_page_exception_indicator.dart';
import 'package:get/get.dart';

import 'custom_First_page_exception_indicator.dart';

class FirstPageErrorIndicator extends StatelessWidget {
  const FirstPageErrorIndicator({
    this.onTryAgain,
    Key? key,
    this.error,
  }) : super(key: key);

  final VoidCallback? onTryAgain;
  final TypeError? error;
  @override
  Widget build(BuildContext context) => CustomFirstPageExceptionIndicator(
        title: "FirstPageException_title".tr,
        message: 'FirstPageException_message'.tr,
        onTryAgain: onTryAgain,
      );
}
