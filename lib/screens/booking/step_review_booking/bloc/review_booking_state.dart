// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:mobile_home_travel/models/booking/booking_detail_model.dart';
import 'package:mobile_home_travel/models/booking/booking_homestay_model.dart';
import 'package:mobile_home_travel/models/homestay/general_homestay/homestay_detail_model.dart';
import 'package:mobile_home_travel/models/homestay/general_homestay/homestay_model.dart';
import 'package:mobile_home_travel/models/homestay/policy/homestay_policy_selected_model.dart';
import 'package:mobile_home_travel/models/homestay/policy/policy_title_model.dart';
import 'package:mobile_home_travel/models/user/profile_user_model.dart';
import 'package:mobile_home_travel/screens/homestay/homestay_detail/ui/homestay_detail.dart';

abstract class ReviewBookingState extends Equatable {
  const ReviewBookingState();

  @override
  List<Object> get props => [];
}

class ReviewBookingInitial extends ReviewBookingState {}

class ReviewBookingLoading extends ReviewBookingState {}

class GetBookingPendingCreatedSuccessWithPolicy extends ReviewBookingState {
  BookingHomestayModel bookingCreated;
  UserProfileModel userProfile;
  List<HomestayPolicySelectedModel> listPolicies;
  GetBookingPendingCreatedSuccessWithPolicy({
    required this.bookingCreated,
    required this.userProfile,
    required this.listPolicies,
  });
}

class GetPolicySuccessFromPending extends ReviewBookingState {
  List<HomestayPolicySelectedModel> listPolicies;
  GetPolicySuccessFromPending({
    required this.listPolicies,
  });
}

class GetPolicyFailFromPending extends ReviewBookingState {}

class GetBookingPendingCreatedSuccess extends ReviewBookingState {
  BookingHomestayModel bookingCreated;
  UserProfileModel userProfile;
  GetBookingPendingCreatedSuccess({
    required this.bookingCreated,
    required this.userProfile,
  });
}

class ReviewBookingFailure extends ReviewBookingState {
  String error;
  ReviewBookingFailure({
    required this.error,
  });
}

class CheckoutSuccessByCard extends ReviewBookingState {
  String urlCheckout;
  CheckoutSuccessByCard({
    required this.urlCheckout,
  });
}

class CheckoutSuccessByWallet extends ReviewBookingState {
  String noti;
  CheckoutSuccessByWallet({
    required this.noti,
  });
}
