import 'package:chatnest/styles/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyle {
  static TextStyle ModalTitle = TextStyle(
    color: AppColor.textColorDark,
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
  );
  static TextStyle ModalMessage = TextStyle(
    color: AppColor.textColorDark,
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
  );
  static TextStyle ModalOk = TextStyle(
    color: AppColor.textColorDark,
    fontSize: 15.sp,
    fontWeight: FontWeight.bold,
  );
}
