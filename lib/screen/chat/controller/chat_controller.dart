import 'package:chatnest/models/auth/MyData.dart';
import 'package:chatnest/models/chat/roomMessage.dart';
import 'package:chatnest/service/authService.dart';
import 'package:chatnest/service/chatService.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ChatController extends GetxController {
  static ChatController get to => Get.find();
  UserMyData user = AuthService.to.user;
  RxList<RoomMessage> messages = <RoomMessage>[].obs;
  Rx<bool> SendOn = false.obs;
  TextEditingController messageController = new TextEditingController();

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await MessageGets();
  }

  Future<void> MessageGets() async {
    String room_id = Get.parameters['room_id']!;
    print(room_id);
    List<RoomMessage> result =
        await ChatService.to.MessageListGet(room_id: room_id);
    print(result.length);
    messages.assignAll(result);
  }
}
