import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_home_travel/api/api_booking.dart';
import 'package:mobile_home_travel/screens/history_booking/bloc/history_event.dart';
import 'package:mobile_home_travel/screens/history_booking/bloc/history_state.dart';

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
      if (event is GetListBooking) {
        var listBooking = await ApiBooking.getListBooking(status: event.status);
        // print('Lấy list booking trong bloc: $listBooking');
        if (listBooking != null) {
          emit(GetHistorySuccess(listBooking: listBooking, type: event.status));
        } else {
          emit(ListBookingEmpty(type: event.status));
        }
      }
    } catch (e) {
      emit(const HistoryFailure(error: "Lỗi lấy lịch sử đơn đặt"));
    }
  }
}
