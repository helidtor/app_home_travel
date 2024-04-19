// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:mobile_home_travel/models/booking/booking_detail_model.dart';
import 'package:mobile_home_travel/models/booking/booking_homestay_model.dart';
import 'package:mobile_home_travel/models/homestay/general_homestay/homestay_detail_model.dart';
import 'package:mobile_home_travel/models/homestay/general_homestay/homestay_model.dart';
import 'package:mobile_home_travel/screens/booking/step_review_booking/ui/detail_booking/util/room_detail_booking.dart';
import 'package:mobile_home_travel/screens/booking/step_review_booking/ui/detail_booking/util/row_text.dart';
import 'package:mobile_home_travel/themes/app_colors.dart';
import 'package:mobile_home_travel/utils/format/format.dart';

class DetailBooking extends StatefulWidget {
  BookingHomestayModel bookingHomestayModel;
  DetailBooking({
    super.key,
    required this.bookingHomestayModel,
  });

  @override
  State<DetailBooking> createState() => _DetailBookingState();
}

class _DetailBookingState extends State<DetailBooking> {
  late BookingHomestayModel bookingHomestayModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bookingHomestayModel = widget.bookingHomestayModel;
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
            "Chi tiết đơn đặt",
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
                height: screenHeight / 4,
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
                      RowText().richText(
                          'Mã đơn', '${bookingHomestayModel.id}', null),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          children: [
                            Text(
                              bookingHomestayModel
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
                              onTap: () {},
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
                          'Thời gian',
                          (bookingHomestayModel.checkInDate !=
                                  bookingHomestayModel.checkOutDate)
                              ? '${FormatProvider().convertDateTimeBooking(bookingHomestayModel.checkInDate.toString())} - ${FormatProvider().convertDateTimeBooking(bookingHomestayModel.checkOutDate.toString())}'
                              : FormatProvider().convertDateTimeBooking(
                                  bookingHomestayModel.checkInDate.toString()),
                          Icons.calendar_month_outlined),
                      const SizedBox(
                        height: 2,
                      ),
                      RowText().richText(
                        'Tổng số ngày',
                        (bookingHomestayModel.checkInDate !=
                                bookingHomestayModel.checkOutDate)
                            ? '${FormatProvider().countDays(DateTime.parse(bookingHomestayModel.checkInDate!), DateTime.parse(bookingHomestayModel.checkOutDate!))} ngày'
                            : '1 ngày',
                        Icons.numbers,
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      RowText().richText(
                        'Tổng số phòng',
                        '${bookingHomestayModel.bookingDetails?.length} phòng',
                        Icons.door_sliding_outlined,
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      RowText().richText(
                        'Địa chỉ',
                        '${bookingHomestayModel.bookingDetails![0].room!.homeStay!.address}, ${bookingHomestayModel.bookingDetails![0].room!.homeStay!.street}, ${bookingHomestayModel.bookingDetails![0].room!.homeStay!.commune}, ${bookingHomestayModel.bookingDetails![0].room!.homeStay!.district}, ${bookingHomestayModel.bookingDetails![0].room!.homeStay!.city}',
                        Icons.pin_drop_outlined,
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const RoomDetailBooking(),
          ],
        ),
      ),
    );
  }
}
