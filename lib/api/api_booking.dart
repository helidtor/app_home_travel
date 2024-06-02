import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_home_travel/api/api_header.dart';
import 'package:mobile_home_travel/constants/baseUrlApi.dart';
import 'package:mobile_home_travel/models/booking/create_booking_detail_model.dart';
import 'package:mobile_home_travel/models/booking/booking_homestay_model.dart';
import 'package:mobile_home_travel/models/booking/input_calculate_price_model.dart';
import 'package:mobile_home_travel/models/booking/price_room_model.dart';
import 'package:mobile_home_travel/utils/shared_preferences_util.dart';

class ApiBooking {
  //Tính giá phòng
  static Future<List<PriceRoomModel>> calculatePrice(
      {required List<InputCalculatePriceModel> inputCalculate}) async {
    // print('Thông tin phòng nhập vào để tính tiền phòng là: $inputCalculate');
    List<PriceRoomModel> listPriceRoom = [];
    try {
      var url = "$baseUrl/api/v1/Bookings/Amount";
      Map<String, String> header = await ApiHeader.getHeader();
      List<Map<String, dynamic>> jsonList =
          inputCalculate.map((model) => model.toJson()).toList();
      // print('Thông tin các phòng nhập vào để tính tiền: $jsonList');
      final body = json.encode(jsonList);
      // print('Body nè: $body');
      var response = await http.post(Uri.parse(url.toString()),
          headers: header, body: body);
      // print(
      //     'Thông tin trả về giá phòng trong api: ${jsonDecode(utf8.decode(response.bodyBytes))}');
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(response.body);
        if (bodyConvert['success'] == true) {
          var postsJson = bodyConvert['data'];
          // print('Thông tin trả về giá phòng từ api $postsJson');
          listPriceRoom = (postsJson as List)
              .map<PriceRoomModel>(
                  (postJson) => PriceRoomModel.fromMap(postJson))
              .toList();
          // print('Thông tin trả về giá phòng ${listPriceRoom.first}');
          return listPriceRoom;
        } else {
          print(
              "Lỗi tính tiền phòng: ${jsonDecode(utf8.decode(response.bodyBytes))}");
        }
      } else {
        print(
            "Lỗi tính tiền room: ${jsonDecode(utf8.decode(response.bodyBytes))}");
      }
    } catch (e) {
      print("Error calculate price room: $e");
    }
    return listPriceRoom;
  }

  //Tạo booking
  static Future<BookingHomestayModel?> createBooking(
      {required BookingHomestayModel bookingInput,
      required int totalCapacity}) async {
    // print('Thông tin booking nhập vào để tạo booking là: $bookingInput');
    BookingHomestayModel? bookingHomestayModel;
    String? token = SharedPreferencesUtil.getToken();
    try {
      var url = "$baseUrl/api/v1/Bookings";
      Map<String, String> header = await ApiHeader.getHeader();
      header.addAll({'Authorization': 'Bearer $token'});
      final body = {
        "totalPrice": bookingInput.totalPrice,
        "checkInDate": bookingInput.checkInDate,
        "checkOutDate": bookingInput.checkOutDate,
        "totalCapacity": totalCapacity,
        "status": "DRAFT",
        "touristId": bookingInput.touristId
      };
      // print('Body nè: $body');
      var response = await http.post(Uri.parse(url.toString()),
          headers: header, body: jsonEncode(body));
      // print(
      //     'Thông tin đơn booking được tạo trong api: ${jsonDecode(utf8.decode(response.bodyBytes))}');
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(response.body);
        // print('Thông tin đơn booking được tạo trong api: $bodyConvert');
        if (bodyConvert['success'] == true) {
          var postsJson = bodyConvert['data'];
          bookingHomestayModel = BookingHomestayModel.fromMap(postsJson);
          print("Tạo booking thành công");
        } else {
          print(
              "Lỗi tạo bookings: ${jsonDecode(utf8.decode(response.bodyBytes))}");
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
      {required CreateBookingDetailModel bookingHomestayDetail}) async {
    String? token = SharedPreferencesUtil.getToken();
    try {
      var url = "$baseUrl/api/v1/BookingDetails";
      Map<String, String> header = await ApiHeader.getHeader();
      header.addAll({'Authorization': 'Bearer $token'});
      final body = json.encode(bookingHomestayDetail.toMap());
      var response = await http.post(Uri.parse(url.toString()),
          headers: header, body: body);
      // print(response.body);
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
    String? token = SharedPreferencesUtil.getToken();
    try {
      var url = "$baseUrl/api/v1/Bookings/${bookingInput.id}";
      Map<String, String> header = await ApiHeader.getHeader();
      header.addAll({'Authorization': 'Bearer $token'});
      var body = json.encode(bookingInput.toMap());
      // print('Body nè: $body');
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

  // <<<< Get list booking theo status >>>>
  static Future<List<BookingHomestayModel>?> getListBooking(
      {required String status, String? status2}) async {
    List<BookingHomestayModel>? listBooking;
    String? token = SharedPreferencesUtil.getToken();
    String? idTourist = SharedPreferencesUtil.getIdUserCurrent();
    var url;
    try {
      if (status2 != null) {
        url =
            "$baseUrl/api/v1/Bookings?pageSize=50&sortKey=CreatedDate&sortOrder=DESC&status=$status&status=$status2&touristId=$idTourist";
      } else {
        url =
            "$baseUrl/api/v1/Bookings?pageSize=50&sortKey=CreatedDate&sortOrder=DESC&status=$status&touristId=$idTourist";
      }
      Map<String, String> header = await ApiHeader.getHeader();
      header.addAll({'Authorization': 'Bearer $token'});
      var response = await http.get(Uri.parse(url.toString()), headers: header);
      // print(
      //     "TEST get booking $status: ${jsonDecode(utf8.decode(response.bodyBytes))}");
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(response.body);
        var postsJson = bodyConvert['data'];
        listBooking = (postsJson as List)
            .map<BookingHomestayModel>(
                (postJson) => BookingHomestayModel.fromMap(postJson))
            .toList();
        // print("Số Lượng: ${listBooking.length}");
        // print(
        //     "Thông tin model $status từ get list booking: $listBooking");
        if (listBooking.isNotEmpty) {
          return listBooking;
        } else {
          return null;
        }
      } else {
        print('Lỗi get list booking');
        return null;
      }
    } catch (e) {
      print("Loi get list booking: $e");
    }
    return null;
  }

// <<<< Get booking detail theo id >>>>
  static Future<List<BookingHomestayModel>?> getBookingDetailById(
      {required String id}) async {
    List<BookingHomestayModel>? listBooking;
    String? token = SharedPreferencesUtil.getToken();
    String? idTourist = SharedPreferencesUtil.getIdUserCurrent();
    try {
      var url =
          "$baseUrl/api/v1/Bookings?pageSize=50&bookingId=$id&touristId=$idTourist";
      Map<String, String> header = await ApiHeader.getHeader();
      header.addAll({'Authorization': 'Bearer $token'});
      var response = await http.get(Uri.parse(url.toString()), headers: header);
      // print(
      //     "TEST get booking $status: ${jsonDecode(utf8.decode(response.bodyBytes))}");
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(response.body);
        var postsJson = bodyConvert['data'];
        listBooking = (postsJson as List)
            .map<BookingHomestayModel>(
                (postJson) => BookingHomestayModel.fromMap(postJson))
            .toList();
        // print("Số Lượng: ${listBooking.length}");
        // print(
        //     "Thông tin model $status từ get list booking: $listBooking");
        if (listBooking.isNotEmpty) {
          return listBooking;
        } else {
          return null;
        }
      } else {
        print('Lỗi get list booking');
        return null;
      }
    } catch (e) {
      print("Loi get list booking: $e");
    }
    return null;
  }

  // <<<< Checkout deposit by card >>>>
  static Future<String?> checkoutDepositByCard(
      {required String idBooking}) async {
    String? link;
    String? token = SharedPreferencesUtil.getToken();
    var url = "$baseUrl/api/v1/Bookings/$idBooking/PayByVNPay";
    Map<String, String> header = await ApiHeader.getHeader();
    header.addAll({'Authorization': 'Bearer $token'});
    try {
      var response = await http.get(Uri.parse(url.toString()), headers: header);
      print(
          "TEST thanh toán deposit bằng thẻ: ${jsonDecode(utf8.decode(response.bodyBytes))}");
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(response.body);
        link = bodyConvert['data']['url'];
        print('Link thanh toán bằng thẻ là: $link');
        return link;
      } else {
        print('Error pay deposit by card');
        return null;
      }
    } catch (e) {
      print("Loi thanh toán deposit thẻ: $e");
    }
    return null;
  }

// <<<< Checkout full by card >>>>
  static Future<String?> checkoutFullByCard({required String idBooking}) async {
    String? link;
    String? token = SharedPreferencesUtil.getToken();
    var url = "$baseUrl/api/v1/Bookings/$idBooking/PayFullByVNPay";
    Map<String, String> header = await ApiHeader.getHeader();
    header.addAll({'Authorization': 'Bearer $token'});
    try {
      var response = await http.get(Uri.parse(url.toString()), headers: header);
      print(
          "TEST thanh toán full bằng thẻ: ${jsonDecode(utf8.decode(response.bodyBytes))}");
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(response.body);
        link = bodyConvert['data']['url'];
        print('Link thanh toán full bằng thẻ là: $link');
        return link;
      } else {
        print('Error pay full by card');
        return null;
      }
    } catch (e) {
      print("Loi thanh toán thẻ: $e");
    }
    return null;
  }

  // <<<< Checkout deposit by wallet >>>>
  static Future<bool?> checkoutDepositByWallet(
      {required String idBooking}) async {
    String? token = SharedPreferencesUtil.getToken();
    var url = "$baseUrl/api/v1/Bookings/$idBooking/PayByWallet";
    Map<String, String> header = await ApiHeader.getHeader();
    header.addAll({'Authorization': 'Bearer $token'});
    try {
      var response = await http.get(Uri.parse(url.toString()), headers: header);
      print("TEST thanh toán cọc bằng ví: ${jsonEncode(response.body)}");
      if (response.statusCode == 200) {
        return true;
      } else {
        print('Error pay deposit by wallet');
        return false;
      }
    } catch (e) {
      print("Loi thanh toán deposit bằng ví: $e");
    }
    return false;
  }

  // <<<< Checkout full by wallet >>>>
  static Future<bool?> checkoutFullByWallet({required String idBooking}) async {
    String? token = SharedPreferencesUtil.getToken();
    var url = "$baseUrl/api/v1/Bookings/$idBooking/PayFullByWallet";
    Map<String, String> header = await ApiHeader.getHeader();
    header.addAll({'Authorization': 'Bearer $token'});
    try {
      var response = await http.get(Uri.parse(url.toString()), headers: header);
      print("TEST thanh toán full bằng ví: ${jsonEncode(response.body)}");
      if (response.statusCode == 200) {
        return true;
      } else {
        print('Error pay full by wallet');
        return false;
      }
    } catch (e) {
      print("Loi thanh toán full bằng ví: $e");
    }
    return false;
  }
}
