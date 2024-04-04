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
      if (event is GetHomestayOfBooking) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String idHomestay = prefs.getString("idHomestay")!;
        String idTourist = prefs.getString("idUserCurrent")!;

        var homestayModel =
            await ApiHomestay.getDetailHomestay(idHomestay: idHomestay);
        var touristInfor = await ApiUser.getProfile(id: idTourist);
        if (homestayModel != null && touristInfor != null) {
          emit(GetHomestayOfBookingSuccess(
              homestayModel: homestayModel, touristInfor: touristInfor));
        } else {
          emit(ReviewBookingFailure(
              error: 'Lỗi lấy chi tiết homestay và thông tin khách'));
        }
      } else if (event is CheckoutBookingByCard) {
        String? urlCheckout =
            await ApiBooking.checkoutByCard(idBooking: event.idBooking);
        if (urlCheckout != null) {
          emit(CheckoutSuccess(urlCheckout: urlCheckout));
        } else {
          emit(ReviewBookingFailure(error: 'Lỗi thanh toán bằng thẻ'));
        }
      } else if (event is CheckoutBookingByWallet) {
        String? urlCheckout =
            await ApiBooking.checkoutByCard(idBooking: event.idBooking);
        if (urlCheckout != null) {
          emit(CheckoutSuccess(urlCheckout: urlCheckout));
        } else {
          emit(ReviewBookingFailure(error: 'Lỗi thanh toán bằng ví'));
        }
      }
    } catch (e) {
      emit(ReviewBookingFailure(error: 'Lỗi $e'));
    }
  }
}
