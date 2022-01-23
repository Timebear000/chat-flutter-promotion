import 'package:chatnest/screen/auth/login/controller/login_controller.dart';
import 'package:chatnest/screen/auth/login/view/login_screen.dart';
import 'package:chatnest/screen/auth/signup/controller/signup_controller.dart';
import 'package:chatnest/screen/auth/signup/view/signup_screen.dart';
import 'package:chatnest/screen/chat/controller/chat_controller.dart';
import 'package:chatnest/screen/chat/view/chat_view.dart';
import 'package:chatnest/screen/core/controller/core_controller.dart';
import 'package:chatnest/screen/core/view/core_layout.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.Core,
      page: () => CoreHomeScreen(),
      binding: BindingsBuilder(
        () => Get.lazyPut<CoreController>(
          () => CoreController(),
        ),
      ),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginScreen(),
      binding: BindingsBuilder(
        () => Get.put<LoginController>(
          LoginController(),
        ),
      ),
    ),
    GetPage(
      name: _Paths.Register,
      page: () => SignUpScreen(),
      binding: BindingsBuilder(
        () => Get.lazyPut<SignUpController>(
          () => SignUpController(),
        ),
      ),
    ),
    GetPage(
      name: '/chat/:room_id',
      page: () => ChatView(),
      binding: BindingsBuilder(
        () => Get.lazyPut<ChatController>(
          () => ChatController(),
        ),
      ),
    ),
  ];
}
