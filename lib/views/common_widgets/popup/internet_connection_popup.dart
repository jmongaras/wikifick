import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../utils/my_colors.dart';

class ShowInterNetToastDialog {

  static showToast(String message,Color textColor) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      fontSize: 14.sp,
      backgroundColor: MyColors.transparentColor.withValues(alpha: 0.5),
      textColor: textColor,
    );
  }

  static showLoader() {
    EasyLoading.instance
      ..loadingStyle = EasyLoadingStyle.custom
      ..backgroundColor = MyColors.transparentColor
      ..indicatorColor = MyColors.whiteColor
      ..textColor = MyColors.whiteColor
      ..indicatorType = EasyLoadingIndicatorType.wave
      ..dismissOnTap = false;
  }

  static showNotInternetMsg() {
    EasyLoading.instance
      ..loadingStyle = EasyLoadingStyle.custom
      ..backgroundColor = MyColors.transparentColor
      ..indicatorColor = MyColors.whiteColor
      ..textColor = MyColors.whiteColor
      ..indicatorType = EasyLoadingIndicatorType.wave
      ..dismissOnTap = false;

    EasyLoading.show(
      status: "No internet connection...",
      maskType: EasyLoadingMaskType.clear,
    );
  }

  static closeLoader() {
    EasyLoading.dismiss();
  }

}
