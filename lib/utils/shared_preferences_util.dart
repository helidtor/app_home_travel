import 'package:mobile_home_travel/constants/myToken.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtil {
  static late SharedPreferences _prefsInstance;

  static Future<SharedPreferences> init() async {
    return _prefsInstance = await SharedPreferences.getInstance();
  }

  static void setId(String id) {
    _prefsInstance.setString('id', id);
  }

  static String? getId() {
    return _prefsInstance.getString('id');
  }

  static void setToken(String token) {
    _prefsInstance.setString(myToken, token);
  }

  static String? getToken() {
    return _prefsInstance.getString(myToken);
  }

  static void setIdUserCurrent(String idUserCurrent) {
    _prefsInstance.setString('idUserCurrent', idUserCurrent);
  }

  static String? getIdUserCurrent() {
    print('Id của user hiện tại: ${_prefsInstance.getString('idUserCurrent')}');
    return _prefsInstance.getString('idUserCurrent');
  }

  static void setPhoneNumber(String phoneNumber) {
    _prefsInstance.setString('phoneNumber', phoneNumber);
  }

  static String? getPhoneNumber() {
    return _prefsInstance.getString('phoneNumber');
  }

  static void setIdHomestay(String idHomestay) {
    _prefsInstance.setString('idHomestay', idHomestay);
  }

  static String? getIdHomestay() {
    return _prefsInstance.getString('idHomestay');
  }

  static void setIdWishlist(String idWishlist) {
    _prefsInstance.setString('idWishlist', idWishlist);
  }

  static String? getIdWishlist() {
    return _prefsInstance.getString('idWishlist');
  }

  static void setIdRoom(String idRoom) {
    _prefsInstance.setString('idRoom', idRoom);
  }

  static String? getIdRoom() {
    return _prefsInstance.getString('idRoom');
  }

  static void setTimeTarget(String timeTarget) {
    _prefsInstance.setString('timeTarget', timeTarget);
  }

  static String? getTimeTarget() {
    return _prefsInstance.getString('timeTarget');
  }

  static void setListIdPicked(List<String> listIdPicked) {
    _prefsInstance.setStringList('listIdPicked', listIdPicked);
  }

  static List<String>? getListIdPicked() {
    return _prefsInstance.getStringList('listIdPicked');
  }

  static void setFCMToken(String fCMToken) {
    _prefsInstance.setString('fCMToken', fCMToken);
  }

  static String? getFCMToken() {
    return _prefsInstance.getString('fCMToken');
  }
}
