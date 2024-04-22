import 'package:mobile_home_travel/models/booking/booking_homestay_model.dart';

class checkDateProvider {
  bool isUpcomingDate(BookingHomestayModel bookingHomestayModel) {
    //kiểm tra xem ngày hiện tại có trước ngày checkin không
    if (DateTime.now()
        .isBefore(DateTime.parse(bookingHomestayModel.checkInDate!))) {
      return true;
    } else {
      return false;
    }
  }

  bool isOngoingDate(BookingHomestayModel bookingHomestayModel) {
    //kiểm tra xem ngày hiện tại có nằm trong khoảng ngày checkin - checkout không
    if ((DateTime.now().isAfter(
              DateTime.parse(bookingHomestayModel.checkInDate!),
            ) &&
            DateTime.now().isBefore(
              DateTime.parse(bookingHomestayModel.checkOutDate!),
            )) ||
        DateTime.now().isAtSameMomentAs(
          DateTime.parse(bookingHomestayModel.checkInDate!),
        ) ||
        DateTime.now().isAtSameMomentAs(
          DateTime.parse(bookingHomestayModel.checkOutDate!),
        )) {
      return true;
    } else {
      return false;
    }
  }

  bool isCompleteDate(BookingHomestayModel bookingHomestayModel) {
    //kiểm tra xem ngày hiện tại có trước ngày checkin không
    if (DateTime.now()
        .isAfter(DateTime.parse(bookingHomestayModel.checkOutDate!))) {
      return true;
    } else {
      return false;
    }
  }
}
