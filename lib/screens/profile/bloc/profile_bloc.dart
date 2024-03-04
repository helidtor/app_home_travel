import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_home_travel/api/api_provider.dart';
import 'package:mobile_home_travel/screens/profile/bloc/profile_event.dart';
import 'package:mobile_home_travel/screens/profile/bloc/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileStateInitial()) {
    on<ProfileEvent>((event, emit) async {
      await profileBloc(emit, event);
    });
  }

  profileBloc(Emitter<ProfileState> emit, ProfileEvent event) async {
    emit(ProfileStateLoading());
    try {
      if (event is GetProfileEvent) {
        var user = await ApiProvider.getProfile();
        if (user != null) {
          emit(ProfileStateSuccess(userProfileModel: user));
        } else {
          emit(const ProfileStateFailure(error: "Lỗi thông tin"));
        }
      } else if (event is UpdateProfileEvent) {
        var check = await ApiProvider.updateProfile(event.userProfileModel, event.id);
        if (check == true) {
          emit(UpdateProfileSuccess());
        } else {
          emit(const ProfileStateFailure(error: "Lỗi update profile"));
        }
      }
    } catch (e) {
      emit(const ProfileStateFailure(error: "Lỗi"));
    }
  }
}
