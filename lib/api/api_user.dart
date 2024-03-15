import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_home_travel/api/api_provider.dart';
import 'package:mobile_home_travel/constants/baseUrl.dart';
import 'package:mobile_home_travel/constants/myToken.dart';
import 'package:mobile_home_travel/models/homestay/homestay_model.dart';
import 'package:mobile_home_travel/models/user/login_user_model.dart';
import 'package:mobile_home_travel/models/user/profile_user_model.dart';
import 'package:mobile_home_travel/models/user/sign_up_user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiProvider {
//Login
  static Future<UserLoginModel?> login(
      {required String phoneNumber, required String password}) async {
    UserLoginModel? userLoginModel;

    final url = Uri.parse('$baseUrl/api/v1/Tourists/login');
    Map<String, String> header = await ApiHeader.getHeader();
    try {
      final body = {
        'phoneNumber': phoneNumber,
        'password': password,
      };
      var response = await http.post(Uri.parse(url.toString()),
          headers: header, body: jsonEncode(body));
      print("TEST login: ${response.body}");
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
    String? id = prefs.getString("id");
    try {
      var url = "$baseUrl/api/v1/Tourists/$id";
      Map<String, String> header = await ApiHeader.getHeader();
      header.addAll({'Authorization': 'Bearer $token'});
      var response = await http.get(Uri.parse(url.toString()), headers: header);
      print("TEST get profile: ${response.body}");
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
        print("Update profile thất bại");
        return false;
      }
    } catch (e) {
      print("Loi update profile: $e");
      return false;
    }
  }
}
