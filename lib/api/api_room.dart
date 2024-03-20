import 'dart:convert';
import 'package:mobile_home_travel/api/api_header.dart';
import 'package:mobile_home_travel/constants/baseUrl.dart';
import 'package:mobile_home_travel/constants/myToken.dart';
import 'package:mobile_home_travel/models/homestay/room/room_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ApiRoom {
  // <<<< Get room by id >>>>
  static Future<RoomModel?> getroomDetail({required String idRoom}) async {
    RoomModel? roomDetail;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(myToken);

    try {
      var url = "$baseUrl/api/v1/Rooms/$idRoom";
      Map<String, String> header = await ApiHeader.getHeader();
      header.addAll({'Authorization': 'Bearer $token'});
      var response = await http.get(Uri.parse(url.toString()), headers: header);
      // print("TEST get detail homestay: ${response.body}");
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(utf8.decode(response.bodyBytes));
        // print("Xem body sau khi convert: $bodyConvert");
        var postsJson = bodyConvert['data'];
        roomDetail = RoomModel.fromMap(postsJson);
        print("Thông tin get room: $roomDetail");
      }
    } catch (e) {
      print("Loi get detail homestay: $e");
    }

    return roomDetail;
  }
}
