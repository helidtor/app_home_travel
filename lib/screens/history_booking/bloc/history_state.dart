// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:mobile_home_travel/models/booking/booking_homestay_model.dart';
import 'package:mobile_home_travel/models/homestay/room/room_model.dart';
import 'package:mobile_home_travel/models/user/profile_user_model.dart';
import 'package:mobile_home_travel/models/wallet/transaction_model.dart';
import 'package:mobile_home_travel/models/wallet/wallet_model.dart';

abstract class HistoryState extends Equatable {
  const HistoryState();

  @override
  List<Object> get props => [];
}

class HistoryInitial extends HistoryState {}

class HistoryLoading extends HistoryState {}

class GetHistorySuccess extends HistoryState {
  List<BookingHomestayModel> listBooking;
  UserProfileModel touristInfor;
  String type;
  GetHistorySuccess({
    required this.listBooking,
    required this.touristInfor,
    required this.type,
  });
}

class HistoryFailure extends HistoryState {
  final String error;

  const HistoryFailure({required this.error});
}

class ListBookingEmpty extends HistoryState {
  String type;
  ListBookingEmpty({
    required this.type,
  });
}
