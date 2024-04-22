// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:mobile_home_travel/models/homestay/feedback/feedback_model.dart';

abstract class FeedbackState extends Equatable {
  const FeedbackState();

  @override
  List<Object> get props => [];
}

class FeedbackInitial extends FeedbackState {}

class FeedbackLoading extends FeedbackState {}

class GetFeedbackSuccess extends FeedbackState {
  List<FeedbackModel> listFeedback;
  GetFeedbackSuccess({
    required this.listFeedback,
  });
}

class GetFeedbackFailure extends FeedbackState {
  String error;
  GetFeedbackFailure({
    required this.error,
  });
}

class CreateFeedbackSuccess extends FeedbackState {}

class CreateFeedbackFailure extends FeedbackState {}
