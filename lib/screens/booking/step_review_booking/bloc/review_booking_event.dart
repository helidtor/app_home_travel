// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:mobile_home_travel/models/homestay/general_homestay/homestay_model.dart';

abstract class ReviewBookingEvent extends Equatable {
  const ReviewBookingEvent();

  @override
  List<Object> get props => [];
}

class GetBookingPendingCreated extends ReviewBookingEvent {
  String startDate;
  String endDate;
  List<String> listIdRoom;
  GetBookingPendingCreated(
    this.startDate,
    this.endDate,
    this.listIdRoom,
  );
}

class GetPolicyHomestayFromPendingHistory extends ReviewBookingEvent {
  bool isFromPendingHistory;
  String? idHomestay;
  String startDate;
  String endDate;
  List<String> listIdRoom;
  GetPolicyHomestayFromPendingHistory(
    this.isFromPendingHistory,
    this.idHomestay,
    this.startDate,
    this.endDate,
    this.listIdRoom,
  );
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
