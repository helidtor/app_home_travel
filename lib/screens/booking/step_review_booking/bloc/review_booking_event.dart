// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:mobile_home_travel/models/homestay/homestay_model.dart';

abstract class ReviewBookingEvent extends Equatable {
  const ReviewBookingEvent();

  @override
  List<Object> get props => [];
}

class GetHomestayOfBooking extends ReviewBookingEvent {
  const GetHomestayOfBooking();
}

class CheckoutBookingByCard extends ReviewBookingEvent {
  String idBooking;
  CheckoutBookingByCard({
    required this.idBooking,
  });
}

class CheckoutBookingByWallet extends ReviewBookingEvent {
  String idBooking;
  CheckoutBookingByWallet({
    required this.idBooking,
  });
}