import 'package:chatnest/screen/chat/controller/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ChatView extends GetView<ChatController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Text("Chat Rooms", style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
