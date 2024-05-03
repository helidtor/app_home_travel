import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mobile_home_travel/api/api_header.dart';
import 'package:mobile_home_travel/constants/baseUrl.dart';
import 'package:mobile_home_travel/constants/myToken.dart';
import 'package:mobile_home_travel/models/notification/notification_model.dart';
import 'package:mobile_home_travel/models/user/login_user_model.dart';
import 'package:mobile_home_travel/models/user/profile_user_model.dart';
import 'package:mobile_home_travel/models/user/sign_up_user_model.dart';
import 'package:mobile_home_travel/utils/shared_preferences_util.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_parser/http_parser.dart';

class ApiUser {
// <<<< Get list notification >>>>
  static Future<List<NotificationModel>?> getListNotification() async {
    List<NotificationModel>? listNotification;
    String? token = SharedPreferencesUtil.getToken();
    String? idTourist = SharedPreferencesUtil.getIdUserCurrent();

    try {
      var url =
          "$baseUrl/api/v1/Notifications?pageSize=50&receiverId=$idTourist&pageSize=50&sortKey=CreatedDate&sortOrder=DESC";
      Map<String, String> header = await ApiHeader.getHeader();
      header.addAll({'Authorization': 'Bearer $token'});
      var response = await http.get(Uri.parse(url.toString()), headers: header);
      print(
          "TEST get notification: ${jsonDecode(utf8.decode(response.bodyBytes))}");
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(utf8.decode(response.bodyBytes));
        // print("Xem body sau khi convert: $bodyConvert");
        var postsJson = bodyConvert['data'];
        listNotification = (postsJson as List)
            .map<NotificationModel>(
                (postJson) => NotificationModel.fromMap(postJson))
            .toList();
        print("Thông tin get notification: $listNotification");
      }
    } catch (e) {
      print("Loi get notification: $e");
    }

    return listNotification;
  }

//Subcribe noti
  static Future<bool?> subcribeNotification() async {
    String? idUser = SharedPreferencesUtil.getIdUserCurrent();
    String? fCMToken = SharedPreferencesUtil.getFCMToken();
    print('value fcmtoken: $fCMToken');
    final url = Uri.parse('$baseUrl/api/v1/Notifications/subscribe/$idUser');
    Map<String, String> header = await ApiHeader.getHeader();
    try {
      final body = ["$fCMToken"];
      var response = await http.post(Uri.parse(url.toString()),
          headers: header, body: jsonEncode(body));
      print("TEST noti: ${jsonEncode(body)}");
      print("Status noti: ${jsonDecode(response.body)}");
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Loi noti: $e");
      return false;
    }
  }

//Unsubcribe noti
  static Future<bool?> unsubcribeNotification() async {
    String? idUser = SharedPreferencesUtil.getIdUserCurrent();
    String? fCMToken = SharedPreferencesUtil.getFCMToken();
    print('value fcmtoken: $fCMToken');
    final url = Uri.parse('$baseUrl/api/v1/Notifications/unsubscribe/$idUser');
    Map<String, String> header = await ApiHeader.getHeader();
    try {
      final body = ["$fCMToken"];
      var response = await http.post(Uri.parse(url.toString()),
          headers: header, body: jsonEncode(body));
      print("TEST huy noti: ${jsonEncode(body)}");
      print("Status cancel noti: ${jsonDecode(response.body)}");
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Loi huy noti: $e");
      return false;
    }
  }

//read noti
  static Future<bool?> readNoti({required String idNoti}) async {
    final url = Uri.parse('$baseUrl/api/v1/Notifications');
    Map<String, String> header = await ApiHeader.getHeader();
    try {
      final body = [
        {
          "id": idNoti,
          "status": "READ",
        }
      ];
      var response = await http.put(Uri.parse(url.toString()),
          headers: header, body: jsonEncode(body));
      print("TEST read noti: ${jsonEncode(body)}");
      if (response.statusCode == 200 || response.statusCode == 204) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Loi read noti: $e");
      return false;
    }
  }

