import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_home_travel/api/api_booking.dart';
import 'package:mobile_home_travel/api/api_user.dart';
import 'package:mobile_home_travel/screens/history_booking/bloc/history_event.dart';
import 'package:mobile_home_travel/screens/history_booking/bloc/history_state.dart';
import 'package:mobile_home_travel/utils/shared_preferences_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        var touristInfor =
            await ApiUser.getProfile(); //lấy thông tin user để thanh toán
        print('Thông tin user khi chuyển tab history: $touristInfor');
        var listBooking;
        switch (event.status) {
          case 'PENDING':
            listBooking = await ApiBooking.getListBooking(status: 'PENDING');
          case 'UPCOMING':
            listBooking = await ApiBooking.getListBooking(
                status: 'DEPOSIT', status2: 'PAID');
          case 'ONGOING':
            listBooking = await ApiBooking.getListBooking(
                status: 'DEPOSIT', status2: 'PAID');
          case 'COMPLETED':
            listBooking = await ApiBooking.getListBooking(status: 'PAID');
          case 'CANCELLED':
            listBooking = await ApiBooking.getListBooking(status: 'CANCELLED');
          case 'OVERDUE':
            listBooking =
                await ApiBooking.getListBooking(status: 'PAYMENT SETTLEMENT');
          case 'REFUND':
            listBooking = await ApiBooking.getListBooking(status: 'REFUND');
          default:
            listBooking = await ApiBooking.getListBooking(status: 'PENDING');
        }
        // print('Lấy list booking trong bloc: $listBooking');
        if (listBooking != null && touristInfor != null) {
          emit(GetHistorySuccess(
              listBooking: listBooking,
              type: event.status,
              touristInfor: touristInfor));
        } else {
          emit(ListBookingEmpty(type: event.status));
        }
      }
    } catch (e) {
      emit(const HistoryFailure(error: "Lỗi hiển thị lịch sử đơn đặt!"));
    }
  }
}
