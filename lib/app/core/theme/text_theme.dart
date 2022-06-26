import 'package:flutter/material.dart';
import 'package:theedukey/config/app_config.dart' as config;

import '../../../config/app_config.dart';

final TextTheme appTextTheme = const TextTheme()
    .copyWith(
      headline2: const TextStyle(
        height: 1,
        //  fontSize: 20.0,
      ),
      headline6: const TextStyle(
        height: 1,
        fontSize: 30.0,
      ),
      subtitle1:
          TextStyle(height: 1, fontSize: 15.0, color: AppColors().textColor(1)),
      bodyText2:
          TextStyle(height: 1, fontSize: 15.0, color: AppColors().textColor(1)),
      caption: const TextStyle(
        height: 1,
        fontSize: 15.0,
      ),
      button: const TextStyle(
        height: 1,
        //   fontSize: 10.0,
      ),
      overline: const TextStyle(
        height: 1,
        fontSize: 20.0,
      ),
      headline1: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: config.AppColors().mainColor(1)),
      headline5: TextStyle(
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
          color: config.AppColors().mainColor(1)),
    )
    .apply(
      fontFamily: 'Jannat',
    );
