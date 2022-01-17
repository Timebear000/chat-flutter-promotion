import 'dart:async';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends GetxService {
  static AuthService get to => Get.find();
  late SharedPreferences _storage;
  late bool loggin = false;
  @override
  void onInit() {
    super.onInit();
  }

  FutureOr<String> getToken() async => _storage.getString("token") ?? "";

  Future<void> setToken(String token) async =>
      await _storage.setString("token", token);
  Future<void> delToken() async => await _storage.remove("token");

  Future<void> sign() async {}

  Future<void> token_login() async {
    // String login_url = await Dio.p
  }

  bool get current_loggin => loggin;
}
