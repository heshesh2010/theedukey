import 'package:flutter/material.dart';

import '../../../config/app_config.dart';

RadioThemeData appRadioTheme = RadioThemeData(
    splashRadius: 15,
    fillColor:
        MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
      return states.contains(MaterialState.selected)
          ? AppColors().secondColor(1)
          : const Color(0xEEEEEEEE);
    }),
    overlayColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.pressed)) {
        return Colors.grey;
      }
      if (states.contains(MaterialState.hovered)) {
        return Colors.red;
      }
      return Colors.green;
    }));
