import 'package:chatnest/models/auth/MyData.dart';
import 'package:chatnest/models/chat/Room.dart';
import 'package:chatnest/models/chat/roomMessage.dart';
import 'package:chatnest/service/authService.dart';
import 'package:chatnest/service/chatService.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatController extends GetxController {
  static ChatController get to => Get.find();
  UserMyData user = AuthService.to.user;
  RxList<RoomMessage> messages = <RoomMessage>[].obs;
  IO.Socket socket = ChatService.to.socket;
  String room_name = Get.arguments['room_name'];
  Rx<bool> SendOn = false.obs;
  TextEditingController messageController = new TextEditingController();

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await MessageGets();
    String room_id = Get.parameters['room_id']!;
    print("Socket Status : ${socket.connected}");
    socket.on("NewUser", NewUserEvent);
    socket.on("userInto", RoomJoinUser);
    // Message 받기
    socket.on("SendMessageSuccess", SendMessageSuccess);
    socket.on("MessageReceive", MessageReceive);
  }

  // Message Send
  MessageSend() {
    String room_id = Get.parameters['room_id']!;
    var message = {
      "room_id": room_id,
      "ownner": user.uid,
      "message": messageController.text
    };
    socket.emit("SendMessage", message);
    messageController.clear();
    SendOn(false);
  }

  SendMessageSuccess(data) {
    RoomMessage message = RoomMessage.fromJson(data);
    messages.add(message);
  }

  Future<void> MessageGets() async {
    String room_id = Get.parameters['room_id']!;
    List<RoomMessage> result =
        await ChatService.to.MessageListGet(room_id: room_id);
    messages.assignAll(result);
  }

  MessageReceive(data) {
    String room_id = Get.parameters['room_id']!;
    var send = {"room_id": room_id};
    socket.emit("ReadMessage", send);
    RoomMessage message = RoomMessage.fromJson(data);
    messages.add(message);
  }

  NewUserEvent(data) {
    RoomMessage message = RoomMessage.fromJson(data);
    messages.add(message);
    update();
  }

  RoomJoinUser(data) {
    for (RoomMessage value in messages) {
      for (OnReadUser value2 in value.onReadUser) {
        if (value2.user == data && value2.onRead == false) {
          value2.onRead = true;
        }
      }
    }
    messages.refresh();
  }

  @override
  void onClose() {
    String room_id = Get.parameters['room_id']!;
    socket.off('NewUser');
    socket.off("SendMessageSuccess");
    socket.off("userInto");
    socket.off("MessageReceive");
    socket.emit("Roomleave", room_id);
    super.onClose();
  }
}
