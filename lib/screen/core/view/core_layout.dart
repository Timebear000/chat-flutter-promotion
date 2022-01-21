import 'package:chatnest/screen/core/controller/core_controller.dart';
import 'package:chatnest/styles/color.dart';
import 'package:chatnest/styles/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CoreHomeScreen extends GetView<CoreController> {
  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.only(top: statusBarHeight),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Text("Chat Service", style: AppTextStyle.AppBar),
              padding: EdgeInsets.symmetric(vertical: 5.w, horizontal: 20.w),
            ),
            SizedBox(height: 5.w),
            Container(
              width: double.infinity,
              child: Row(
                children: [
                  Text("My", style: AppTextStyle.SelectedCategory),
                  SizedBox(width: 10.w),
                  Text("Rooms", style: AppTextStyle.SelectedNotCategory),
                ],
              ),
              padding: EdgeInsets.symmetric(vertical: 5.w, horizontal: 20.w),
            ),
            Container(
                color: AppColor.bodyColor, width: double.infinity, height: 1.w),
            SizedBox(height: 10.w),
            Expanded(child: Container())
          ],
        ),
      ),
    );
  }
}
