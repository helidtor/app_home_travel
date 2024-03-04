import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_home_travel/constants/baseUrl.dart';
import 'package:mobile_home_travel/constants/myToken.dart';
import 'package:mobile_home_travel/models/homestay_model.dart';
import 'package:mobile_home_travel/models/login_user_model.dart';
import 'package:mobile_home_travel/models/profile_user_model.dart';
import 'package:mobile_home_travel/models/sign_up_user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiProvider {
  static Future<Map<String, String>> getHeader() async {
    Map<String, String> header = {
      "content-type": "application/json",
      "accept": "application/json",
    };
    return header;
  }

//Login
  static Future<UserLoginModel?> logins(
      {required String username, required String password}) async {
    UserLoginModel? userLoginModel;

    final url = Uri.parse('$baseUrl/api/Auth/Login');
    Map<String, String> header = await getHeader();
    try {
      final body = {
        'username': username,
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
    final url = Uri.parse('$baseUrl/api/Auth/Register');
    Map<String, String> header = await getHeader();
    try {
      final body = {
        'userName': userSignUpModel.userName,
        'firstName': userSignUpModel.firstName,
        'lastName': userSignUpModel.lastName,
        'email': userSignUpModel.email,
        'phoneNumber': userSignUpModel.phoneNumber,
        'gender': userSignUpModel.gender,
        'password': userSignUpModel.password,
        'confirmPassword': userSignUpModel.confirmPassword
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
    return "thất bại";
  }

  // <<<< Get profile >>>>
  static Future<UserProfileModel?> getProfile() async {
    UserProfileModel? userProfileModel;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(myToken);
    try {
      var url = "$baseUrl/api/AppUsers/currentUser";
      Map<String, String> header = await getHeader();
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

  // <<<< Get all homestay >>>>
  static Future<List<HomestayModel>?> getAllHomestay() async {
    List<HomestayModel>? homestay;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(myToken);

    try {
      var url = "$baseUrl/api/Homestays";
      Map<String, String> header = await getHeader();
      header.addAll({'Authorization': 'Bearer $token'});
      var response = await http.get(Uri.parse(url.toString()), headers: header);
      print("TEST get all homestay: ${response.body}");
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(utf8.decode(response.bodyBytes));
        // print("Xem body sau khi convert: $bodyConvert");
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

  //Update profile
  static Future<bool> updateProfile(
      UserProfileModel userProfileModel, int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(myToken);
    try {
      var url = "$baseUrl/api/AppUsers/$id";
      Map<String, String> header = await getHeader();
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
    return false;
  }
}
