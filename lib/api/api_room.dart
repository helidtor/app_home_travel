import 'dart:convert';
import 'package:mobile_home_travel/api/api_header.dart';
import 'package:mobile_home_travel/constant/baseUrl.dart';
import 'package:mobile_home_travel/constant/myToken.dart';
import 'package:mobile_home_travel/models/homestay/room/room_model.dart';
import 'package:mobile_home_travel/utils/shared_preferences_util.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ApiRoom {
  // <<<< Get room by id >>>>
  static Future<RoomModel?> getRoomDetail({required String idRoom}) async {
    RoomModel? roomDetail;
    String? token = SharedPreferencesUtil.getToken();

    try {
      var url = "$baseUrl/api/v1/Rooms/$idRoom";
      Map<String, String> header = await ApiHeader.getHeader();
      header.addAll({'Authorization': 'Bearer $token'});
      var response = await http.get(Uri.parse(url.toString()), headers: header);
      // print("TEST get detail homestay: ${jsonDecode(utf8.decode(response.bodyBytes))}");
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(utf8.decode(response.bodyBytes));
        // print("Xem body sau khi convert: $bodyConvert");
        var postsJson = bodyConvert['data'];
        roomDetail = RoomModel.fromMap(postsJson);
        // print("Thông tin get room: $roomDetail");
        return roomDetail;
      } else {
        return null;
      }
    } catch (e) {
      print("Loi get detail room: $e");
    }
    return null;
  }

  // <<<< Get all room empty by date >>>>
  static Future<List<RoomModel>?> getAllRoomEmptyByDate(
      {required String homeStayId,
      required String dateCheckIn,
      required String dateCheckOut}) async {
    List<RoomModel>? listRoom;
    String? token = SharedPreferencesUtil.getToken();
    // print(
    //     'Thông tin search room empty: $homeStayId, $dateCheckIn, $dateCheckOut');
    try {
      var url =
          "$baseUrl/api/v1/Rooms/emptyRooms?pageSize=50&homeStayId=$homeStayId&startDate=$dateCheckIn&endDate=$dateCheckOut";
      Map<String, String> header = await ApiHeader.getHeader();
      header.addAll({'Authorization': 'Bearer $token'});
      var response = await http.get(Uri.parse(url.toString()), headers: header);
      // print(
      //     "TEST get all room empty: ${jsonDecode(utf8.decode(response.bodyBytes))}");
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(utf8.decode(response.bodyBytes));
        // print("Xem body sau khi convert: $bodyConvert");
        var postsJson = bodyConvert['data'];
        listRoom = (postsJson as List)
            .map<RoomModel>((postJson) => RoomModel.fromMap(postJson))
            .toList();
        // print("Thông tin get all room empty: $listRoom");
      }
    } catch (e) {
      print("Loi get all room empty: $e");
    }

    return listRoom;
  }
}
