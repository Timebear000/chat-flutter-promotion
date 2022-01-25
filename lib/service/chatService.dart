import 'dart:async';

import 'package:chatnest/connects/chatProvider.dart';
import 'package:chatnest/models/chat/Room.dart';
import 'package:chatnest/models/chat/roomMessage.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatService extends GetxService {
  static ChatService get to => Get.find();
  late IO.Socket socket;

  @override
  void onInit() async {
    await Get.putAsync(() async => await ChatProvider());
    super.onInit();
  }

  void connect(String uid) async {
    try {
      socket = await IO.io(
          "http://192.168.0.213:3000/room?uid=${uid}",
          IO.OptionBuilder()
              .setTransports(["websocket"])
              .disableAutoConnect() // disable auto-connection
              // .setExtraHeaders({'foo': 'bar'}) // optional
              .build());

      socket.connect();
      print("connect Commplest");
      socket.onConnect((data) {});
      socket.on('connected', (msg) {
        socket.emit("MyRoomjoin");
      });
    } catch (error) {
      print(error);
    }
  }

  // Room Create
  Future<void> createChatRoom(
      {required String room_name, bool isGroup = true}) async {
    await ChatProvider.to.createRoom(room_name: room_name, isGroup: isGroup);
  }

  // All Rooms
  Future<List<Room>> FindAllRooms() async {
    List<Room> result = await ChatProvider.to.findChatList();
    return result;
  }

  // MY Join Rooms
  Future<List<Room>> FindMyRooms() async {
    List<Room> result = await ChatProvider.to.findMyChatList();
    return result;
  }

  Future<Room> RoomInfo({required String room_id}) async {
    return await ChatProvider.to.RoomInfo(room_id: room_id);
  }

  Future<List<RoomMessage>> MessageListGet({required String room_id}) async {
    return await ChatProvider.to.MessageListGet(room_id: room_id);
  }

  @override
  void onClose() {
    print("disconnect");
    socket.onDisconnect((data) => print(data));
  }
}
