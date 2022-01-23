// To parse this JSON data, do
//
//     final room = roomFromJson(jsonString);

import 'package:chatnest/models/chat/Message.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

class Room {
  Room({
    required this.onUser,
    required this.isGroup,
    required this.id,
    required this.owner,
    required this.roomName,
    required this.createdAt,
    required this.updatedAt,
    required this.lastMessage,
    this.messages,
    required this.roomId,
  });

  bool isGroup;
  String id;
  String owner;
  String roomName;
  List<OnUser> onUser;
  DateTime createdAt;
  DateTime updatedAt;
  ChatMessage? lastMessage;
  int? messages;
  String roomId;

  Room copyWith({
    bool? isGroup,
    String? id,
    String? owner,
    String? roomName,
    DateTime? createdAt,
    DateTime? updatedAt,
    ChatMessage? lastMessage,
    int? messages,
    String? roomId,
    List<OnUser>? onUser,
  }) =>
      Room(
        isGroup: isGroup ?? this.isGroup,
        id: id ?? this.id,
        owner: owner ?? this.owner,
        roomName: roomName ?? this.roomName,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        lastMessage: lastMessage ?? this.lastMessage,
        messages: messages ?? this.messages,
        roomId: roomId ?? this.roomId,
        onUser: onUser ?? this.onUser,
      );

  factory Room.fromRawJson(String str) => Room.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Room.fromJson(Map<String, dynamic> json) => Room(
        isGroup: json["isGroup"] == null ? false : json["isGroup"],
        id: json["_id"] == null ? null : json["_id"],
        owner: json["owner"] == null ? null : json["owner"],
        roomName: json["room_name"] == null ? null : json["room_name"],
        createdAt: json["createdAt"] == null
            ? DateTime.now()
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? DateTime.now()
            : DateTime.parse(json["updatedAt"]),
        lastMessage: json["last_message"] == null
            ? null
            : ChatMessage.fromJson(json["last_message"]),
        messages: json["messages"] == null ? 0 : json["messages"],
        roomId: json["id"] == null ? null : json["id"],
        onUser: json["onUser"] == null
            ? []
            : List<OnUser>.from(json["onUser"].map((x) => OnUser.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "isGroup": isGroup,
        "_id": id,
        "owner": owner,
        "room_name": roomName,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "last_message": lastMessage!.toJson(),
        "messages": messages,
        "onUser": List<OnUser>.from(onUser.map((x) => x.toJson())),
        "id": roomId,
      };
}

class OnUser {
  OnUser({
    required this.push,
    required this.user,
    required this.inDate,
    required this.lastDate,
  });

  bool push;
  String user;
  DateTime inDate;
  DateTime lastDate;

  OnUser copyWith({
    bool? push,
    String? user,
    DateTime? inDate,
    DateTime? lastDate,
  }) =>
      OnUser(
        push: push ?? this.push,
        user: user ?? this.user,
        inDate: inDate ?? this.inDate,
        lastDate: lastDate ?? this.lastDate,
      );

  factory OnUser.fromRawJson(String str) => OnUser.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OnUser.fromJson(Map<String, dynamic> json) => OnUser(
        push: json["push"] == null ? true : json["push"],
        user: json["user"] == null ? null : json["user"],
        inDate: json["inDate"] == null
            ? DateTime.now()
            : DateTime.parse(json["inDate"]),
        lastDate: json["lastDate"] == null
            ? DateTime.now()
            : DateTime.parse(json["lastDate"]),
      );

  Map<String, dynamic> toJson() => {
        "push": push,
        "user": user,
        "inDate": inDate.toIso8601String(),
        "lastDate": lastDate.toIso8601String(),
      };
}
