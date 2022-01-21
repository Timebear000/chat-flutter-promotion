import 'package:chatnest/routes/app_page.dart';
import 'package:chatnest/screen/auth/signup/controller/signup_controller.dart';
import 'package:chatnest/styles/color.dart';
import 'package:chatnest/styles/image.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SignUpScreen extends GetView<SignUpController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              child: Text(
                "Chat Message App SignUp",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 50.w),
            Container(
                width: double.infinity,
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () async {
                    await controller.LoadAssetsImage();
                  },
                  child: Container(
                    padding: EdgeInsets.all(1.w),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Obx(
                      () => controller.file_path == ""
                          ? CircleAvatar(
                              radius: 40.r,
                              backgroundImage: AssetImage(AppImages.profileImg))
                          : CircleAvatar(
                              radius: 40.r,
                              backgroundImage:
                                  AssetImage(controller.file_path.value),
                            ),
                    ),
                  ),
                ),
                alignment: Alignment.center),
            SizedBox(height: 15.w),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 5.w),
              decoration: BoxDecoration(
                color: AppColor.bodyColorDark,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: TextField(
                controller: controller.emailController,
                style: TextStyle(color: AppColor.textColorDark),
                decoration: InputDecoration(
                    prefixIcon:
                        Icon(Icons.email, color: AppColor.textColorDark),
                    hintStyle: TextStyle(color: AppColor.textColorDark),
                    border: InputBorder.none,
                    hintText: "Email"),
                onChanged: (text) {
                  // print(EmailValidator.validate(text));
                  controller.emailValable(EmailValidator.validate(text));
                },
              ),
            ),
            Obx(() =>
                !controller.email && controller.emailController.text.length != 0
                    ? Container(
                        padding: EdgeInsets.only(left: 0.w),
                        child: Text('email is not valiable',
                            style: TextStyle(color: Colors.red)))
                    : Container()),
            SizedBox(height: 15.w),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 5.w),
              decoration: BoxDecoration(
                color: AppColor.bodyColorDark,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: TextField(
                controller: controller.nickNameController,
                style: TextStyle(color: AppColor.textColorDark),
                decoration: InputDecoration(
                    prefixIcon:
                        Icon(Icons.person_pin, color: AppColor.textColorDark),
                    hintStyle: TextStyle(color: AppColor.textColorDark),
                    border: InputBorder.none,
                    hintText: "NickName"),
                onChanged: (text) {
                  controller.nickNameValiable(false);
                },
              ),
            ),
            Obx(() => !controller.nickName &&
                    controller.nickNameController.text.length != 0
                ? Container(
                    padding: EdgeInsets.only(left: 0.w),
                    child: Text('nick enable check',
                        style: TextStyle(color: Colors.red)))
                : Container()),
            SizedBox(height: 15.w),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 5.w),
              decoration: BoxDecoration(
                color: AppColor.bodyColorDark,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: TextField(
                controller: controller.passwordController,
                obscureText: true,
                style: TextStyle(color: AppColor.textColorDark),
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock, color: AppColor.textColorDark),
                    hintStyle: TextStyle(color: AppColor.textColorDark),
                    border: InputBorder.none,
                    hintText: "Password"),
                onChanged: (text) {
                  (text.length >= 4)
                      ? controller.passwordValiable(true)
                      : controller.passwordValiable(false);
                },
              ),
            ),
            Obx(() => !controller.password &&
                    controller.passwordController.text.length != 0
                ? Container(
                    padding: EdgeInsets.only(left: 20.w),
                    child: Text('password is not valiable min 4 length',
                        style: TextStyle(color: Colors.red)))
                : Container()),
            SizedBox(height: 15.w),
            SizedBox(height: 35.w),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () async {
                      await controller.SignUpProcess();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColor.buttonBackgroundColorDark,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 10.w),
                      child: Text(
                        "SignUp",
                        style: TextStyle(
                          color: AppColor.textColorDark,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.LOGIN);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColor.buttonBackgroundColorDark,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 10.w),
                      child: Text(
                        "Go to Sign",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      alignment: Alignment.centerRight,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
