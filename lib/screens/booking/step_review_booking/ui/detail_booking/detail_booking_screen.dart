// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:mobile_home_travel/models/booking/booking_detail_model.dart';
import 'package:mobile_home_travel/models/booking/booking_homestay_model.dart';
import 'package:mobile_home_travel/models/homestay/general_homestay/homestay_detail_model.dart';
import 'package:mobile_home_travel/models/homestay/general_homestay/homestay_model.dart';
import 'package:mobile_home_travel/screens/booking/step_review_booking/ui/detail_booking/utils/room_detail_booking.dart';
import 'package:mobile_home_travel/screens/booking/step_review_booking/ui/detail_booking/utils/row_text.dart';
import 'package:mobile_home_travel/screens/homestay/homestay_detail/ui/homestay_detail.dart';
import 'package:mobile_home_travel/themes/app_colors.dart';
import 'package:mobile_home_travel/utils/format/format.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailBooking extends StatefulWidget {
  BookingHomestayModel bookingInfor;
  DetailBooking({
    super.key,
    required this.bookingInfor,
  });

  @override
  State<DetailBooking> createState() => _DetailBookingState();
}

class _DetailBookingState extends State<DetailBooking> {
  late BookingHomestayModel bookingInfor;
  String checkinTime = '';
  String checkoutTime = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bookingInfor = widget.bookingInfor;
    setState(() {
      checkinTime =
          '${FormatProvider().convertTo24HourFormat(bookingInfor.bookingDetails![0].room!.homeStay!.checkInTime.toString())} - ${FormatProvider().convertDate(bookingInfor.checkInDate.toString())}';
      checkoutTime = (bookingInfor.checkInDate !=
              bookingInfor.checkOutDate) //nếu chỉ chọn đặt 1 ngày
          ? '${FormatProvider().convertTo24HourFormat(bookingInfor.bookingDetails![0].room!.homeStay!.checkOutTime.toString())} - ${FormatProvider().convertDate(bookingInfor.checkOutDate.toString())}'
          : '${FormatProvider().convertTo24HourFormat(bookingInfor.bookingDetails![0].room!.homeStay!.checkOutTime.toString())} - ${FormatProvider().convertDate(bookingInfor.checkInDate.toString())}';
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        shadowColor: Colors.grey,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.keyboard_arrow_left,
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Text(
            "Chi tiết đơn",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black.withOpacity(0.8),
              fontSize: 22,
            ),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Container(
                width: screenWidth,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryColor1.withOpacity(0.2),
                      spreadRadius: 0.1,
                      blurRadius: 9,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      RowText().richText(
                          title: 'Mã đơn',
                          content: bookingInfor.id!.substring(0, 13)),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          children: [
                            Text(
                              bookingInfor
                                  .bookingDetails![0].room!.homeStay!.name!,
                              style: const TextStyle(
                                  fontSize: 25,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            GestureDetector(
                              // xem lại thông tin homestay
                              onTap: () async {
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                prefs.setString(
                                    "idHomestay",
                                    bookingInfor
                                        .bookingDetails![0].room!.homeStayId!);
                                // ignore: use_build_context_synchronously
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomeStayDetail(
                                      isFromHome: true,
                                    ),
                                  ),
                                );
                              },
                              child: Icon(
                                Icons.remove_red_eye_outlined,
                                color: AppColors.primaryColor3.withOpacity(0.7),
                                size: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                      RowText().richText(
                          title: 'Thời gian nhận phòng',
                          content: checkinTime,
                          icon: Icons.calendar_month_outlined),
                      const SizedBox(
                        height: 2,
                      ),
                      RowText().richText(
                          title: 'Thời gian trả phòng',
                          content: checkoutTime,
                          icon: Icons.calendar_month_outlined),
                      const SizedBox(
                        height: 2,
                      ),
                      RowText().richText(
                        title: 'Tổng số ngày',
                        content: (bookingInfor.checkInDate !=
                                bookingInfor.checkOutDate)
                            ? '${FormatProvider().countDays(FormatProvider().convertStringToDateTime(checkinTime), FormatProvider().convertStringToDateTime(checkoutTime))} ngày'
                            : '1 ngày',
                        icon: Icons.numbers,
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      RowText().richText(
                        title: 'Tổng số phòng',
                        content: '${bookingInfor.bookingDetails?.length} phòng',
                        icon: Icons.door_sliding_outlined,
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      RowText().richText(
                        title: 'Địa chỉ',
                        content:
                            '${bookingInfor.bookingDetails![0].room!.homeStay!.address}, ${bookingInfor.bookingDetails![0].room!.homeStay!.street}, ${bookingInfor.bookingDetails![0].room!.homeStay!.commune}, ${bookingInfor.bookingDetails![0].room!.homeStay!.district}, ${bookingInfor.bookingDetails![0].room!.homeStay!.city}',
                        icon: Icons.pin_drop_outlined,
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      RowText().richText(
                        title: 'Tổng tiền đơn',
                        content:
                            '${FormatProvider().formatPrice(bookingInfor.totalPrice.toString())} đ',
                        icon: Icons.monetization_on_outlined,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: Text(
                  'Phòng được đặt',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black.withOpacity(0.7),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.topCenter,
              height: screenHeight * 0.5,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    children: List.generate(
                        bookingInfor.bookingDetails!.length,
                        (index) => RoomDetailBooking(
                              bookingDetailModel:
                                  bookingInfor.bookingDetails![index],
                              countDayInWeek: FormatProvider().countNormalDays(
                                  DateTime.parse(bookingInfor.checkInDate!),
                                  DateTime.parse(bookingInfor.checkOutDate!)),
                              countDayWeekend: FormatProvider()
                                  .countWeekendDays(
                                      DateTime.parse(bookingInfor.checkInDate!),
                                      DateTime.parse(
                                          bookingInfor.checkOutDate!)),
                            )),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