//Login
  static Future<UserLoginModel?> login(
      {required String phoneNumber, required String password}) async {
    UserLoginModel? userLoginModel;

    final url = Uri.parse('$baseUrl/api/v1/Tourists/login');
    Map<String, String> header = await ApiHeader.getHeader();
    print('Data login: $phoneNumber, $password');
    try {
      final body = {
        'phoneNumber': phoneNumber,
        'password': password,
      };
      var response = await http.post(Uri.parse(url.toString()),
          headers: header, body: jsonEncode(body));
      print("TEST login: ${jsonEncode(body)}");
      print("Status: ${jsonDecode(response.body)}");
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(response.body);
        userLoginModel = UserLoginModel.fromMap(bodyConvert['data']);
        print(userLoginModel);
        return userLoginModel;
      }
    } catch (e) {
      print("Loi login: $e");
    }
    return userLoginModel;
  }

// Signup
  static Future<bool?> signup(
      {required UserSignUpModel userSignUpModel}) async {
    // print('Thông tin tạo tài khoản: $userSignUpModel');9704198526191432198

    try {
      final url = Uri.parse('$baseUrl/api/v1/Tourists');
      Map<String, String> header = await ApiHeader.getHeader();
      var body = json.encode(userSignUpModel.toMap());
      var response = await http.post(Uri.parse(url.toString()),
          headers: header, body: body);
      print('Body là: $body');
      if (response.statusCode == 200) {
        print(
            "Đăng ký thành công! ${response.statusCode} ${jsonDecode(response.body)}");
        return true;
      }
    } catch (e) {
      print("Lỗi đăng ký: $e");
      return false;
    }
    return false;
  }

  // static Future<bool?> signup(
  //     {required UserSignUpModel userSignUpModel}) async {
  //   try {
  //     final url = Uri.parse('$baseUrl/api/v1/Tourists');
  //     Map<String, String> header = await ApiHeader.getHeader();

  //     var request = http.MultipartRequest('POST', url);

  //     // Add headers
  //     header.forEach((key, value) {
  //       request.headers[key] = value;
  //     });

  //     // Add fields
  //     request.fields['dateOfBirth'] = userSignUpModel.dateOfBirth!;
  //     request.fields['password'] = userSignUpModel.password!;
  //     request.fields['gender'] = userSignUpModel.gender!.toString();
  //     request.fields['phoneNumber'] = userSignUpModel.phoneNumber!;
  //     request.fields['email'] = userSignUpModel.email!;
  //     request.fields['firstName'] = userSignUpModel.firstName!;
  //     request.fields['lastName'] = userSignUpModel.lastName!;
  //     request.fields['avatar'] = userSignUpModel.avatar!;
  //     var response = await http.Response.fromStream(await request.send());

  //     if (response.statusCode == 200) {
  //       print(
  //           "Đăng ký thành công! ${response.statusCode} ${jsonDecode(response.body)}");
  //       return true;
  //     } else {
  //       print(
  //           "Đăng ký không thành công! ${response.statusCode} ${response.body}");
  //       return false;
  //     }
  //   } catch (e) {
  //     print("Lỗi đăng ký: $e");
  //     return false;
  //   }
  // }

  // <<<< Get profile >>>>
  static Future<UserProfileModel?> getProfile() async {
    UserProfileModel? userProfileModel;
    String? token = SharedPreferencesUtil.getToken();
    String? id = SharedPreferencesUtil.getIdUserCurrent();
    try {
      var url = "$baseUrl/api/v1/Tourists/$id";
      Map<String, String> header = await ApiHeader.getHeader();
      header.addAll({'Authorization': 'Bearer $token'});
      var response = await http.get(Uri.parse(url.toString()), headers: header);
      // print("TEST get profile: ${jsonDecode(utf8.decode(response.bodyBytes))}");
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(response.body);
        userProfileModel = UserProfileModel.fromMap(bodyConvert['data']);
        print("Thông tin model từ get profile: $userProfileModel");
        return userProfileModel;
      }
    } catch (e) {
      print("Loi get profile: $e");
    }
    return userProfileModel;
  }

