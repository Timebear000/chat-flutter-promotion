import 'package:chatnest/styles/color.dart';
import 'package:chatnest/styles/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomAlertModal extends StatelessWidget {
  final String? title;
  final String msg;
  final String cancle_title;
  final Function? onTap;

  const CustomAlertModal({
    this.title,
    required this.msg,
    this.cancle_title = "확인",
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.w)),
        child: Container(
            width: 290.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.w),
              color: AppColor.modalBodyColor,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 26.w, left: 20.w, right: 20.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      this.title != null ? SizedBox(height: 15.w) : Container(),
                      this.title != null
                          ? Text(title!, style: AppTextStyle.ModalTitle)
                          : Container(),
                      SizedBox(height: 15.w),
                      Container(
                        child: Text(
                          msg,
                          style: AppTextStyle.ModalMessage,
                          textAlign: TextAlign.center,
                        ),
                        alignment: Alignment.center,
                      ),
                      SizedBox(height: 26.w),
                    ],
                  ),
                ),
                Container(
                  height: 40.w,
                  margin: EdgeInsets.symmetric(vertical: 15.w),
                  child: InkWell(
                    onTap: () {
                      Get.back();
                      if (onTap != null) onTap!();
                    },
                    child: Container(
                      child: Text(
                        cancle_title,
                        style: AppTextStyle.ModalOk,
                      ),
                      alignment: Alignment.center,
                    ),
                  ),
                ),
              ],
            )));
  }
}
