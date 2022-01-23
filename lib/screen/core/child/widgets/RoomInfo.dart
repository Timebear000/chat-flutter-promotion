import 'package:chatnest/models/chat/Room.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoomInfo extends StatelessWidget {
  final Room item;
  const RoomInfo({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60.w,
      margin: EdgeInsets.only(bottom: 5.w),
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.all(Radius.circular(5.w)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 60.w,
            height: 60.w,
            padding: EdgeInsets.all(5.w),
            child: CircleAvatar(
              backgroundColor: Colors.blueGrey,
              backgroundImage: NetworkImage(
                  "https://img1.daumcdn.net/thumb/R1280x0.fjpg/?fname=http://t1.daumcdn.net/brunch/service/user/4arX/image/4s8b4_ydzsR_lCHa1ZjK1wrdSxo.jpg"),
            ),
            margin: EdgeInsets.only(right: 10.w),
          ),
          Expanded(
              child: Container(
            width: double.infinity,
            child: Text(this.item.roomName,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                )),
          )),
          Container(
            height: 60.w,
            child: Text(this.item.onUser.length.toString(),
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                )),
            alignment: Alignment.center,
          ),
          SizedBox(width: 5.w),
        ],
      ),
    );
  }
}
