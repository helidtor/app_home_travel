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
      // print(jsonDecode(utf8.decode(response.bodyBytes)));
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(response.body);
        if (bodyConvert['success'] == true) {
          var postsJson = bodyConvert['data'];
          bookingHomestayModel = BookingHomestayModel.fromMap(postsJson);
          print("Tạo booking thành công");
        } else {
          print(
              "Lỗi tạo booking: ${jsonDecode(utf8.decode(response.bodyBytes))}");
        }
      } else {
        print(
            "Lỗi tạo booking: ${jsonDecode(utf8.decode(response.bodyBytes))}");
      }
    } catch (e) {
      print("Error create booking: $e");
    }
    return bookingHomestayModel;
  }

  //Tạo booking detail
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
          print(
              "Lỗi tạo booking detail: ${jsonDecode(utf8.decode(response.bodyBytes))}");
          return false;
        }
      }
    } catch (e) {
      print("Error create booking detail: $e");
    }
    return false;
  }

  //Cập nhật booking
  static Future<bool> updateBooking(
      {required BookingHomestayModel bookingInput}) async {
    print('Thông tin booking nhập vào để update booking là: $bookingInput');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(myToken);
    try {
      var url = "$baseUrl/api/v1/Bookings/${bookingInput.id}";
      Map<String, String> header = await ApiHeader.getHeader();
      header.addAll({'Authorization': 'Bearer $token'});
      var body = json.encode(bookingInput.toMap());
      print('Body nè: $body');
      var response = await http.put(Uri.parse(url.toString()),
          headers: header, body: body);
      print(jsonDecode(response.body));
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(response.body);
        if (bodyConvert['success'] == true) {
          print("Cập nhật booking thành công");
          return true;
        } else {
          print(
              "Lỗi cập nhật booking: ${jsonDecode(utf8.decode(response.bodyBytes))}");
          return false;
        }
      }
    } catch (e) {
      print("Error update booking: $e");
      return false;
    }
    return false;
  }

  // <<<< Get booking đang dở >>>>
  static Future<BookingHomestayModel?> getBookingPending() async {
    List<BookingHomestayModel>? listBookingPending;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(myToken);
    String? idTourist = prefs.getString("idUserCurrent");
    try {
      var url =
          "$baseUrl/api/v1/Bookings?pageSize=50&status=PENDING&touristId=$idTourist";
      Map<String, String> header = await ApiHeader.getHeader();
      header.addAll({'Authorization': 'Bearer $token'});
      var response = await http.get(Uri.parse(url.toString()), headers: header);
      print(
          "TEST get booking pending: ${jsonDecode(utf8.decode(response.bodyBytes))}");
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(response.body);
        var postsJson = bodyConvert['data'];
        listBookingPending = (postsJson as List)
            .map<BookingHomestayModel>(
                (postJson) => BookingHomestayModel.fromMap(postJson))
            .toList();
        print("Thông tin model từ get booking pending: $listBookingPending");
        return listBookingPending[0];
      } else {
        print('Lỗi get booking pending');
        return null;
      }
    } catch (e) {
      print("Loi get booking dở: $e");
    }
    return null;
  }

  // <<<< Checkout by card >>>>
  static Future<String?> checkoutByCard({required String idBooking}) async {
    String? link;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(myToken);
    var url = "$baseUrl/api/v1/Bookings/$idBooking/PayByVNPay";
    Map<String, String> header = await ApiHeader.getHeader();
    header.addAll({'Authorization': 'Bearer $token'});
    try {
      var response = await http.get(Uri.parse(url.toString()), headers: header);
      print(
          "TEST thanh toán bằng thẻ: ${jsonDecode(utf8.decode(response.bodyBytes))}");
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(response.body);
        link = bodyConvert['data']['url'];
        print('Link thanh toán bằng thẻ là: $link');
        return link;
      } else {
        print('Error pay by card');
        return null;
      }
    } catch (e) {
      print("Loi thanh toán thẻ: $e");
    }
    return null;
  }

  // <<<< Checkout by wallet >>>>
  static Future<bool?> checkoutByWallet({required String idBooking}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(myToken);
    var url = "$baseUrl/api/v1/Bookings/$idBooking/PayByWallet";
    Map<String, String> header = await ApiHeader.getHeader();
    header.addAll({'Authorization': 'Bearer $token'});
    try {
      var response = await http.get(Uri.parse(url.toString()), headers: header);
      print("TEST thanh toán bằng ví: ${jsonEncode(response.body)}");
      if (response.statusCode == 200) {
        return true;
      } else {
        print('Error pay by wallet');
        return false;
      }
    } catch (e) {
      print("Loi thanh toán ví: $e");
    }
    return false;
  }
}
