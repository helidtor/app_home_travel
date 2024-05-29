// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:mobile_home_travel/models/booking/booking_homestay_model.dart';
import 'package:mobile_home_travel/models/homestay/room/room_model.dart';

abstract class CreateBookingState extends Equatable {
  const CreateBookingState();

  @override
  List<Object> get props => [];
}

class CreateBookingInitial extends CreateBookingState {}

class CreateBookingLoading extends CreateBookingState {}

class CreateBookingSuccess extends CreateBookingState {
  BookingHomestayModel bookingHomestayModel;
  int totalRoom;
  String startDate;
  String endDate;
  List<String> listIdRoom;
  CreateBookingSuccess({
    required this.bookingHomestayModel,
    required this.totalRoom,
    required this.startDate,
    required this.endDate,
    required this.listIdRoom,
  });
}

class CreateBookingFailure extends CreateBookingState {
  final String error;

  const CreateBookingFailure({required this.error});
}

class CheckListRoomSuccess extends CreateBookingState {
  final List<RoomModel> listRoom;
  final String idUser;

  const CheckListRoomSuccess({
    required this.listRoom,
    required this.idUser,
  });
}

class CheckListRoomFailure extends CreateBookingState {}
