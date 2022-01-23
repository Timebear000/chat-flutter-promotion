import 'dart:convert';

class ChatMessage {
  ChatMessage({
    required this.type,
    required this.id,
    required this.roomId,
    required this.ownner,
    required this.message,
    required this.onReadUser,
    required this.createdAt,
    required this.lastMessageId,
  });

  String type;
  String id;
  String roomId;
  String ownner;
  String message;
  List<OnReadUser> onReadUser;
  DateTime createdAt;
  String lastMessageId;

  ChatMessage copyWith({
    String? type,
    String? id,
    String? roomId,
    String? ownner,
    String? message,
    List<OnReadUser>? onReadUser,
    DateTime? createdAt,
    String? lastMessageId,
  }) =>
      ChatMessage(
        type: type ?? this.type,
        id: id ?? this.id,
        roomId: roomId ?? this.roomId,
        ownner: ownner ?? this.ownner,
        message: message ?? this.message,
        onReadUser: onReadUser ?? this.onReadUser,
        createdAt: createdAt ?? this.createdAt,
        lastMessageId: lastMessageId ?? this.lastMessageId,
      );

  factory ChatMessage.fromRawJson(String str) =>
      ChatMessage.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ChatMessage.fromJson(Map<String, dynamic> json) => ChatMessage(
        type: json["type"] == null ? null : json["type"],
        id: json["_id"] == null ? null : json["_id"],
        roomId: json["room_id"] == null ? null : json["room_id"],
        ownner: json["ownner"] == null ? null : json["ownner"],
        message: json["message"] == null ? null : json["message"],
        onReadUser: json["onReadUser"] == null
            ? []
            : List<OnReadUser>.from(
                json["onReadUser"].map((x) => OnReadUser.fromJson(x))),
        createdAt: json["createdAt"] == null
            ? DateTime.now()
            : DateTime.parse(json["createdAt"]),
        lastMessageId: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "_id": id,
        "room_id": roomId,
        "ownner": ownner,
        "message": message,
        "onReadUser": List<dynamic>.from(onReadUser.map((x) => x.toJson())),
        "createdAt": createdAt,
        "id": lastMessageId,
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
        onRead: json["onRead"] == null ? null : json["onRead"],
        id: json["_id"] == null ? null : json["_id"],
        user: json["user"] == null ? null : json["user"],
      );

  Map<String, dynamic> toJson() => {
        "onRead": onRead,
        "_id": id,
        "user": user,
      };
}
