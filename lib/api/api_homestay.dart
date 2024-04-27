import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_home_travel/api/api_header.dart';
import 'package:mobile_home_travel/constants/baseUrl.dart';
import 'package:mobile_home_travel/constants/myToken.dart';
import 'package:mobile_home_travel/models/booking/wishlist_model.dart';
import 'package:mobile_home_travel/models/homestay/feedback/feedback_model.dart';
import 'package:mobile_home_travel/models/homestay/general_homestay/homestay_detail_model.dart';
import 'package:mobile_home_travel/models/homestay/general_homestay/homestay_model.dart';
import 'package:mobile_home_travel/models/homestay/policy/homestay_policy_selected_model.dart';
import 'package:mobile_home_travel/models/homestay/policy/policy_title_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiHomestay {
  // <<<< Get all homestay >>>>
  static Future<List<HomestayModel>?> getAllHomestay() async {
    List<HomestayModel>? homestay;
    try {
      var url = "$baseUrl/api/v1/HomeStays?pageSize=50&status=ACTIVE";
      Map<String, String> header = await ApiHeader.getHeader();
      var response = await http.get(Uri.parse(url.toString()), headers: header);
      // print("TEST get all homestay: ${jsonDecode(utf8.decode(response.bodyBytes))}");
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(utf8.decode(response.bodyBytes));
        // print("Xem body sau khi convert: $bodyConvert");
        var postsJson = bodyConvert['data'];
        homestay = (postsJson as List)
            .map<HomestayModel>((postJson) => HomestayModel.fromMap(postJson))
            .toList();
        print("Thông tin get all homestay: $homestay");
      } else {
        print("Loi get all homestay");
        return null;
      }
    } catch (e) {
      print("Loi get all homestay: $e");
      return null;
    }
    return null;
  }

// <<<< Get all homestay by sortKey >>>>
  static Future<List<HomestayModel>?> getAllHomestayBySort(
      {required String sortKey}) async {
    List<HomestayModel>? listHomestay;
    try {
      var url =
          "$baseUrl/api/v1/HomeStays?pageSize=50&status=ACTIVE&sortKey=$sortKey&sortOrder=DESC";
      Map<String, String> header = await ApiHeader.getHeader();
      var response = await http.get(Uri.parse(url.toString()), headers: header);
      // print("TEST get all homestay: ${jsonDecode(utf8.decode(response.bodyBytes))}");
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(utf8.decode(response.bodyBytes));
        // print("Xem body sau khi convert: $bodyConvert");
        var postsJson = bodyConvert['data'];
        listHomestay = (postsJson as List)
            .map<HomestayModel>((postJson) => HomestayModel.fromMap(postJson))
            .toList();
        // print("Thông tin get all homestay by sort: $listHomestay");
        if (listHomestay.isNotEmpty) {
          return listHomestay;
        } else {
          print("Loi get all homestay bằng sort key rỗng");
          return null;
        }
      } else {
        print("Loi get all homestay bằng sort key");
        return null;
      }
    } catch (e) {
      print("Loi get all homestay bang sort key: $e");
      return null;
    }
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
      // print("TEST get detail homestay: ${jsonDecode(utf8.decode(response.bodyBytes))}");
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(utf8.decode(response.bodyBytes));
        // print("Xem body sau khi convert: $bodyConvert");
        var postsJson = bodyConvert['data'];
        detailHomestay = HomestayDetailModel.fromMap(postsJson);
        print("Thông tin get detail homestay: $detailHomestay");
        // print(
        //     "Thông tin get detail tiện ích chung: ${detailHomestay.homeStayGeneralAmenitieTitles}");
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
          "$baseUrl/api/v1/HomeStays??pageSize=50&totalCapacity=${capacity ?? 0}&location=$location&status=ACTIVE";
      Map<String, String> header = await ApiHeader.getHeader();
      header.addAll({'Authorization': 'Bearer $token'});
      var response = await http.get(Uri.parse(url.toString()), headers: header);
      print(
          "TEST search homestay: ${jsonDecode(utf8.decode(response.bodyBytes))}");
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(utf8.decode(response.bodyBytes));
        // print("Xem body sau khi convert: $bodyConvert");
        var postsJson = bodyConvert['data'];
        homestay = (postsJson as List)
            .map<HomestayModel>((postJson) => HomestayModel.fromMap(postJson))
            .toList();
        print("Thông tin search homestay: $homestay");
        return homestay;
      }
    } catch (e) {
      print("Loi search homestay: $e");
      return null;
    }
    return null;
  }

  // <<<< Add Wishlist homestay >>>>
  static Future<bool?> wishlistHomestay() async {
    WishlistModel? wishlistModel;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(myToken);
    String? idTourist = prefs.getString("idUserCurrent");
    String? idHomestay = prefs.getString("idHomestay");
    var url = "$baseUrl/api/v1/TouristFavoriteHomestays";
    Map<String, String> header = await ApiHeader.getHeader();
    header.addAll({'Authorization': 'Bearer $token'});
    try {
      final body = {
        'touristId': idTourist,
        'homeStayId': idHomestay,
      };
      var response = await http.post(Uri.parse(url.toString()),
          headers: header, body: jsonEncode(body));
      print("TEST wishlist: ${jsonDecode(utf8.decode(response.bodyBytes))}");
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(utf8.decode(response.bodyBytes));
        // print("Xem body sau khi convert: $bodyConvert");
        var postsJson = bodyConvert['data'];
        wishlistModel = WishlistModel.fromMap(postsJson);
        prefs.setString('idWishlist', wishlistModel.id!);
        return true;
      } else {
        print('Error wishlist');
        return false;
      }
    } catch (e) {
      print("Loi wishlist: $e");
    }
    return false;
  }

