import 'dart:async';

import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatService extends GetxService {
  static ChatService get to => Get.find();
  late IO.Socket socket;

  void connect() {
    socket = IO.io(
        "http://localhost:3000/room?uid=61e51f10510a8d761e358c79",
        IO.OptionBuilder()
            .setTransports(["websocket"])
            .enableForceNew()
            .enableAutoConnect()
            .build());

    // socket.connect();
    socket.onConnect((data) {
      print(123412);
    });
    socket.on('connected', (msg) {
      print(msg);
    });
  }

  @override
  void onClose() {
    socket.disconnect();
  }
}
