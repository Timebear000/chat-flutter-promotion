import 'package:chatnest/components/modals/customAlertModal.dart';
import 'package:chatnest/models/chat/Room.dart';
import 'package:chatnest/service/chatService.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class JoinRoomsController extends GetxController {
  static JoinRoomsController get to => Get.find();
  RxList<Room> rooms = <Room>[].obs;
  IO.Socket socket = ChatService.to.socket;
  @override
  void onInit() async {
    await roomListSet();
    super.onInit();
    print("Socket Status : ${socket.connected}");
    socket.on("chatRoomUpdate", ChatRoomUpdate);
  }

  Future<void> roomListSet() async {
    List<Room> result = await ChatService.to.FindMyRooms();
    print(result.length);
    rooms.assignAll(result);
  }

  void ChatRoomUpdate(data) async {
    // rooms 삭제
    print(data);
    rooms.removeWhere((item) => item.id == data);
    update();
    try {
      Room item = await ChatService.to.RoomInfo(room_id: data);
      // print(item.toJson());
      rooms.insert(0, item);
      // rooms.sort();
      update();
    } catch (error) {
      await Get.dialog(CustomAlertModal(
        msg: "에러",
        title: error.toString(),
      ));
      print(error);
    }

    // 하나 새로 api 받기
    // rooms.add(item);
    // Update
  }

  @override
  void onClose() {
    socket.off('chatRoomUpdate');
    super.onClose();
  }
}
