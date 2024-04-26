import 'package:mobile_home_travel/models/booking/booking_homestay_model.dart';
import 'package:mobile_home_travel/utils/format/format.dart';

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
    String checkinTime =
        '${FormatProvider().convertTo24HourFormat(bookingHomestayModel.bookingDetails![0].room!.homeStay!.checkInTime.toString())} - ${FormatProvider().convertDate(bookingHomestayModel.checkInDate.toString())}';
    String checkoutTime = (bookingHomestayModel.checkInDate !=
            bookingHomestayModel.checkOutDate) //nếu chỉ chọn đặt 1 ngày
        ? '${FormatProvider().convertTo24HourFormat(bookingHomestayModel.bookingDetails![0].room!.homeStay!.checkOutTime.toString())} - ${FormatProvider().convertDate(bookingHomestayModel.checkOutDate.toString())}'
        : '${FormatProvider().convertTo24HourFormat(bookingHomestayModel.bookingDetails![0].room!.homeStay!.checkOutTime.toString())} - ${FormatProvider().convertDate(bookingHomestayModel.checkInDate.toString())}';
    //kiểm tra xem ngày hiện tại có nằm trong khoảng ngày checkin - checkout không
    if ((DateTime.now().isAfter(
              FormatProvider().convertStringToDateTime(checkinTime),
            ) &&
            DateTime.now().isBefore(
              FormatProvider().convertStringToDateTime(checkoutTime),
            )) ||
        DateTime.now().isAtSameMomentAs(
          FormatProvider().convertStringToDateTime(checkinTime),
        )) {
      return true;
    } else {
      return false;
    }
  }

  bool isCompleteDate(BookingHomestayModel bookingHomestayModel) {
    String checkoutTime = (bookingHomestayModel.checkInDate !=
            bookingHomestayModel.checkOutDate) //nếu chỉ chọn đặt 1 ngày
        ? '${FormatProvider().convertTo24HourFormat(bookingHomestayModel.bookingDetails![0].room!.homeStay!.checkOutTime.toString())} - ${FormatProvider().convertDate(bookingHomestayModel.checkOutDate.toString())}'
        : '${FormatProvider().convertTo24HourFormat(bookingHomestayModel.bookingDetails![0].room!.homeStay!.checkOutTime.toString())} - ${FormatProvider().convertDate(bookingHomestayModel.checkInDate.toString())}';
    //kiểm tra xem ngày hiện tại có nằm trong khoảng ngày checkin - checkout không
    if (DateTime.now()
            .isAfter(FormatProvider().convertStringToDateTime(checkoutTime)) ||
        DateTime.now().isAtSameMomentAs(
          FormatProvider().convertStringToDateTime(checkoutTime),
        )) {
      return true;
    } else {
      return false;
    }
  }
}
