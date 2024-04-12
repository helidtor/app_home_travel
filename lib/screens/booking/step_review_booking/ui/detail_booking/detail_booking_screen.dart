// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:mobile_home_travel/utils/format/format.dart';
import 'package:mobile_home_travel/models/homestay/general_homestay/homestay_detail_model.dart';
import 'package:mobile_home_travel/screens/booking/step_review_booking/ui/detail_booking/util/room_detail_booking.dart';
import 'package:mobile_home_travel/screens/booking/step_review_booking/ui/detail_booking/util/row_text.dart';
import 'package:mobile_home_travel/themes/app_colors.dart';

class DetailBooking extends StatefulWidget {
  HomestayDetailModel homestayDetailModel;
  DetailBooking({
    super.key,
    required this.homestayDetailModel,
  });

  @override
  State<DetailBooking> createState() => _DetailBookingState();
}

class _DetailBookingState extends State<DetailBooking> {
  late HomestayDetailModel homestayDetailModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homestayDetailModel = widget.homestayDetailModel;
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
                      RowText().richText('Mã đơn',
                          'f7cf26d0-8beb-4021-a053-6b80aef63c15', null),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          children: [
                            Text(
                              homestayDetailModel.name!,
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
                          (homestayDetailModel.checkInTime !=
                                  homestayDetailModel.checkOutTime)
                              ? '${FormatProvider().convertDateTimeBooking(homestayDetailModel.checkInTime.toString())} - ${FormatProvider().convertDateTimeBooking(homestayDetailModel.checkOutTime.toString())}'
                              : FormatProvider().convertDateTimeBooking(
                                  homestayDetailModel.checkInTime.toString()),
                          Icons.calendar_month_outlined),
                      const SizedBox(
                        height: 2,
                      ),
                      RowText().richText(
                        'Tổng số ngày',
                        '1 ngày',
                        Icons.numbers,
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      RowText().richText(
                        'Tổng số phòng',
                        '1 phòng',
                        Icons.door_sliding_outlined,
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      RowText().richText(
                        'Địa chỉ',
                        '${homestayDetailModel.address}, ${homestayDetailModel.street}, ${homestayDetailModel.commune}, ${homestayDetailModel.district}, ${homestayDetailModel.city}',
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
