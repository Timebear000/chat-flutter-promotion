import 'package:chatnest/screen/auth/login/controller/login_controller.dart';
import 'package:chatnest/screen/auth/login/view/login_screen.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    // GetPage(
    //   name: _Paths.HOME,
    //   page: () => HomeScreen(),
    //   binding: BindingsBuilder(
    //     () => Get.lazyPut<HomeController>(
    //       () => HomeController(),
    //     ),
    //   ),
    // ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginScreen(),
      binding: BindingsBuilder(
        () => Get.put<LoginController>(
          LoginController(),
        ),
      ),
    ),
    // GetPage(
    //   name: _Paths.Register,
    //   page: () => RegisterScreen(),
    //   binding: BindingsBuilder(
    //     () => Get.lazyPut<RegisterController>(
    //       () => RegisterController(),
    //     ),
    //   ),
    // ),
  ];
}
