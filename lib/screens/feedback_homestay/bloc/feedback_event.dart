// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:mobile_home_travel/models/homestay/feedback/feedback_model.dart';

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

class CreateFeedback extends FeedbackEvent {
  FeedbackModel feedbackModel;
  CreateFeedback({
    required this.feedbackModel,
  });
  
}
