// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:mobile_home_travel/models/homestay/general_homestay/homestay_model.dart';

abstract class HomestayState extends Equatable {
  const HomestayState();

  @override
  List<Object> get props => [];
}

class HomestayInitial extends HomestayState {}

class HomestayLoading extends HomestayState {}

class HomestaySuccess extends HomestayState {
  final List<HomestayModel> listRating;
  final List<HomestayModel> listNew;
  const HomestaySuccess({
    required this.listRating,
    required this.listNew,
  });
}

class HomestayError extends HomestayState {
  final String error;

  const HomestayError({required this.error});

  @override
  List<Object> get props => [error];
}
