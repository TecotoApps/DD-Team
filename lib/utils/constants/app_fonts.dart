import 'package:dd_shop/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class AppFonts {
  static const TextStyle header1 = TextStyle(
      fontSize: 26.0, fontWeight: FontWeight.w700, fontFamily: 'Montserrat');
  static const TextStyle header = TextStyle(
      fontSize: 24.0, fontWeight: FontWeight.w600, fontFamily: 'Montserrat');

  static const TextStyle subHeader = TextStyle(
      fontSize: 18.0, fontWeight: FontWeight.bold, fontFamily: 'Montserrat');

  static const TextStyle title =
  TextStyle(fontSize: 16.0, color: Colors.black,fontWeight: FontWeight.w500, fontFamily: 'Montserrat');

  static const TextStyle smallText =
  TextStyle(fontSize: 12.0, color: Colors.black,fontWeight: FontWeight.w400, fontFamily: 'Montserrat');

  static const TextStyle appBarText =
  TextStyle(fontSize: 20.0, color: AppColors.textColor,fontWeight: FontWeight.w500, fontFamily: 'Montserrat');
}