import 'package:chatnest/components/modals/customAlertModal.dart';
import 'package:chatnest/screen/auth/signup/view/signup_screen.dart';
import 'package:chatnest/service/authService.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class SignUpController extends GetxController {
  static SignUpController get to => Get.find();
  // email: string;
  // password: string;
  // profile: string;
  // nickName: string;
  // createdAt: Date;
  // device_token: string;
  @override
  onInit() {
    super.onInit();
  }

  Rx<bool> emailValable = false.obs;
  Rx<bool> passwordValiable = false.obs;
  Rx<bool> nickNameValiable = false.obs;
  XFile? file = null;
  Rx<String> file_path = "".obs;

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController nickNameController = new TextEditingController();

  Future<void> SignUpProcess() async {
    var respone = await AuthService.to.signup(
        email: emailController.text,
        password: passwordController.text,
        nickName: nickNameController.text,
        profile: file!);
  }

  Future<void> LoadAssetsImage() async {
    String error = 'No Error Detected';
    print(1234);
    try {
      XFile? imagepicker =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (imagepicker == null) return;
      String filename = imagepicker.name.split(".").last;
      if (filename != "png" && filename != 'jpg' && filename != 'jpeg')
        return null;
      file = imagepicker;
      file_path(imagepicker.path);
    } on Exception catch (e) {
      error = e.toString();
      if (await Permission.photos.status.isPermanentlyDenied ||
          await Permission.photos.status.isDenied) {
        await Get.dialog(CustomAlertModal(
          msg: "갤러리에 대한 \n접근권한이 필요합니다.",
          cancle_title: "닫기",
          title: '접근권한 오류',
        ));
        openAppSettings();
      } else {
        await Get.dialog(CustomAlertModal(
          msg: error,
          cancle_title: "닫기",
          title: '에러',
        ));
      }
    }
  }

  // bool get onLogin => emailValable.value && passwordValiable.value && ;
  bool get email => emailValable.value;
  bool get password => passwordValiable.value;
  bool get nickName => nickNameValiable.value;
}
