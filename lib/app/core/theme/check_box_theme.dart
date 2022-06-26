import 'package:flutter/material.dart';

CheckboxThemeData appCheckboxTheme = CheckboxThemeData(
  checkColor: MaterialStateProperty.all(const Color(0xFF19BAB2)),
  splashRadius: 15,
  fillColor: MaterialStateProperty.all(Colors.transparent),
  overlayColor: MaterialStateProperty.all(Colors.grey),
  side: MaterialStateBorderSide.resolveWith(
      (states) => const BorderSide(color: Color(0xEEEEEEEE))),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
);
