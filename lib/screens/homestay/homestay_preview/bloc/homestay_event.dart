import 'package:equatable/equatable.dart';

abstract class HomestayEvent extends Equatable {
  const HomestayEvent();

  @override
  List<Object> get props => [];
}

class GetAllListHomestay extends HomestayEvent {}
