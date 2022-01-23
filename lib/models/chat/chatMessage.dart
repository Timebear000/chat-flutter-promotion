// To parse this JSON data, do
//
//     final chatMessage = chatMessageFromJson(jsonString);

import 'package:chatnest/models/auth/UserInfo.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

class ChatMessage {
  ChatMessage({
    required this.type,
    required this.id,
    required this.roomId,
    required this.message,
    required this.createdAt,
    required this.chatMessageId,
    required this.onReadUser,
    required this.ownner,
  });

  String type;
  String id;
  String roomId;
  String message;
  DateTime createdAt;
  String chatMessageId;
  int onReadUser;
  UserInfo ownner;

  ChatMessage copyWith({
    String? type,
    String? id,
    String? roomId,
    String? message,
    DateTime? createdAt,
    String? chatMessageId,
    int? onReadUser,
    UserInfo? ownner,
  }) =>
      ChatMessage(
        type: type ?? this.type,
        id: id ?? this.id,
        roomId: roomId ?? this.roomId,
        message: message ?? this.message,
        createdAt: createdAt ?? this.createdAt,
        chatMessageId: chatMessageId ?? this.chatMessageId,
        onReadUser: onReadUser ?? this.onReadUser,
        ownner: ownner ?? this.ownner,
      );

  factory ChatMessage.fromRawJson(String str) =>
      ChatMessage.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ChatMessage.fromJson(Map<String, dynamic> json) => ChatMessage(
        type: json["type"],
        id: json["_id"],
        roomId: json["room_id"],
        message: json["message"],
        createdAt: json["createdAt"] == null
            ? DateTime.now()
            : DateTime.parse(json["createdAt"]),
        chatMessageId: json["id"],
        onReadUser: json["onReadUser"],
        ownner: UserInfo.fromJson(json["ownner"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "_id": id,
        "room_id": roomId,
        "message": message,
        "createdAt": createdAt,
        "id": chatMessageId,
        "onReadUser": onReadUser,
        "ownner": ownner,
      };
}
