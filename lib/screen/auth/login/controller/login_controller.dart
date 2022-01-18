import 'package:chatnest/service/authService.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  static LoginController get to => Get.find();

  @override
  onInit() {
    super.onInit();
  }

  Rx<bool> emailValable = false.obs;
  Rx<bool> passwordValiable = false.obs;
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  Future<void> LoginProcess() async {
    var respone = await AuthService.to
        .sign(email: emailController.text, password: passwordController.text);
  }

  bool get onLogin => emailValable.value && passwordValiable.value;
  bool get email => emailValable.value;
  bool get password => passwordValiable.value;
}
