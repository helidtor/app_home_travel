// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:mobile_home_travel/models/booking/booking_homestay_model.dart';

abstract class CreateBookingEvent extends Equatable {
  const CreateBookingEvent();

  @override
  List<Object> get props => [];
}

class CreateBooking extends CreateBookingEvent {
  BookingHomestayModel bookingHomestayModel;
  int quantityNormalDays;
  int quantityWeekendDays;
  CreateBooking({
    required this.bookingHomestayModel,
    required this.quantityNormalDays,
    required this.quantityWeekendDays,
  });
}

class CheckListRoom extends CreateBookingEvent {
  String checkInDate;
  String checkOutDate;
  CheckListRoom({
    required this.checkInDate,
    required this.checkOutDate,
  });
}
