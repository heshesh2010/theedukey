/*
 * File name: phone_field_widget.dart
 * Last modified: 2022.05.18 at 11:31:14
 * Author: SmarterVision - https://codecanyon.net/user/smartervision
 * Copyright (c) 2022
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

class PhoneFieldWidget extends StatelessWidget {
  const PhoneFieldWidget(
      {Key? key,
      this.onSaved,
      this.onChanged,
      this.initialValue,
      this.hintText,
      this.errorText,
      this.labelText,
      this.obscureText,
      this.suffixIcon,
      this.style,
      this.textAlign,
      this.suffix,
      this.initialCountryCode,
      this.countries})
      : super(key: key);

  final FormFieldSetter<PhoneNumber>? onSaved;
  final ValueChanged<PhoneNumber>? onChanged;
  final String? initialValue;
  final String? hintText;
  final String? errorText;
  final TextAlign? textAlign;
  final String? labelText;
  final TextStyle? style;
  final bool? obscureText;
  final String? initialCountryCode;
  final List<String>? countries;

  final Widget? suffixIcon;
  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20, bottom: 14, left: 20, right: 20),
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            labelText ?? "",
            style: Get.textTheme.bodyText1,
            textAlign: textAlign ?? TextAlign.start,
          ),
          Directionality(
            textDirection: TextDirection.ltr,
            child: IntlPhoneField(
                key: key,
                onSaved: onSaved,
                onChanged: onChanged,
                initialValue: initialValue ?? '',
                initialCountryCode: initialCountryCode ?? 'SA',
                showDropdownIcon: false,
                pickerDialogStyle: PickerDialogStyle(
                    countryNameStyle: Get.textTheme.bodyText2),
                style: style ?? Get.textTheme.bodyText2,
                textAlign: textAlign ?? TextAlign.start,
                disableLengthCheck: false,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  hintText: hintText ?? '',
                  hintStyle: Get.textTheme.caption,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  contentPadding: const EdgeInsets.all(0),
                  border: const OutlineInputBorder(borderSide: BorderSide.none),
                  focusedBorder:
                      const OutlineInputBorder(borderSide: BorderSide.none),
                  enabledBorder:
                      const OutlineInputBorder(borderSide: BorderSide.none),
                  // suffixIcon: suffixIcon,
                  // suffix: suffix,
                  // errorText: errorText,
                )),
          ),
        ],
      ),
    );
  }
}
