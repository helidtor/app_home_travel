import 'package:equatable/equatable.dart';
import 'package:mobile_home_travel/models/user/login_user_model.dart';
import 'package:mobile_home_travel/models/user/profile_user_model.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

//Chưa đăng nhập
class LoginFirstState extends LoginState {}

class LoginSecondState extends LoginState {
  final UserProfileModel userProfileModel;
  const LoginSecondState({required this.userProfileModel});
  @override
  List<Object> get props => [userProfileModel];
}

class LoginSuccessState extends LoginState {
  final UserProfileModel userProfileModel;
  const LoginSuccessState({required this.userProfileModel});
  @override
  List<Object> get props => [UserProfileModel];
}

class LoginSuccessStateNoSession extends LoginState {
  final UserLoginModel userLoginModel;
  const LoginSuccessStateNoSession({required this.userLoginModel});
  @override
  List<Object> get props => [UserProfileModel];
}

class LoginFailure extends LoginState {
  final String error;

  const LoginFailure({required this.error});

  @override
  List<Object> get props => [error];
}
