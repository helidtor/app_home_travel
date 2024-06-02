import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_home_travel/api/api_booking.dart';
import 'package:mobile_home_travel/api/api_room.dart';
import 'package:mobile_home_travel/models/booking/create_booking_detail_model.dart';
import 'package:mobile_home_travel/models/booking/booking_homestay_model.dart';
import 'package:mobile_home_travel/models/booking/input_calculate_price_model.dart';
import 'package:mobile_home_travel/models/booking/price_room_model.dart';
import 'package:mobile_home_travel/screens/booking/step_pick_room/bloc/create_booking_event.dart';
import 'package:mobile_home_travel/screens/booking/step_pick_room/bloc/create_booking_state.dart';
import 'package:mobile_home_travel/utils/format/format.dart';
import 'package:mobile_home_travel/utils/shared_preferences_util.dart';
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
        int totalCapacity = 0;
        int totalRoom = 0;
        num totalPriceBooking = 0;
        bool isSuccessAll = false;
        BookingHomestayModel?
            bookingHomestayModel; // return result when success
        CreateBookingDetailModel bookingHomestayDetail =
            CreateBookingDetailModel();
        List<String>? listIdRoomPicked =
            SharedPreferencesUtil.getListIdPicked() ?? [];
        List<InputCalculatePriceModel> listInput = [];
        List<PriceRoomModel> listResultPrice = [];
        if (listIdRoomPicked.isNotEmpty) {
          totalRoom = listIdRoomPicked.length;
          for (var e in listIdRoomPicked) {
            InputCalculatePriceModel inputCalculate =
                InputCalculatePriceModel();
            //tính tổng sức chứa
            var roomPicked = await ApiRoom.getRoomDetail(idRoom: e);
            if (roomPicked != null) {
              totalCapacity += roomPicked.capacity!;
            }
            //thêm input data vào để tính giá các phòng trong khoảng ngày checkin checkout
            inputCalculate.roomId = e;
            inputCalculate.startDate = event.bookingHomestayModel.checkInDate;
            inputCalculate.endDate = event.bookingHomestayModel.checkOutDate;
            listInput.add(inputCalculate);
          }
          if (totalCapacity != 0 && listInput.isNotEmpty) {
            var inputBooking = event.bookingHomestayModel;
            inputBooking.totalCapacity = totalCapacity;
            listResultPrice =
                await ApiBooking.calculatePrice(inputCalculate: listInput);
            if (listResultPrice.isNotEmpty) {
              for (var e in listResultPrice) {
                totalPriceBooking += e.totalPrice!;
                //cộng tổng giá tiền đơn booking
              }
              if (totalPriceBooking != 0) {
                inputBooking.totalPrice = totalPriceBooking;
              }
            }
            //create booking
            var bookingInfor = await ApiBooking.createBooking(
                bookingInput: inputBooking, totalCapacity: totalCapacity);
            if (bookingInfor != null && listResultPrice.isNotEmpty) {
              // print('Đây là list price: $listResultPrice');
              bookingHomestayModel = bookingInfor;
              for (var e in listResultPrice) {
                bookingHomestayDetail.bookingId = bookingInfor.id;
                bookingHomestayDetail.price = e.totalPrice;
                bookingHomestayDetail.roomId = e.bookingDetail!.first.roomId;
                //create booking detail
                var checkCreateBookingDetail =
                    await ApiBooking.createBookingDetail(
                        bookingHomestayDetail: bookingHomestayDetail);
                if (checkCreateBookingDetail) {
                  isSuccessAll = true;
                } else {
                  isSuccessAll = false;
                  emit(const CreateBookingFailure(
                      error: 'Bạn đang có một đơn chờ xác nhận! 401'));
                }
              }
            } else {
              emit(const CreateBookingFailure(
                  error: 'Bạn đang có một đơn chờ xác nhận! 402'));
            }
          } else {
            emit(const CreateBookingFailure(
                error: 'Bạn đang có một đơn chờ xác nhận! 403'));
          }
        } else {
          emit(const CreateBookingFailure(error: 'Bạn chưa chọn phòng!'));
        }
        if (isSuccessAll) {
          emit(CreateBookingSuccess(
              listIdRoom: listIdRoomPicked,
              startDate: event.bookingHomestayModel.checkInDate!,
              endDate: event.bookingHomestayModel.checkOutDate!,
              totalRoom: totalRoom,
              bookingHomestayModel: bookingHomestayModel!));
        }
      } else if (event is CheckListRoom) {
        List<InputCalculatePriceModel> listInput = [];
        List<PriceRoomModel> listResultPrice = [];
        List<num> listPriceRoom = [];
        String idHomestay = SharedPreferencesUtil.getIdHomestay()!;
        String idUser = SharedPreferencesUtil.getIdUserCurrent()!;
        var listRoomEmpty = await ApiRoom.getAllRoomEmptyByDate(
                homeStayId: idHomestay,
                dateCheckIn: event.checkInDate,
                dateCheckOut: event.checkOutDate) ??
            [];
        if (listRoomEmpty.isNotEmpty) {
          for (var e in listRoomEmpty) {
            InputCalculatePriceModel inputCalculate =
                InputCalculatePriceModel();
            //thêm input data vào để tính giá các phòng trong khoảng ngày checkin checkout
            inputCalculate.roomId = e.id;
            inputCalculate.startDate = FormatProvider()
                .convertDateToCalculatePriceRoom(event.checkInDate);
            inputCalculate.endDate = FormatProvider()
                .convertDateToCalculatePriceRoom(event.checkOutDate);
            listInput.add(inputCalculate);
            print('ngày bắt đầu tính: ${event.checkInDate}');
            print('ngày kết thúc tính: ${inputCalculate.startDate}');
          }
          if (listInput.isNotEmpty) {
            print('list input tính price room là: $listInput');
            listResultPrice =
                await ApiBooking.calculatePrice(inputCalculate: listInput);
            if (listResultPrice.isNotEmpty) {
              for (var e in listResultPrice) {
                listPriceRoom.add(e.totalPrice!);
              }
              if (listPriceRoom.isNotEmpty) {
                emit(CheckListRoomSuccess(
                  listRoom: listRoomEmpty,
                  idUser: idUser,
                  listPrice: listPriceRoom,
                ));
              } else {
                emit(CheckListRoomFailure());
              }
            }
          }
        } else {
          emit(CheckListRoomFailure());
        }
      } else {
        emit(const CreateBookingFailure(error: "Lỗi tạo đơn đặt phòng!"));
      }
    } catch (e) {
      print("Loi CreateBooking: $e");
      emit(const CreateBookingFailure(error: "Lỗi tạo đơn đặt phòng"));
    }
  }
}
