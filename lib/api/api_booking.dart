import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_home_travel/api/api_header.dart';
import 'package:mobile_home_travel/constants/baseUrl.dart';
import 'package:mobile_home_travel/constants/myToken.dart';
import 'package:mobile_home_travel/models/booking/booking_detail_model.dart';
import 'package:mobile_home_travel/models/booking/booking_homestay_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiBooking {
  //Tạo booking
  static Future<BookingHomestayModel?> createBooking(
      {required BookingHomestayModel bookingInput,
      required int totalCapacity}) async {
    print('Thông tin booking nhập vào để tạo booking là: $bookingInput');
    BookingHomestayModel? bookingHomestayModel;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(myToken);
    try {
      var url = "$baseUrl/api/v1/Bookings";
      Map<String, String> header = await ApiHeader.getHeader();
      header.addAll({'Authorization': 'Bearer $token'});
      final body = {
        "totalPrice": bookingInput.totalPrice,
        "checkInDate": bookingInput.checkInDate,
        "checkOutDate": bookingInput.checkOutDate,
        "totalCapacity": totalCapacity,
        "status": "PENDING",
        "touristId": bookingInput.touristId
      };
      print('Body nè: $body');
      var response = await http.post(Uri.parse(url.toString()),
          headers: header, body: jsonEncode(body));
      print(jsonDecode(response.body));
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(response.body);
        if (bodyConvert['success'] == true) {
          var postsJson = bodyConvert['data'];
          bookingHomestayModel = BookingHomestayModel.fromMap(postsJson);
          print("Tạo booking thành công");
        } else {
          print("Lỗi tạo booking: ${response.body}");
        }
      }
    } catch (e) {
      print("Error create booking: $e");
    }
    return bookingHomestayModel;
  }

  //Tạo booking
  static Future<bool> createBookingDetail(
      {required BookingHomestayDetail bookingHomestayDetail}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(myToken);
    try {
      var url = "$baseUrl/api/v1/BookingDetails";
      Map<String, String> header = await ApiHeader.getHeader();
      header.addAll({'Authorization': 'Bearer $token'});
      final body = json.encode(bookingHomestayDetail.toMap());
      var response = await http.post(Uri.parse(url.toString()),
          headers: header, body: body);
      print(response.body);
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(response.body);
        if (bodyConvert['success'] == true) {
          var postsJson = bodyConvert['data'];
          print("Tạo booking detail thành công");
          return true;
        } else {
          print("Lỗi tạo booking detail: ${response.body}");
          return false;
        }
      }
    } catch (e) {
      print("Error create booking detail: $e");
    }
    return false;
  }
}
