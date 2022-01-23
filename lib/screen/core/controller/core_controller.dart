import 'package:chatnest/screen/core/child/Rooms/controller/rooms_controller.dart';
import 'package:chatnest/screen/core/child/Rooms/view/rooms_view.dart';
import 'package:chatnest/screen/core/child/joinRooms/controller/joinRooms_controller.dart';
import 'package:chatnest/screen/core/child/joinRooms/view/joinRoom_view.dart';
import 'package:chatnest/service/chatService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CoreController extends GetxController {
  static CoreController get to => Get.find();
  Rx<int> _tap = 0.obs;

  setTap(int index) {
    _tap(index);
  }

  Widget View() {
    switch (_tap.value) {
      case 0:
        return GetBuilder<JoinRoomsController>(
            init: JoinRoomsController(),
            builder: (_) {
              return JoinListView();
            });
      case 1:
        return GetBuilder<RoomsController>(
            init: RoomsController(),
            builder: (_) {
              return RoomListView();
            });
    }
    return Container();
  }

  int get tap => _tap.value;
}
