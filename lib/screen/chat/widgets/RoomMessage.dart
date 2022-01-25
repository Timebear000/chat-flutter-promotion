import 'package:chatnest/models/chat/roomMessage.dart';
import 'package:chatnest/service/authService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoomMessageWidget extends StatelessWidget {
  final RoomMessage message;
  final bool firstChild;
  final bool lastChild;
  const RoomMessageWidget(
      {required this.message,
      required this.firstChild,
      required this.lastChild});

  @override
  Widget build(BuildContext context) {
    return OnMessageType();
  }

  Widget OnMessageType() {
    if (message.type == "system") return _SystemMessage();
    return message.ownner.uid == AuthService.to.user.uid
        ? _MyMessage()
        : _NearUserMessage();
  }

  // Owner Message
  Container _MyMessage() {
    int notReadCount =
        message.onReadUser.where((element) => element.onRead == false).length;
    return Container(
        alignment: Alignment.centerRight,
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    notReadCount != 0
                        ? Container(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              "${notReadCount}",
                              style: TextStyle(
                                color: Colors.amber,
                                fontSize: 9.sp,
                                fontFamily: 'NotoSansKR',
                              ),
                            ),
                          )
                        : Container(),
                    SizedBox(width: 7.w),
                    lastChild
                        ? Container(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              _displayTime(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 9.sp,
                                fontFamily: 'NotoSansKR',
                              ),
                            ),
                          )
                        : Container(),
                    SizedBox(width: 7.w),
                    ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: 181.w,
                        ),
                        child: Container(
                            padding: EdgeInsets.all(8.w),
                            decoration: BoxDecoration(
                              color: Color(0xffd09760),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.zero,
                                topLeft: Radius.circular(8.w),
                                bottomLeft: Radius.circular(8.w),
                                bottomRight: Radius.circular(8.w),
                              ),
                            ),
                            child: Text(
                              message.message,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13.sp,
                              ),
                            ))),
                  ],
                ),
              ],
            ),
          ],
        ));
  }

  // System Message
  Container _SystemMessage() {
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 5.w, horizontal: 20.w),
            decoration: BoxDecoration(
              color: Color(0xff213468),
              borderRadius: BorderRadius.circular(15.w),
            ),
            child: Text(
              '${message.message}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.sp,
                fontFamily: 'NotoSansKR',
              ),
            ),
            alignment: Alignment.center,
          ),
        ],
      ),
    );
  }

  // Near  Message
  Container _NearUserMessage() {
    int notReadCount =
        message.onReadUser.where((element) => element.onRead == false).length;
    return Container(
        alignment: Alignment.centerLeft,
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 35.w,
              height: 35.w,
              child: firstChild
                  ? CircleAvatar(
                      backgroundImage: NetworkImage(message.ownner.profile))
                  : Container(),
            ),
            SizedBox(width: 7.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                firstChild
                    ? Container(
                        child: Text(
                          message.ownner.nickName,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13.sp,
                            fontFamily: 'NotoSansKR',
                          ),
                        ),
                      )
                    : Container(),
                firstChild ? SizedBox(height: 5.w) : Container(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: 181.w,
                        ),
                        child: Container(
                            padding: EdgeInsets.all(8.w),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(8.w),
                                topLeft: Radius.zero,
                                bottomLeft: Radius.circular(8.w),
                                bottomRight: Radius.circular(8.w),
                              ),
                            ),
                            child: Text(
                              message.message,
                              style: TextStyle(
                                color: Color(0xff333333),
                                fontSize: 13.sp,
                              ),
                            ))),
                    SizedBox(width: 7.w),
                    lastChild
                        ? Container(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              _displayTime(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 9.sp,
                                fontFamily: 'NotoSansKR',
                              ),
                            ),
                          )
                        : Container(),
                    SizedBox(width: 7.w),
                    notReadCount != 0
                        ? Container(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              "${notReadCount}",
                              style: TextStyle(
                                color: Colors.amber,
                                fontSize: 9.sp,
                                fontFamily: 'NotoSansKR',
                              ),
                            ),
                          )
                        : Container()
                  ],
                ),
              ],
            ),
          ],
        ));
  }

  String _displayTime() {
    DateTime createAt = this.message.createdAt;
    String Hource;
    String Min;
    String After;
    if (createAt.hour <= 11) {
      After = "오전";
      Hource = createAt.hour == 0 ? "12" : "${createAt.hour}";
    } else {
      After = "오후";
      Hource = createAt.hour == 12 ? "12" : "${createAt.hour - 12}";
    }

    if (createAt.minute <= 9) {
      Min = createAt.minute == 0 ? "00" : "0${createAt.minute}";
    } else {
      Min = "${createAt.minute}";
    }
    return "${After} ${Hource}:${Min}";
  }
}
