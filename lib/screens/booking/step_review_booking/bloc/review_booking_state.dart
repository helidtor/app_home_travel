// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:mobile_home_travel/models/homestay/homestay_detail_model.dart';
import 'package:mobile_home_travel/models/homestay/homestay_model.dart';
import 'package:mobile_home_travel/models/user/profile_user_model.dart';
import 'package:mobile_home_travel/screens/homestay/homestay_detail/ui/homestay_detail.dart';

abstract class ReviewBookingState extends Equatable {
  const ReviewBookingState();

  @override
  List<Object> get props => [];
}

class ReviewBookingInitial extends ReviewBookingState {}

class ReviewBookingLoading extends ReviewBookingState {}

class GetHomestayOfBookingSuccess extends ReviewBookingState {
  HomestayDetailModel homestayModel;
  UserProfileModel touristInfor;
  GetHomestayOfBookingSuccess({
    required this.homestayModel,
    required this.touristInfor,
  });
}

class ReviewBookingFailure extends ReviewBookingState {
  String error;
  ReviewBookingFailure({
    required this.error,
  });
}

class CheckoutSuccess extends ReviewBookingState {
  String urlCheckout;
  CheckoutSuccess({
    required this.urlCheckout,
  });
}

