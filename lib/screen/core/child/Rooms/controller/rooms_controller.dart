import 'package:chatnest/models/chat/Room.dart';
import 'package:chatnest/routes/app_page.dart';
import 'package:chatnest/service/chatService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class RoomsController extends GetxController {
  static RoomsController get to => Get.find();
  RxList<Room> rooms = <Room>[].obs;
  IO.Socket socket = ChatService.to.socket;
  TextEditingController createRooms = new TextEditingController();

  @override
  void onInit() async {
    await roomListSet();
    super.onInit();
  }

  Future<void> roomListSet() async {
    List<Room> result = await ChatService.to.FindAllRooms();
    print(result);
    rooms.assignAll(result);
  }

  Future<void> roomCreate(String room_name) async {
    await ChatService.to.createChatRoom(room_name: room_name);
    await this.roomListSet();
  }

  // Chat Room Join
  Future<void> roomJoin(
      {required String room_id, required String room_name}) async {
    socket.emit("join", {'room_id': room_id});
    print('${Routes.Chat}/${room_id}');
    await Get.toNamed('${Routes.Chat}/${room_id}',
        arguments: {"room_name": room_name});
  }

  Future<void> onCreateRoom() async {
    await Get.dialog(
      Dialog(
        insetPadding: EdgeInsets.zero,
        child: Container(
            width: 320.w,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.w),
                  child: Container(
                    child: Text("방이름"),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8.w),
                  child: TextField(
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.black87,
                        fontWeight: FontWeight.w400,
                      ),
                      controller: createRooms,
                      decoration: InputDecoration(
                          isDense: true,
                          hintText: "방 방이름을 적어주세요.",
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.w),
                          ),
                          hintStyle: TextStyle(
                            fontSize: 13.sp,
                            color: Color(0xff878D95),
                            fontWeight: FontWeight.w400,
                          ))),
                ),
                Container(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                            onTap: () async {
                              await this.roomCreate(createRooms.text);
                              createRooms.clear();
                              Get.back();
                            },
                            child: Container(child: Text("방만들기"))),
                        SizedBox(width: 10.w),
                        GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(child: Text("닫기"))),
                      ],
                    )),
              ],
            )),
      ),
      barrierDismissible: true,
      useSafeArea: false,
    );
  }
}
