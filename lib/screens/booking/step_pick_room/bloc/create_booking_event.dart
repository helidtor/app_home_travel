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
  CreateBooking({
    required this.bookingHomestayModel,
  });
}
