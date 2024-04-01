import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_home_travel/api/api_booking.dart';
import 'package:mobile_home_travel/api/api_room.dart';
import 'package:mobile_home_travel/models/booking/booking_detail_model.dart';
import 'package:mobile_home_travel/models/booking/booking_homestay_model.dart';
import 'package:mobile_home_travel/screens/booking/step_pick_room/bloc/create_booking_event.dart';
import 'package:mobile_home_travel/screens/booking/step_pick_room/bloc/create_booking_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateBookingBloc extends Bloc<CreateBookingEvent, CreateBookingState> {
  CreateBookingBloc() : super(CreateBookingInitial()) {
    // event handler was added
    on<CreateBookingEvent>((event, emit) async {
      await post(emit, event);
    });
  }

  post(Emitter<CreateBookingState> emit, CreateBookingEvent event) async {
    emit(CreateBookingLoading());
    try {
      if (event is CreateBooking) {
        double totalPrice = 0;
        int totalCapacity = 0;
        bool isSuccessAll = false;
        BookingHomestayModel?
            bookingHomestayModel; // return result when success
        BookingHomestayDetail bookingHomestayDetail = BookingHomestayDetail();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        List<String>? listIdRoomPicked =
            prefs.getStringList('listIdPicked') ?? [];
        if (listIdRoomPicked.isNotEmpty) {
          for (var e in listIdRoomPicked) {
            var roomPicked = await ApiRoom.getroomDetail(idRoom: e);
            if (roomPicked != null) {
              totalPrice += roomPicked.price!;
              totalCapacity += roomPicked.capacity!;
            }
          }
          if (totalPrice != 0 && totalCapacity != 0) {
            var inputBooking = event.bookingHomestayModel;
            inputBooking.totalPrice = totalPrice;
            //create booking
            var bookingInfor = await ApiBooking.createBooking(
                bookingInput: inputBooking, totalCapacity: totalCapacity);
            if (bookingInfor != null) {
              bookingHomestayModel = bookingInfor;
              for (var e in listIdRoomPicked) {
                bookingHomestayDetail.bookingId = bookingInfor.id;
                bookingHomestayDetail.roomId = e;
                var roomPicked = await ApiRoom.getroomDetail(idRoom: e);
                if (roomPicked != null) {
                  bookingHomestayDetail.price = roomPicked.price!;
                }
                //create booking detail
                var checkCreateBookingDetail =
                    await ApiBooking.createBookingDetail(
                        bookingHomestayDetail: bookingHomestayDetail);
                if (checkCreateBookingDetail) {
                  isSuccessAll = true;
                } else {
                  isSuccessAll = false;
                  emit(const CreateBookingFailure(
                      error: 'Lỗi tạo đơn đặt phòng (7.7)'));
                }
              }
            }
          }
        }
        if (isSuccessAll) {
          emit(CreateBookingSuccess(
              bookingHomestayModel: bookingHomestayModel!));
        }
      } else {
        emit(const CreateBookingFailure(error: "Lỗi tạo đơn đặt phòng"));
      }
    } catch (e) {
      print("Loi CreateBooking: $e");
      emit(const CreateBookingFailure(error: "Lỗi đơn đặt phòng"));
    }
  }
}
