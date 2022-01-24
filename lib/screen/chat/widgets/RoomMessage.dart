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
                    Container(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "${message.onReadUser.where((element) => element.onRead == false).length}",
                        style: TextStyle(
                          color: Colors.amber,
                          fontSize: 9.sp,
                          fontFamily: 'NotoSansKR',
                        ),
                      ),
                    ),
                    SizedBox(width: 7.w),
                    lastChild
                        ? Container(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              "${message.createdAt.hour}:${message.createdAt.minute}",
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
                              color: Colors.white,
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
                                color: Color(0xff333333),
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
                              "${message.createdAt.hour}:${message.createdAt.minute}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 9.sp,
                                fontFamily: 'NotoSansKR',
                              ),
                            ),
                          )
                        : Container(),
                    SizedBox(width: 7.w),
                    Container(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "${message.onReadUser.where((element) => element.onRead == false).length}",
                        style: TextStyle(
                          color: Colors.amber,
                          fontSize: 9.sp,
                          fontFamily: 'NotoSansKR',
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        ));
  }
}
