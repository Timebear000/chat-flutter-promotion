import 'dart:convert';

class UserInfo {
  UserInfo({
    required this.uid,
    required this.email,
    required this.nickName,
    required this.profile,
  });

  String uid;
  String email;
  String nickName;
  String profile;

  UserInfo copyWith({
    String? uid,
    String? email,
    String? nickName,
    String? profile,
  }) =>
      UserInfo(
        uid: uid ?? this.uid,
        email: email ?? this.email,
        nickName: nickName ?? this.nickName,
        profile: profile ?? this.profile,
      );

  factory UserInfo.fromRawJson(String str) =>
      UserInfo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        uid: json["uid"] == null ? null : json["uid"],
        email: json["email"] == null ? null : json["email"],
        nickName: json["nickName"] == null ? null : json["nickName"],
        profile: json["profile"] == null ? null : json["profile"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "email": email,
        "nickName": nickName,
        "profile": profile,
      };
}
