import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_home_travel/api/api_user.dart';
import 'package:mobile_home_travel/constants/myToken.dart';
import 'package:mobile_home_travel/screens/login/bloc/login_event.dart';
import 'package:mobile_home_travel/screens/login/bloc/login_state.dart';
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
      SharedPreferences prefs = await SharedPreferences.getInstance();

      if (event is CheckLoginEvent) {
        String? id = prefs.getString("id");
        if (id != null) {
          var userModel = await ApiProvider.getProfile(id: id);
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
              error: "Tài khoản & mật khẩu không được để trống!"));
        } else {
          var user = await ApiProvider.login(
              phoneNumber: event.username, password: event.password);
          if (user != null) {
            prefs.setString(myToken, user.token ?? "");
            prefs.setString("id", user.id!);
            var userLogin = await ApiProvider.getProfile(id: user.id!);
            emit(LoginSuccessState(userProfileModel: userLogin!));
          } else {
            emit(const LoginFailure(
                error: "Tài khoản hoặc mật khẩu không chính xác!"));
          }
        }
      }
    } catch (e) {
      print("Loi bloc: $e");
      emit(const LoginFailure(error: "Error!"));
    }
  }
}
