import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_home_travel/api/api_booking.dart';
import 'package:mobile_home_travel/api/api_homestay.dart';
import 'package:mobile_home_travel/api/api_user.dart';
import 'package:mobile_home_travel/screens/booking/step_review_booking/bloc/review_booking_event.dart';
import 'package:mobile_home_travel/screens/booking/step_review_booking/bloc/review_booking_state.dart';
import 'package:mobile_home_travel/utils/shared_preferences_util.dart';
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
        var bookingCreated = await ApiBooking.getListBooking(status: 'PENDINg');
        var userProfile = await ApiUser.getProfile();
        if (bookingCreated != null && userProfile != null) {
          var idHomestay = SharedPreferencesUtil.getIdHomestay();
          if (idHomestay != null) {
            var listPolicies =
                await ApiHomestay.getAllPolicy(homestayId: idHomestay);
            if (listPolicies != null) {
              print('Danh sách policy $listPolicies');
              emit(GetBookingPendingCreatedSuccessWithPolicy(
                  listPolicies: listPolicies,
                  bookingCreated: bookingCreated[0],
                  userProfile: userProfile));
            } else {
              emit(GetBookingPendingCreatedSuccess(
                  bookingCreated: bookingCreated[0], userProfile: userProfile));
            }
          }
        } else {
          emit(ReviewBookingFailure(
              error: 'Lỗi lấy thông tin đơn đặt vừa tạo!'));
        }
      }
      if (event is GetPolicyHomestayFromPending) {
        var listPolicies =
            await ApiHomestay.getAllPolicy(homestayId: event.idHomestay!);
        if (listPolicies != null) {
          print('Danh sách policy $listPolicies');
          emit(GetPolicySuccessFromPending(listPolicies: listPolicies));
        } else {
          emit(GetPolicyFailFromPending());
        }
      } else if (event is CheckoutBookingByCard) {
        String? urlCheckout =
            await ApiBooking.checkoutDepositByCard(idBooking: event.idBooking);
        if (urlCheckout != null) {
          emit(CheckoutSuccessByCard(urlCheckout: urlCheckout));
        } else {
          emit(ReviewBookingFailure(error: 'Lỗi thanh toán VN-PAY!'));
        }
      } else if (event is CheckoutBookingByWallet) {
        bool? isSuccess = await ApiBooking.checkoutDepositByWallet(
            idBooking: event.idBooking);
        if (isSuccess != null) {
          emit(CheckoutSuccessByWallet(noti: 'Thanh toán thành công'));
        } else {
          emit(ReviewBookingFailure(error: 'Lỗi thanh toán bằng ví!'));
        }
      }
    } catch (e) {
      emit(ReviewBookingFailure(error: 'Lỗi $e'));
    }
  }
}
