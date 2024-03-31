import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_home_travel/api/api_header.dart';
import 'package:mobile_home_travel/constants/baseUrl.dart';
import 'package:mobile_home_travel/constants/myToken.dart';
import 'package:mobile_home_travel/models/booking/booking_homestay_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiBooking {
  //Tạo booking
  static Future<BookingHomestayModel?> createForm(
      BookingHomestayModel bookingInput) async {
    BookingHomestayModel? bookingHomestayModel;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(myToken);
    try {
      var url = "$baseUrl/v1/Bookings";
      Map<String, String> header = await ApiHeader.getHeader();
      header.addAll({'Authorization': 'Bearer $token'});
      final body = {
        'totalPrice': bookingInput.totalPrice,
        'checkInDate': bookingInput.checkInDate,
        'checkOutDate': bookingInput.checkOutDate,
        'status': bookingInput.status,
        'touristId': bookingInput.touristId,
      };
      var response = await http.post(Uri.parse(url.toString()),
          headers: header, body: jsonEncode(body));
      print(response.body);
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
}
