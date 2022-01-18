import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends GetxService {
  static AuthService get to => Get.find();
  late SharedPreferences _storage;
  String authUrl = "${dotenv.env['baseApi']}/auth";
  late bool loggin = false;
  Dio dio = new Dio();
  @override
  void onInit() {
    super.onInit();
  }

  FutureOr<String> getToken() async => _storage.getString("token") ?? "";

  Future<void> setToken(String token) async =>
      await _storage.setString("token", token);
  Future<void> delToken() async => await _storage.remove("token");

  Future<void> setting() async {}

  Future<bool> sign({required String email, required String password}) async {
    String device_token = "12341541";
    String login_url = "${authUrl}/sign";
    var body = {
      "email": email,
      "password": password,
      "device_token": device_token
    };
    try {
      final response = await dio.post(login_url, data: body);
      print(response);
      if (response.statusCode != 201) {
        return false;
      }
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<void> token_login() async {
    // String login_url = await Dio.p
  }

  bool get current_loggin => loggin;
}