// <<<< Get wishlist by id tourist & homestay >>>>
  static Future<WishlistModel?> getWishlistByIdTouristAndHomeStay(
      {required String idTourist, required String idHomestay}) async {
    List<WishlistModel>? wishlist;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(myToken);
    try {
      var url =
          "$baseUrl/api/v1/TouristFavoriteHomestays?pageSize=50&touristId=$idTourist&homeStayId=$idHomestay";
      Map<String, String> header = await ApiHeader.getHeader();
      header.addAll({'Authorization': 'Bearer $token'});
      var response = await http.get(Uri.parse(url.toString()), headers: header);
      // print("TEST get wishlist: ${jsonDecode(utf8.decode(response.bodyBytes))}");
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(utf8.decode(response.bodyBytes));
        var postsJson = bodyConvert['data'];
        wishlist = (postsJson as List)
            .map<WishlistModel>((postJson) => WishlistModel.fromMap(postJson))
            .toList();
        // print("Thông tin get wishlist: $wishlist");
        return wishlist[0];
      }
    } catch (e) {
      print("Loi get wishlist: $e");
    }

    return null;
  }

  // <<<< Delete Wishlist homestay >>>>
  static Future<bool?> deleteWishlistHomestay() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(myToken);
    String? idWishlist = prefs.getString('idWishlist');
    var url = "$baseUrl/api/v1/TouristFavoriteHomestays/$idWishlist";
    Map<String, String> header = await ApiHeader.getHeader();
    header.addAll({'Authorization': 'Bearer $token'});
    try {
      var response =
          await http.delete(Uri.parse(url.toString()), headers: header);
      print(
          "TEST xóa wishlist: ${response.statusCode} idWishlist là: $idWishlist");
      if (response.statusCode == 204) {
        return true;
      } else {
        print('Error delete wishlist');
        return false;
      }
    } catch (e) {
      print("Loi xóa wishlist: $e");
    }
    return false;
  }

  // <<<< Get wishlist >>>>
  static Future<List<WishlistModel>?> getListWishlist() async {
    List<WishlistModel>? listWishlist;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(myToken);
    String? idTourist = prefs.getString('idUserCurrent');

    try {
      var url =
          "$baseUrl/api/v1/TouristFavoriteHomestays?pageSize=50&touristId=$idTourist&pageSize=50&sortKey=CreatedDate&sortOrder=DESC";
      Map<String, String> header = await ApiHeader.getHeader();
      header.addAll({'Authorization': 'Bearer $token'});
      var response = await http.get(Uri.parse(url.toString()), headers: header);
      print(
          "TEST get wishlist: ${jsonDecode(utf8.decode(response.bodyBytes))}");
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(utf8.decode(response.bodyBytes));
        // print("Xem body sau khi convert: $bodyConvert");
        var postsJson = bodyConvert['data'];
        listWishlist = (postsJson as List)
            .map<WishlistModel>((postJson) => WishlistModel.fromMap(postJson))
            .toList();
        print("Thông tin get wishlist: $listWishlist");
      }
    } catch (e) {
      print("Loi get wishlist: $e");
    }

    return listWishlist;
  }

  // <<<< Get all listFeedback homestay by idHomestay >>>>
  static Future<List<FeedbackModel>?> getFeedbackByIdHomeStay(
      {required String idHomestay}) async {
    List<FeedbackModel>? listFeedback;
    try {
      var url =
          "$baseUrl/api/v1/Feedbacks?pageSize=50&sortKey=CreatedDate&sortOrder=DESC&homeStayId=$idHomestay";
      Map<String, String> header = await ApiHeader.getHeader();
      var response = await http.get(Uri.parse(url.toString()), headers: header);
      // print("TEST get all listFeedback: ${jsonDecode(utf8.decode(response.bodyBytes))}");
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(utf8.decode(response.bodyBytes));
        // print("Xem body sau khi convert: $bodyConvert");
        var postsJson = bodyConvert['data'];
        listFeedback = (postsJson as List)
            .map<FeedbackModel>((postJson) => FeedbackModel.fromMap(postJson))
            .toList();
        // print("Thông tin get all listFeedback: $listFeedback");
        return listFeedback;
      } else {
        print("Loi get all listFeedback");
        return null;
      }
    } catch (e) {
      print("Loi get all listFeedback: $e");
      return null;
    }
  }

  // <<<< get lastest Feedback of tourist >>>>
  static Future<FeedbackModel?> getLastestFeedbackOfTourist(
      {required String idHomestay}) async {
    List<FeedbackModel>? listFeedback;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? idTourist = prefs.getString("idUserCurrent");

    try {
      var url =
          "$baseUrl/api/v1/Feedbacks?pageSize=50&touristId=$idTourist&sortKey=CreatedDate&sortOrder=ASC&homeStayId=$idHomestay";
      Map<String, String> header = await ApiHeader.getHeader();
      var response = await http.get(Uri.parse(url.toString()), headers: header);
      // print("TEST get all getLastestFeedbackOfTourist: ${jsonDecode(utf8.decode(response.bodyBytes))}");
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(utf8.decode(response.bodyBytes));
        // print("Xem body getLastestFeedbackOfTourist sau khi convert: $bodyConvert");
        var postsJson = bodyConvert['data'];
        listFeedback = (postsJson as List)
            .map<FeedbackModel>((postJson) => FeedbackModel.fromMap(postJson))
            .toList();
        print("Thông tin get all listFeedback: $listFeedback");
        if (listFeedback.isNotEmpty) {
          return listFeedback[0];
        }
      } else {
        print("Loi get all listFeedback");
        return null;
      }
    } catch (e) {
      print("Loi get all listFeedback: $e");
      return null;
    }
  }

  // <<<< create feedback homestay >>>>
  static Future<bool?> createFeedbackHomestay(
      {required FeedbackModel feedbackModel}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(myToken);
    String? idTourist = prefs.getString("idUserCurrent");
    var url = "$baseUrl/api/v1/Feedbacks";
    Map<String, String> header = await ApiHeader.getHeader();
    header.addAll({'Authorization': 'Bearer $token'});
    try {
      final body = {
        'description': feedbackModel.description,
        'rating': feedbackModel.rating,
        'touristId': idTourist,
        'homeStayId': feedbackModel.homeStayId,
      };
      var response = await http.post(Uri.parse(url.toString()),
          headers: header, body: jsonEncode(body));
      print(
          "TEST create feedback: ${jsonDecode(utf8.decode(response.bodyBytes))}");
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(utf8.decode(response.bodyBytes));
        print("Xem body create feedback sau khi convert: $bodyConvert");
        return true;
      } else {
        print('Error create feedback');
        return false;
      }
    } catch (e) {
      print("Loi create feedback: $e");
    }
    return false;
  }

  // <<<< Get all policy >>>>
  static Future<List<HomestayPolicySelectedModel>?> getAllPolicy(
      {required String homestayId}) async {
    List<HomestayPolicySelectedModel>? listPolicies;
    try {
      var url =
          "$baseUrl/api/v1/HomeStayPolicySelecteds?pageSize=50&homeStayId=$homestayId";
      Map<String, String> header = await ApiHeader.getHeader();
      var response = await http.get(Uri.parse(url.toString()), headers: header);
      // print("TEST get all policy: ${jsonDecode(utf8.decode(response.bodyBytes))}");
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(utf8.decode(response.bodyBytes));
        // print("Xem body policy sau khi convert: $bodyConvert");
        var postsJson = bodyConvert['data'];
        listPolicies = (postsJson as List)
            .map<HomestayPolicySelectedModel>(
                (postJson) => HomestayPolicySelectedModel.fromMap(postJson))
            .toList();
        // print("Thông tin get all policy: $listPolicies");
        return listPolicies;
      } else {
        print("Loi get all policy");
        return null;
      }
    } catch (e) {
      print("Loi get all policy: $e");
      return null;
    }
    return null;
  }
}
