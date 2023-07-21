import 'package:flutter/material.dart';
import 'package:theedukey/app/core/theme/radio_theme.dart';
import 'package:theedukey/config/app_config.dart';
import 'check_box_theme.dart';
import 'input_decoration_theme.dart';
import 'text_theme.dart';

final ThemeData appThemeDataLight = ThemeData(
  inputDecorationTheme: appInputDecorationTheme,
  fontFamily: 'Jannat',
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.resolveWith((states) {
        // If the button is pressed, return size 40, otherwise 20
        if (states.contains(MaterialState.pressed)) {
          return AppColors().secondColor(1);
        }
        return AppColors().textColor(1);
      }),
      backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (states) => AppColors().shimmerLight(1)),
      shape: MaterialStateProperty.resolveWith<OutlinedBorder>((_) {
        return RoundedRectangleBorder(borderRadius: BorderRadius.circular(20));
      }),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      textStyle: MaterialStateProperty.resolveWith<TextStyle>(
          (Set<MaterialState> states) {
        return const TextStyle(
            fontFamily: 'Jannat',
            fontWeight: FontWeight.bold); // Use the component's default.
      }),
      foregroundColor: MaterialStateProperty.resolveWith((states) {
        // If the button is pressed, return size 40, otherwise 20
        if (states.contains(MaterialState.pressed)) {
          return AppColors().secondColor(1);
        }
        return Colors.white;
      }),
      backgroundColor: MaterialStateProperty.resolveWith((states) {
        // If the button is pressed, return size 40, otherwise 20
        if (states.contains(MaterialState.pressed)) {
          return Colors.white;
        }
        return AppColors().secondColor(1);
      }),
      shape: MaterialStateProperty.resolveWith((states) {
        // If the button is pressed, return size 40, otherwise 20
        if (states.contains(MaterialState.pressed)) {
          return RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(color: AppColors().secondColor(1)));
        }
        return RoundedRectangleBorder(borderRadius: BorderRadius.circular(20));
      }),
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors().secondColor(1),
      foregroundColor: Colors.white,
      splashColor: AppColors().mainColor(1)
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),

  checkboxTheme: appCheckboxTheme,
  radioTheme: appRadioTheme,
  primaryColor: AppColors().mainColor(1),
  focusColor: AppColors().secondColor(1), // black
  //   hintColor: config.AppColors().mainColor(1), //
  colorScheme: ThemeData().colorScheme.copyWith(primary: Colors.black),
  textTheme: appTextTheme,
  primarySwatch: Colors.blue,
);
