// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:mobile_home_travel/models/booking/booking_homestay_model.dart';

abstract class CreateBookingState extends Equatable {
  const CreateBookingState();

  @override
  List<Object> get props => [];
}

class CreateBookingInitial extends CreateBookingState {}

class CreateBookingLoading extends CreateBookingState {}

class CreateBookingSuccess extends CreateBookingState {
  BookingHomestayModel bookingHomestayModel;
  CreateBookingSuccess({
    required this.bookingHomestayModel,
  });
}

class CreateBookingFailure extends CreateBookingState {
  final String error;

  const CreateBookingFailure({required this.error});
}
