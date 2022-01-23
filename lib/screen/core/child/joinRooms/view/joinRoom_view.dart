import 'package:chatnest/screen/core/child/joinRooms/controller/joinRooms_controller.dart';
import 'package:chatnest/screen/core/child/widgets/RoomItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class JoinListView extends GetView<JoinRoomsController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.rooms.length != 0
        ? ListView(
            physics: ClampingScrollPhysics(),
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            children: [
              ...List.generate(controller.rooms.length,
                  (index) => RoomItem(item: controller.rooms[index])).toList()
            ],
          )
        : Center(child: Text("참가한 방이 없습니다.\n Rooms에서 참가해주세요.!")));
  }
}
