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

//Signup
  static Future<String?> signup(
      {required UserSignUpModel userSignUpModel}) async {
    final url = Uri.parse('$baseUrl/api/v1/Tourists');
    Map<String, String> header = await ApiHeader.getHeader();
    try {
      final body = {
        'phoneNumber': userSignUpModel.phoneNumber,
        'firstName': userSignUpModel.firstName,
        'lastName': userSignUpModel.lastName,
        'email': userSignUpModel.email,
        'gender': userSignUpModel.gender,
        'password': userSignUpModel.password,
        'status': userSignUpModel.status
      };
      var response = await http.post(Uri.parse(url.toString()),
          headers: header, body: jsonEncode(body));
      if (response.statusCode == 200) {
        print("Đăng ký thành công!");
        return "success";
      }
    } catch (e) {
      print("Lỗi đăng ký: $e");
    }
    return "Đăng ký thất bại";
  }

  // <<<< Get profile >>>>
  static Future<UserProfileModel?> getProfile({required String id}) async {
    UserProfileModel? userProfileModel;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(myToken);
    String? id = prefs.getString("idUserCurrent");
    try {
      var url = "$baseUrl/api/v1/Tourists/$id";
      Map<String, String> header = await ApiHeader.getHeader();
      header.addAll({'Authorization': 'Bearer $token'});
      var response = await http.get(Uri.parse(url.toString()), headers: header);
      print("TEST get profile: ${jsonDecode(utf8.decode(response.bodyBytes))}");
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

  //Update profile
  static Future<bool> updateProfile(
      UserProfileModel userProfileModel, String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
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
