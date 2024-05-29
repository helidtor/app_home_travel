import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_home_travel/api/api_booking.dart';
import 'package:mobile_home_travel/api/api_room.dart';
import 'package:mobile_home_travel/models/booking/create_booking_detail_model.dart';
import 'package:mobile_home_travel/models/booking/booking_homestay_model.dart';
import 'package:mobile_home_travel/models/booking/input_calculate_price_model.dart';
import 'package:mobile_home_travel/models/booking/price_room_model.dart';
import 'package:mobile_home_travel/screens/booking/step_pick_room/bloc/create_booking_event.dart';
import 'package:mobile_home_travel/screens/booking/step_pick_room/bloc/create_booking_state.dart';
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
        InputCalculatePriceModel? inputCalculate = InputCalculatePriceModel();
        List<PriceRoomModel> listResultPrice = [];
        if (listIdRoomPicked.isNotEmpty) {
          totalRoom = listIdRoomPicked.length;
          for (var e in listIdRoomPicked) {
            //tính tổng sức chứa
            var roomPicked = await ApiRoom.getRoomDetail(idRoom: e);
            if (roomPicked != null) {
              totalCapacity += roomPicked.capacity!;
            }
            //thêm input data vào để tính giá các phòng trong khoảng ngày checkin checkout
            inputCalculate.roomId = e;
            print('list nhập Id hiện tại ${inputCalculate.roomId}');
            inputCalculate.startDate = event.bookingHomestayModel.checkInDate;
            inputCalculate.endDate = event.bookingHomestayModel.checkOutDate;
            listInput.add(inputCalculate);
            print('List nhập: $listInput');
          }
          if (totalCapacity != 0 && listInput.isNotEmpty) {
            print('List nhập 2: $listInput');
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
              print('Đây là list price: $listResultPrice');
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
                      error: 'Bạn đang có một đơn chờ xác nhận!'));
                }
              }
            } else {
              emit(const CreateBookingFailure(
                  error: 'Bạn đang có một đơn chờ xác nhận!'));
            }
          } else {
            emit(const CreateBookingFailure(
                error: 'Bạn đang có một đơn chờ xác nhận!'));
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
        String idHomestay = SharedPreferencesUtil.getIdHomestay()!;
        String idUser = SharedPreferencesUtil.getIdUserCurrent()!;
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
        emit(const CreateBookingFailure(error: "Lỗi tạo đơn đặt phòng!"));
      }
    } catch (e) {
      print("Loi CreateBooking: $e");
      emit(const CreateBookingFailure(error: "Lỗi tạo đơn đặt phòng"));
    }
  }
}
