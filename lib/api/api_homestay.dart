import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_home_travel/api/api_header.dart';
import 'package:mobile_home_travel/constants/baseUrl.dart';
import 'package:mobile_home_travel/constants/myToken.dart';
import 'package:mobile_home_travel/models/homestay/homestay_detail_model.dart';
import 'package:mobile_home_travel/models/homestay/homestay_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiHomestay {
  // <<<< Get all homestay >>>>
  static Future<List<HomestayModel>?> getAllHomestay() async {
    List<HomestayModel>? homestay;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(myToken);

    try {
      var url = "$baseUrl/api/v1/Homestays";
      Map<String, String> header = await ApiHeader.getHeader();
      header.addAll({'Authorization': 'Bearer $token'});
      var response = await http.get(Uri.parse(url.toString()), headers: header);
      print("TEST get all homestay: ${response.body}");
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(utf8.decode(response.bodyBytes));
        print("Xem body sau khi convert: $bodyConvert");
        var postsJson = bodyConvert['data'];
        homestay = (postsJson as List)
            .map<HomestayModel>((postJson) => HomestayModel.fromMap(postJson))
            .toList();
        print("Thông tin get all homestay: $homestay");
      }
    } catch (e) {
      print("Loi get all homestay: $e");
    }

    return homestay;
  }

  // <<<< Get detail homestay by id >>>>
  static Future<HomestayDetailModel?> getDetailHomestay(
      {required String idHomestay}) async {
    HomestayDetailModel? detailHomestay;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(myToken);

    try {
      var url = "$baseUrl/api/v1/Homestays/$idHomestay";
      Map<String, String> header = await ApiHeader.getHeader();
      header.addAll({'Authorization': 'Bearer $token'});
      var response = await http.get(Uri.parse(url.toString()), headers: header);
      // print("TEST get detail homestay: ${response.body}");
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(utf8.decode(response.bodyBytes));
        // print("Xem body sau khi convert: $bodyConvert");
        var postsJson = bodyConvert['data'];
        detailHomestay = HomestayDetailModel.fromMap(postsJson);
        print("Thông tin get detail homestay: $detailHomestay");
        print(
            "Thông tin get detail tiện ích chung: ${detailHomestay.homeStayGeneralAmenitieTitles}");
      }
    } catch (e) {
      print("Loi get detail homestay: $e");
    }

    return detailHomestay;
  }

  // <<<< Search homestay by location and capacity>>>>
  static Future<List<HomestayModel>?> searchHomestay(
      int? capacity, String location) async {
    List<HomestayModel>? homestay;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(myToken);
    print("Location là: $location");
    try {
      var url =
          "$baseUrl/api/v1/HomeStays?totalCapacity=${(capacity != null) ? capacity : 0}&location=$location";
      Map<String, String> header = await ApiHeader.getHeader();
      header.addAll({'Authorization': 'Bearer $token'});
      var response = await http.get(Uri.parse(url.toString()), headers: header);
      print("TEST search homestay: ${response.body}");
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(utf8.decode(response.bodyBytes));
        print("Xem body sau khi convert: $bodyConvert");
        var postsJson = bodyConvert['data'];
        homestay = (postsJson as List)
            .map<HomestayModel>((postJson) => HomestayModel.fromMap(postJson))
            .toList();
        print("Thông tin search homestay: $homestay");
      }
    } catch (e) {
      print("Loi search homestay: $e");
    }

    return homestay;
  }
}
