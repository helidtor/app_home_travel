import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_home_travel/api/api_user.dart';
import 'package:mobile_home_travel/screens/profile/bloc/profile_event.dart';
import 'package:mobile_home_travel/screens/profile/bloc/profile_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileStateInitial()) {
    on<ProfileEvent>((event, emit) async {
      await profileBloc(emit, event);
    });
  }

  profileBloc(Emitter<ProfileState> emit, ProfileEvent event) async {
    emit(ProfileStateLoading());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString("id");

    try {
      if (id != null) {
        if (event is GetProfileEvent) {
          var user = await ApiUser.getProfile(id: id);
          if (user != null) {
            emit(ProfileStateSuccess(userProfileModel: user));
          } else {
            emit(const ProfileStateFailure(error: "Lỗi thông tin"));
          }
        } else if (event is UpdateProfileEvent) {
          var check =
              await ApiUser.updateProfile(event.userProfileModel, event.id);
          if (check == true) {
            emit(UpdateProfileSuccess());
          } else {
            emit(const ProfileStateFailure(error: "Lỗi update profile"));
          }
        }
      } else {
        emit(const ProfileStateFailure(error: "Lỗi lấy id"));
      }
    } catch (e) {
      emit(const ProfileStateFailure(error: "Lỗi"));
    }
  }
}
