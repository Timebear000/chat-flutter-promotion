// To parse this JSON data, do
//
//     final roomMessage = roomMessageFromJson(jsonString);

import 'package:chatnest/models/auth/UserInfo.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

class RoomMessage {
  RoomMessage({
    required this.type,
    required this.id,
    required this.roomId,
    required this.message,
    required this.createdAt,
    required this.roomMessageId,
    required this.onReadUser,
    required this.ownner,
  });

  String type;
  String id;
  String roomId;
  String message;
  DateTime createdAt;
  String roomMessageId;
  List<OnReadUser> onReadUser;
  UserInfo ownner;

  RoomMessage copyWith({
    String? type,
    String? id,
    String? roomId,
    String? message,
    DateTime? createdAt,
    String? roomMessageId,
    List<OnReadUser>? onReadUser,
    UserInfo? ownner,
  }) =>
      RoomMessage(
        type: type ?? this.type,
        id: id ?? this.id,
        roomId: roomId ?? this.roomId,
        message: message ?? this.message,
        createdAt: createdAt ?? this.createdAt,
        roomMessageId: roomMessageId ?? this.roomMessageId,
        onReadUser: onReadUser ?? this.onReadUser,
        ownner: ownner ?? this.ownner,
      );

  factory RoomMessage.fromRawJson(String str) =>
      RoomMessage.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RoomMessage.fromJson(Map<String, dynamic> json) => RoomMessage(
        type: json["type"],
        id: json["_id"],
        roomId: json["room_id"],
        message: json["message"],
        createdAt: DateTime.parse(json["createdAt"]),
        roomMessageId: json["id"],
        onReadUser: List<OnReadUser>.from(
            json["onReadUser"].map((x) => OnReadUser.fromJson(x))),
        ownner: UserInfo.fromJson(json["ownner"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "_id": id,
        "room_id": roomId,
        "message": message,
        "createdAt": createdAt.toIso8601String(),
        "id": roomMessageId,
        "onReadUser": List<dynamic>.from(onReadUser.map((x) => x.toJson())),
        "ownner": ownner.toJson(),
      };
}

class OnReadUser {
  OnReadUser({
    required this.onRead,
    required this.id,
    required this.user,
  });

  bool onRead;
  String id;
  String user;

  OnReadUser copyWith({
    bool? onRead,
    String? id,
    String? user,
  }) =>
      OnReadUser(
        onRead: onRead ?? this.onRead,
        id: id ?? this.id,
        user: user ?? this.user,
      );

  factory OnReadUser.fromRawJson(String str) =>
      OnReadUser.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());
  factory OnReadUser.fromJson(Map<String, dynamic> json) => OnReadUser(
        onRead: json["onRead"],
        id: json["_id"],
        user: json["user"],
      );
  Map<String, dynamic> toJson() => {
        "onRead": onRead,
        "_id": id,
        "user": user,
      };
}
