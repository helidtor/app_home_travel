import 'package:flutter/material.dart';
import 'package:mobile_home_travel/models/user/profile_user_model.dart';

class UserProvider extends ChangeNotifier {
  UserProfileModel _user = UserProfileModel();

  UserProfileModel get user => _user;

  void setUser(String user) {
    _user = UserProfileModel.fromJson(user);
    notifyListeners();
  }
}
