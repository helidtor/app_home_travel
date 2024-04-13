// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

abstract class FeedbackEvent extends Equatable {
  const FeedbackEvent();

  @override
  List<Object> get props => [];
}

class GetInforDisplay extends FeedbackEvent {}

class GetFeedBackHomestay extends FeedbackEvent {
  String idHomestay;
  GetFeedBackHomestay({
    required this.idHomestay,
  });
}
