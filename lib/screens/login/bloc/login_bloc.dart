import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_home_travel/api/api_user.dart';
import 'package:mobile_home_travel/constants/myToken.dart';
import 'package:mobile_home_travel/screens/login/bloc/login_event.dart';
import 'package:mobile_home_travel/screens/login/bloc/login_state.dart';
import 'package:mobile_home_travel/utils/shared_preferences_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      await loginUser(emit, event);
    });
  }
  loginUser(Emitter<LoginState> emit, LoginEvent event) async {
    emit(LoginLoading());
    try {
      if (event is CheckLoginEvent) {
        String? id = SharedPreferencesUtil.getIdUserCurrent();
        if (id != "" && id != null) {
          var userModel = await ApiUser.getProfile();
          if (userModel != null) {
            emit(LoginSecondState(userProfileModel: userModel));
          } else {
            emit(LoginFirstState());
          }
        } else {
          emit(LoginFirstState());
        }
      } else if (event is StartLoginEvent) {
        if (event.username == "" || event.password == "") {
          emit(const LoginFailure(
              error: "Số điện thoại & mật khẩu không được để trống!"));
        } else {
          var user = await ApiUser.login(
              phoneNumber: event.username, password: event.password);
          if (user != null) {
            SharedPreferencesUtil.setToken(user.token ?? "");
            SharedPreferencesUtil.setIdUserCurrent(user.id!);
            SharedPreferencesUtil.setPhoneNumber(user.phoneNumber!);
            var userLogin = await ApiUser.getProfile();
            var isSubcribeNoti = await ApiUser.subcribeNotification();
            print('Noti subcribe: $isSubcribeNoti');
            emit(LoginSuccessState(userProfileModel: userLogin!));
          } else {
            emit(const LoginFailure(
                error: "Số điện thoại hoặc mật khẩu không chính xác!"));
          }
        }
      }
    } catch (e) {
      print("Loi bloc: $e");
      emit(const LoginFailure(error: "Error!"));
    }
  }
}
