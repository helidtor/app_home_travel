import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mobile_home_travel/api/api_header.dart';
import 'package:mobile_home_travel/constants/baseUrl.dart';
import 'package:mobile_home_travel/constants/myToken.dart';
import 'package:mobile_home_travel/models/user/login_user_model.dart';
import 'package:mobile_home_travel/models/user/profile_user_model.dart';
import 'package:mobile_home_travel/models/user/sign_up_user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_parser/http_parser.dart';

class ApiUser {
//Subcribe noti
  static Future<bool?> subcribeNotification() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? idUser = prefs.getString("idUserCurrent");
    String? fCMToken = prefs.getString("fCMToken");
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? idUser = prefs.getString("idUserCurrent");
    String? fCMToken = prefs.getString("fCMToken");
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(myToken);
    String? id = prefs.getString("idUserCurrent");
    try {
      var url = "$baseUrl/api/v1/Tourists/$id";
      Map<String, String> header = await ApiHeader.getHeader();
      header.addAll({'Authorization': 'Bearer $token'});
      var response = await http.get(Uri.parse(url.toString()), headers: header);
      // print("TEST get profile: ${jsonDecode(utf8.decode(response.bodyBytes))}");
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(response.body);
        userProfileModel = UserProfileModel.fromMap(bodyConvert['data']);
        // print("Thông tin model từ get profile: $userProfileModel");
        return userProfileModel;
      }
    } catch (e) {
      print("Loi get profile: $e");
    }
    return userProfileModel;
  }

  //Update profile
  static Future<bool> updateProfile(
      {required UserProfileModel userProfileModel, required String id}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('Thông tin cập nhật gồm: $userProfileModel');
    String? token = prefs.getString(myToken);
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

  //Upload avatar
  static Future<String?> uploadImage(File image, String imageName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(myToken);
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
