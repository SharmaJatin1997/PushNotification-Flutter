import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class AppColors{
  AppColors._();
  static const Color greenColor =  Color(0xff8CD50A);
  static const Color dropShadowGrey =  Color(0xff00000029);
  static const Color greyColor = Color(0xffC4C4C4);
  static const Color boldGrey = Color(0xff707070);
  static const Color whiteColor = Color(0x00f5f5f5);
  static const Color  darkGreenColor = Color(0xff609402);
  static const Color yellowColor = Color(0xffFFD70F);
  static const Color redColor = Color(0xffF80909);
  static const Color blackColor = Color(0xff000000);
  static const Color themeColor = Color(0xFF8CD50A);
  static const Color toolbarBgColor = Color(0xFF666666);
  static const Color white = Color(0xFFFFFFFF);
  static const Color grey = Color(0xffA2A2A2);
  static const Color otpFieldColor = Color(0xffEBEBEB);

  static SystemUiOverlayStyle mySystemTheme=   const SystemUiOverlayStyle(
    statusBarColor: themeColor,
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.light,

  );


}