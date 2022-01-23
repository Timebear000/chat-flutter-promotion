import 'package:chatnest/models/chat/Room.dart';
import 'package:chatnest/service/authService.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/connect.dart';
import 'package:get/get_connect/http/src/request/request.dart';

class ChatProvider extends GetConnect {
  static ChatProvider get to => Get.find();

  @override
  void onInit() {
    httpClient.baseUrl = "${dotenv.env["baseApi"]}/chat-room";
    // 모든 요청의 헤더에 'X-Auth' 속성을 첨부합니다.
    httpClient.addRequestModifier((Request request) {
      request.headers['Content-Type'] = 'application/json';
      return request;
    });
    super.onInit();
  }

  // all find list rooms
  Future<List<Room>> findChatList() async {
    String url = "";
    String token = await AuthService.to.getToken();
    Response response = await get(url, headers: {"x_token": token});
    if (response.hasError) {
      print(response.body["message"]);
      return [];
    } else {
      List<Room> result =
          List<Room>.from(response.body["result"].map((x) => Room.fromJson(x)));
      print(result.toList());
      return result;
    }
  }

  // my find join list rooms
  Future<List<Room>> findMyChatList() async {
    String url = "/myRoomList";
    String token = await AuthService.to.getToken();
    Response response = await get(url, headers: {"x_token": token});
    if (response.hasError) {
      print(response.body["message"]);
      return [];
    } else {
      print(response.body["result"]);
      List<Room> result =
          List<Room>.from(response.body["result"].map((x) => Room.fromJson(x)));
      print(result.toList());
      return result;
    }
  }

  // create Rooms
  Future<void> createRoom(
      {required String room_name, bool isGroup = true}) async {
    String url = "";
    String token = await AuthService.to.getToken();
    Response response = await post(
        url, {"room_name": room_name, "isGroup": isGroup},
        headers: {"x_token": token});

    if (response.hasError) {
      throw Exception(response.body["message"]);
    }
  }

  Future<Room> RoomInfo({required String room_id}) async {
    String url = "/roomUserInfo?room_id=${room_id}";
    String token = await AuthService.to.getToken();
    Response response = await get(url, headers: {"x_token": token});
    if (response.hasError) {
      throw new Exception(response.body['message']);
    }
    print("Result : :${response.body["result"]}");
    Room result = Room.fromJson(response.body["result"]);

    return result;
  }
}
