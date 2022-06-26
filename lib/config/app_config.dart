import 'dart:core';

import 'package:flutter/material.dart';

class AppColors {
//  Color _mainColor = Color(0xFFFF4E6A);
  final Color _mainColor = const Color(0xFF076996);
  final Color _mainDarkColor = const Color(0xFF121212);

  final Color _secondColor = const Color(0xFF19BAB2);
  final Color _secondDarkColor = const Color(0xFFffffff);

  final Color _accentColor = const Color(0xFF19BAB2);
  final Color _accentDarkColor = const Color(0xFF076996);

  final Color _nonActiveColorLight = const Color(0xFF757575);
  final Color _nonActiveColorDark = const Color(0xFF121212);

  final Color _shimmerLight = Colors.grey.shade100;
  final Color _shimmerDark = Colors.grey.shade600;

  final Color _textColor = const Color(0xFF474747);

  Color textColor(double opacity) {
    return _textColor.withOpacity(opacity);
  }

  Color mainColor(double opacity) {
    return _mainColor.withOpacity(opacity);
  }

  Color secondColor(double opacity) {
    return _secondColor.withOpacity(opacity);
  }

  Color accentColor(double opacity) {
    return _accentColor.withOpacity(opacity);
  }

  Color mainDarkColor(double opacity) {
    return _mainDarkColor.withOpacity(opacity);
  }

  Color secondDarkColor(double opacity) {
    return _secondDarkColor.withOpacity(opacity);
  }

  Color accentDarkColor(double opacity) {
    return _accentDarkColor.withOpacity(opacity);
  }

  Color nonActiveColorLight(double opacity) {
    return _nonActiveColorLight.withOpacity(opacity);
  }

  Color nonActiveColorDark(double opacity) {
    return _nonActiveColorDark.withOpacity(opacity);
  }

  Color shimmerLight(double opacity) {
    return _shimmerLight.withOpacity(opacity);
  }

  Color shimmerDark(double opacity) {
    return _shimmerDark.withOpacity(opacity);
  }
}
