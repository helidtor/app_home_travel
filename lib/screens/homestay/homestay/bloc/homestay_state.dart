import 'package:equatable/equatable.dart';
import 'package:mobile_home_travel/models/homestay_model.dart';

abstract class HomestayState extends Equatable {
  const HomestayState();

  @override
  List<Object> get props => [];
}

class HomestayInitial extends HomestayState {}

class HomestayLoading extends HomestayState {}

class HomestaySuccess extends HomestayState {
  final List<HomestayModel> list;
  const HomestaySuccess({required this.list});
  @override
  List<Object> get props => [list];
}

class HomestayError extends HomestayState {
  final String error;

  const HomestayError({required this.error});

  @override
  List<Object> get props => [error];
}
