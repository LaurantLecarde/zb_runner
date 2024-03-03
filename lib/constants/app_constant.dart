import 'package:flutter/material.dart';

class AppColors {
  static Color appColor = const Color(0xff3f4677);
}

mainTheme(context){
  final mainTheme = Theme.of(context).primaryColor;
  return mainTheme;
}