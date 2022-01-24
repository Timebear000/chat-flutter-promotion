import 'package:chatnest/models/chat/roomMessage.dart';
import 'package:chatnest/screen/chat/controller/chat_controller.dart';
import 'package:chatnest/screen/chat/widgets/RoomMessage.dart';
import 'package:chatnest/styles/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ChatView extends GetView<ChatController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              FocusScope.of(context).requestFocus(new FocusNode());
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios, color: Colors.black87)),
        backgroundColor: Colors.white,
        title: Text(
          "채팅방 이름",
          style: TextStyle(color: Colors.black87),
        ),
      ),
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Container(
              decoration: BoxDecoration(
                color: Color(0xff2a4083),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x14000000),
                    offset: Offset(0, 0),
                    blurRadius: 8,
                    spreadRadius: 0,
                  ),
                ],
              ),
              width: double.infinity,
              height: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Obx(() => ListView(
                          reverse: true,
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          children: [
                            ...List.generate(controller.messages.length,
                                (index) {
                              index = controller.messages.length - 1 - index;
                              bool nextDay = true;
                              bool firstChild = true;
                              bool lastChild = true;
                              RoomMessage item = controller.messages[index];
                              int itemCount = item.createdAt.year * 10000 +
                                  item.createdAt.month * 100 +
                                  item.createdAt.day * 1;
                              int itemTimeCount = item.createdAt.hour * 100 +
                                  item.createdAt.minute * 1;

                              if (index != controller.messages.length - 1) {
                                RoomMessage nextitem =
                                    controller.messages[index + 1];
                                int nextTimeCount =
                                    nextitem.createdAt.hour * 100 +
                                        nextitem.createdAt.minute * 1;

                                firstChild = itemTimeCount != nextTimeCount &&
                                    item.ownner.uid == nextitem.ownner.uid;
                              }
                              if (index != 0) {
                                RoomMessage previtem =
                                    controller.messages[index - 1];
                                int previtemCount =
                                    previtem.createdAt.year * 10000 +
                                        previtem.createdAt.month * 100 +
                                        previtem.createdAt.day * 1;
                                if (itemCount == previtemCount) {
                                  nextDay = false;
                                }
                                int prevTimeCount =
                                    previtem.createdAt.hour * 100 +
                                        previtem.createdAt.minute * 1;

                                lastChild = itemTimeCount != prevTimeCount &&
                                    item.ownner.uid == previtem.ownner.uid;
                              }

                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  nextDay
                                      ? Container(
                                          width: 120.w,
                                          margin: EdgeInsets.symmetric(
                                              vertical: 15.w),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 5.w, horizontal: 10.w),
                                          decoration: BoxDecoration(
                                            color: Color(0xff213468),
                                            borderRadius:
                                                BorderRadius.circular(15.w),
                                          ),
                                          child: Text(
                                            '${item.createdAt.year}년 ${item.createdAt.month}월 ${item.createdAt.day}일',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12.sp,
                                              fontFamily: 'NotoSansKR',
                                            ),
                                          ),
                                          alignment: Alignment.center,
                                        )
                                      : Container(),
                                  Container(
                                      margin: item.type == "system"
                                          ? EdgeInsets.symmetric(vertical: 15.w)
                                          : firstChild && lastChild
                                              ? EdgeInsets.symmetric(
                                                  vertical: 15.w)
                                              : EdgeInsets.symmetric(
                                                  vertical: 5.w),
                                      child: RoomMessageWidget(
                                        message: item,
                                        firstChild: lastChild,
                                        lastChild: firstChild,
                                      )),
                                ],
                              );
                            }).toList(),
                          ],
                        )),
                  ),
                  _MessageSend(),
                ],
              )),
        ),
      ),
    );
  }

  Container _MessageSend() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 45.w,
            height: 45.w,
            padding: EdgeInsets.all(5.w),
            margin: EdgeInsets.only(bottom: 5.w),
            child: CircleAvatar(
              backgroundImage: NetworkImage(controller.user.profile),
            ),
            alignment: Alignment.center,
          ),
          Expanded(
            child: TextField(
              scrollPadding: EdgeInsets.zero,
              controller: controller.messageController,
              onChanged: (text) {
                text.length != 0
                    ? controller.SendOn(true)
                    : controller.SendOn(false);
              },
              autofocus: false,
              maxLines: 4,
              minLines: 1,
              keyboardType: TextInputType.multiline,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 14.0.sp,
              ),
              decoration: InputDecoration(
                enabled: true,
                border: InputBorder.none,
                hintText: "댓글을 작성해주세요.",
                hintStyle: TextStyle(
                  color: Color(0xffaeaeae),
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Obx(
            () => Container(
              child: InkWell(
                onTap: () async {},
                child: Container(
                  margin: EdgeInsets.only(bottom: 5.w),
                  width: 45.w,
                  height: 45.w,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        controller.SendOn.value
                            ? AppIcons.MessageSendIcon
                            : AppIcons.MessageNotSendIcon,
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
