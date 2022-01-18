import 'package:chatnest/screen/auth/login/controller/login_controller.dart';
import 'package:chatnest/styles/color.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginScreen extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          width: double.infinity,
          height: double.infinity,
          color: AppColor.bodyColorDark,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  "Chat Login",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 50.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.w),
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
                    print(EmailValidator.validate(text));
                    controller.emailValable(EmailValidator.validate(text));
                  },
                ),
              ),
              Obx(() => !controller.email
                  ? Container(
                      padding: EdgeInsets.only(left: 20.w),
                      child: Text('email is not valiable',
                          style: TextStyle(color: Colors.red)))
                  : Container()),
              SizedBox(height: 15.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.w),
                decoration: BoxDecoration(
                  color: AppColor.bodyColorDark,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: TextField(
                  controller: controller.passwordController,
                  obscureText: true,
                  style: TextStyle(color: AppColor.textColorDark),
                  decoration: InputDecoration(
                      prefixIcon:
                          Icon(Icons.lock, color: AppColor.textColorDark),
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
              Obx(() => !controller.password
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
                        if (controller.onLogin) {
                          await controller.LoginProcess();
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColor.buttonBackgroundColorDark,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 10.w),
                        child: Text(
                          "Login",
                          style: TextStyle(
                            color: AppColor.textColorDark,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColor.buttonBackgroundColorDark,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 10.w),
                        child: Text(
                          "Go to SignUp",
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
        ),
      ),
      // ),
    );
  }
}
