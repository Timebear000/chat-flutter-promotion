// To parse this JSON data, do
//
//     final userMyData = userMyDataFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class UserMyData {
  UserMyData({
    required this.uid,
    required this.email,
    required this.nickName,
    required this.deviceToken,
    required this.profile,
    required this.createdAt,
  });

  String uid;
  String email;
  String nickName;
  String deviceToken;
  String profile;
  DateTime createdAt;

  UserMyData copyWith({
    String? uid,
    String? email,
    String? nickName,
    String? deviceToken,
    String? profile,
    DateTime? createdAt,
  }) =>
      UserMyData(
        uid: uid ?? this.uid,
        email: email ?? this.email,
        nickName: nickName ?? this.nickName,
        deviceToken: deviceToken ?? this.deviceToken,
        profile: profile ?? this.profile,
        createdAt: createdAt ?? this.createdAt,
      );

  factory UserMyData.fromRawJson(String str) =>
      UserMyData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserMyData.fromJson(Map<String, dynamic> json) => UserMyData(
        uid: json["uid"],
        email: json["email"],
        nickName: json["nickName"],
        deviceToken: json["device_token"],
        profile: json["profile"],
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "email": email,
        "nickName": nickName,
        "device_token": deviceToken,
        "profile": profile,
        "createdAt": createdAt.toIso8601String(),
      };
}
