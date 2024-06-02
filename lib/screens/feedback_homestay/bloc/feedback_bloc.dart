import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_home_travel/api/api_booking.dart';
import 'package:mobile_home_travel/api/api_homestay.dart';
import 'package:mobile_home_travel/screens/feedback_homestay/bloc/feedback_event.dart';
import 'package:mobile_home_travel/screens/feedback_homestay/bloc/feedback_state.dart';

class FeedbackBloc extends Bloc<FeedbackEvent, FeedbackState> {
  FeedbackBloc() : super(FeedbackInitial()) {
    // event handler was added
    on<FeedbackEvent>((event, emit) async {
      await post(emit, event);
    });
  }

  post(Emitter<FeedbackState> emit, FeedbackEvent event) async {
    emit(FeedbackLoading());
    try {
      if (event is GetFeedBackHomestay) {
        var listFeedback = await ApiHomestay.getFeedbackByIdHomeStay(
            idHomestay: event.idHomestay);
        if (listFeedback != null) {
          emit(GetFeedbackSuccess(listFeedback: listFeedback));
        } else {
          emit(GetFeedbackFailure(error: 'Không có đánh giá!'));
        }
      } else if (event is CreateFeedback) {
        var checkCreate = await ApiHomestay.createFeedbackHomestay(
            feedbackModel: event.feedbackModel);
        if (checkCreate == true) {
          emit(CreateFeedbackSuccess());
        } else {
          emit(CreateFeedbackFailure());
        }
      }
    } catch (e) {
      emit(GetFeedbackFailure(error: 'Lỗi chi tiết đánh giá!'));
    }
  }
}
