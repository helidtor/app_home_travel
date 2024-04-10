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
        double totalNormalPrice = 0;
        double totalWeekendPrice = 0;
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
            //cộng dồn giá dựa trên list id phòng được chọn
            var roomPicked = await ApiRoom.getRoomDetail(idRoom: e);
            if (roomPicked != null) {
              totalNormalPrice += roomPicked.price!;
              totalCapacity += roomPicked.capacity!;
              if (roomPicked.weekendPrice != null) {
                totalWeekendPrice += roomPicked.weekendPrice!;
              }
            }
          }
          if (totalNormalPrice != 0 && totalCapacity != 0) {
            var inputBooking = event.bookingHomestayModel;
            inputBooking.totalPrice =
                totalNormalPrice * event.quantityNormalDays +
                    (totalWeekendPrice *
                        event.quantityWeekendDays); //giá tổng nhân với số ngày
            //create booking
            var bookingInfor = await ApiBooking.createBooking(
                bookingInput: inputBooking, totalCapacity: totalCapacity);
            if (bookingInfor != null) {
              bookingHomestayModel = bookingInfor;
              for (var e in listIdRoomPicked) {
                bookingHomestayDetail.bookingId = bookingInfor.id;
                bookingHomestayDetail.roomId = e;
                var roomPicked = await ApiRoom.getRoomDetail(idRoom: e);
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
            } else {
              emit(const CreateBookingFailure(
                  error: 'Lỗi tạo đơn đặt phòng (7.7)'));
            }
          }
        } else {
          emit(const CreateBookingFailure(error: 'Bạn chưa chọn phòng!'));
        }
        if (isSuccessAll) {
          emit(CreateBookingSuccess(
              bookingHomestayModel: bookingHomestayModel!));
        }
      } else if (event is CheckListRoom) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String idHomestay = prefs.getString("idHomestay")!;
        String idUser = prefs.getString("idUserCurrent")!;
        var listRoomEmpty = await ApiRoom.getAllRoomEmptyByDate(
                homeStayId: idHomestay,
                dateCheckIn: event.checkInDate,
                dateCheckOut: event.checkOutDate) ??
            [];
        if (listRoomEmpty.isNotEmpty) {
          emit(CheckListRoomSuccess(listRoom: listRoomEmpty, idUser: idUser));
        } else {
          emit(CheckListRoomFailure());
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
