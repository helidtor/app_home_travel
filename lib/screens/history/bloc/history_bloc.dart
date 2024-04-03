import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_home_travel/api/api_booking.dart';
import 'package:mobile_home_travel/screens/history/bloc/history_event.dart';
import 'package:mobile_home_travel/screens/history/bloc/history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc() : super(HistoryInitial()) {
    // event handler was added
    on<HistoryEvent>((event, emit) async {
      await post(emit, event);
    });
  }
  post(Emitter<HistoryState> emit, HistoryEvent event) async {
    emit(HistoryLoading());
    try {
      if (event is GetHistoryPending) {
        var bookingPending = await ApiBooking.getBookingPending();
        if (bookingPending != null) {
          emit(HistorySuccess(bookingPending: bookingPending));
        } else {
          const HistoryFailure(error: "Lỗi lấy đơn đặt đang chờ thanh toán");
        }
      }
    } catch (e) {
      emit(const HistoryFailure(error: "Lỗi lấy lịch sử đơn đặt"));
    }
  }
}
