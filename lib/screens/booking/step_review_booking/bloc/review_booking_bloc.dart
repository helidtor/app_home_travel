import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_home_travel/api/api_booking.dart';
import 'package:mobile_home_travel/api/api_homestay.dart';
import 'package:mobile_home_travel/api/api_user.dart';
import 'package:mobile_home_travel/screens/booking/step_review_booking/bloc/review_booking_event.dart';
import 'package:mobile_home_travel/screens/booking/step_review_booking/bloc/review_booking_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReviewBookingBloc extends Bloc<ReviewBookingEvent, ReviewBookingState> {
  ReviewBookingBloc() : super(ReviewBookingInitial()) {
    // event handler was added
    on<ReviewBookingEvent>((event, emit) async {
      await post(emit, event);
    });
  }

  post(Emitter<ReviewBookingState> emit, ReviewBookingEvent event) async {
    emit(ReviewBookingLoading());
    try {
      if (event is GetBookingPendingCreated) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String idTourist = prefs.getString("idUserCurrent")!;

        var bookingCreated = await ApiBooking.getListBooking(status: 'PENDINg');
        var userProfile = await ApiUser.getProfile(id: idTourist);
        if (bookingCreated != null && userProfile != null) {
          emit(GetBookingPendingCreatedSuccess(
              bookingCreated: bookingCreated[0], userProfile: userProfile));
        } else {
          emit(ReviewBookingFailure(
              error: 'Lỗi lấy thông tin đơn booking vừa tạo'));
        }
      } else if (event is CheckoutBookingByCard) {
        String? urlCheckout =
            await ApiBooking.checkoutDepositByCard(idBooking: event.idBooking);
        if (urlCheckout != null) {
          emit(CheckoutSuccessByCard(urlCheckout: urlCheckout));
        } else {
          emit(ReviewBookingFailure(error: 'Lỗi thanh toán bằng thẻ'));
        }
      } else if (event is CheckoutBookingByWallet) {
        bool? isSuccess = await ApiBooking.checkoutDepositByWallet(
            idBooking: event.idBooking);
        if (isSuccess != null) {
          emit(CheckoutSuccessByWallet(noti: 'Thanh toán thành công'));
        } else {
          emit(ReviewBookingFailure(error: 'Lỗi thanh toán bằng ví'));
        }
      }
    } catch (e) {
      emit(ReviewBookingFailure(error: 'Lỗi $e'));
    }
  }
}
