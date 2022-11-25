import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:push_notification/Utils/AppString.dart';


class UtilsLiveDj{
  static errorSnackBar(String? message) {
    if (message == null) {
      return;
    }
    Get.closeAllSnackbars();
    Get.snackbar(
      AppString.appName,
      message,
      backgroundColor: Colors.blue,
      padding: EdgeInsets.only(left: 20.h, bottom: 10.h),
      margin: EdgeInsets.fromLTRB(10.h, 10.h, 10.h, 10.h),
      borderRadius: 5.h,
      snackPosition: SnackPosition.TOP,
      colorText: Colors.white,
      titleText: Text(
        AppString.appName,
        textAlign: TextAlign.start,
        style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 18,
            height: 1.6),
      ),
      messageText: Text(
        message,
        textAlign: TextAlign.start,
        style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontSize: 18,
            height: 1.6),
      ),
    );
  }

  static hideKeyboard(context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static Future<bool> hasNetwork() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    } else {
      return true;
    }
  }

}