// <<<< Get owner >>>>
  static Future<UserProfileModel?> getOwner({required String idOwner}) async {
    UserProfileModel? userProfileModel;
    String? token = SharedPreferencesUtil.getToken();

    try {
      var url = "$baseUrl/api/v1/Owners/$idOwner";
      Map<String, String> header = await ApiHeader.getHeader();
      header.addAll({'Authorization': 'Bearer $token'});
      var response = await http.get(Uri.parse(url.toString()), headers: header);
      // print("TEST get owner: ${jsonDecode(utf8.decode(response.bodyBytes))}");
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(response.body);
        userProfileModel = UserProfileModel.fromMap(bodyConvert['data']);
        // print("Thông tin model từ get owner: $userProfileModel");
        return userProfileModel;
      }
    } catch (e) {
      print("Loi get owner: $e");
    }
    return userProfileModel;
  }

  //Update profile
  static Future<bool> updateProfile(
      {required UserProfileModel userProfileModel, required String id}) async {
    print('Thông tin cập nhật gồm: $userProfileModel');
    String? token = SharedPreferencesUtil.getToken();
    try {
      var url = "$baseUrl/api/v1/Tourists/$id";
      Map<String, String> header = await ApiHeader.getHeader();
      header.addAll({'Authorization': 'Bearer $token'});
      var body = json.encode(userProfileModel.toMap());
      var response = await http.put(Uri.parse(url.toString()),
          headers: header, body: body);
      if (response.statusCode == 200) {
        print("Update profile xong");
        return true;
      } else {
        print("Update profile thất bại $userProfileModel");
        return false;
      }
    } catch (e) {
      print("Loi update profile: $e");
      return false;
    }
  }

//Change password
  static Future<num>? changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    String? token = SharedPreferencesUtil.getToken();
    String? idUserCurrent = SharedPreferencesUtil.getIdUserCurrent();
    try {
      var url =
          "$baseUrl/api/v1/Tourists/$idUserCurrent/changePassword?oldPassword=$oldPassword&newPassword=$newPassword";
      Map<String, String> header = await ApiHeader.getHeader();
      header.addAll({'Authorization': 'Bearer $token'});
      var response = await http.put(Uri.parse(url.toString()), headers: header);
      if (response.statusCode == 200) {
        print("Đổi mật khẩu thành công");
        return 200;
      } else if (response.statusCode == 400) {
        print("Mật khẩu cũ không chính xác ${jsonDecode(response.body)}");
        return 400;
      } else {
        print("Loi đổi password");
        return 404;
      }
    } catch (e) {
      print("Loi change password: $e");
      return 404;
    }
  }

  //Upload avatar
  static Future<String?> uploadImage(File image, String imageName) async {
    String? token = SharedPreferencesUtil.getToken();
    final url = Uri.parse('$baseUrl/api/v1/Files');
    final headers = {
      'accept': '*/*',
      'Authorization': 'Bearer $token',
      'Content-Type': 'multipart/form-data',
    };

    final request = http.MultipartRequest('POST', url)
      ..headers.addAll(headers)
      ..files.add(
        http.MultipartFile.fromBytes(
          'file',
          await image.readAsBytes(),
          filename: imageName, // Tên tệp tinh chỉnh
          contentType: MediaType('image', 'jpeg'), // Định dạng của hình ảnh
        ),
      );

    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        print('Upload thành công: ${jsonResponse['data']['url']}');
        return jsonResponse['data']['url'];
      } else {
        print('Lỗi upload: ${response.toString()}');
        return null;
      }
    } catch (e) {
      print('Upload lỗi: $e');
      return null;
    }
  }
}
