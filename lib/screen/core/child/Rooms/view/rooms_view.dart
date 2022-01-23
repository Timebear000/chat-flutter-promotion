import 'package:chatnest/screen/core/child/Rooms/controller/rooms_controller.dart';
import 'package:chatnest/screen/core/child/widgets/RoomInfo.dart';
import 'package:chatnest/screen/core/child/widgets/RoomItem.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class RoomListView extends GetView<RoomsController> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Obx(() => controller.rooms.length != 0
            ? ListView(
                physics: ClampingScrollPhysics(),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                children: [
                  ...List.generate(
                          controller.rooms.length,
                          (index) => InkWell(
                              onTap: () async {
                                print(controller.rooms[index].id);
                                await controller.roomJoin(
                                    room_id: controller.rooms[index].id);
                              },
                              child: RoomInfo(item: controller.rooms[index])))
                      .toList()
                ],
              )
            : Center(child: Text("참가한 방이 없습니다.\n Rooms에서 참가해주세요.!"))),
        Positioned(
          bottom: 0,
          right: 0,
          child: FloatingActionButton.small(
            onPressed: () async {
              await controller.onCreateRoom();
            },
            child: Icon(Icons.message_rounded),
            backgroundColor: Colors.pink,
          ),
        ),
      ],
    );
  }
}
