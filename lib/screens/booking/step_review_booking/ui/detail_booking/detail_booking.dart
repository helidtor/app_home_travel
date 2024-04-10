import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_home_travel/format/format.dart';
import 'package:mobile_home_travel/screens/booking/step_review_booking/ui/detail_booking/room_detail_booking.dart';
import 'package:mobile_home_travel/screens/booking/step_review_booking/ui/detail_booking/widget_detail_booking.dart';
import 'package:mobile_home_travel/themes/app_colors.dart';

class DetailBooking extends StatefulWidget {
  const DetailBooking({super.key});

  @override
  State<DetailBooking> createState() => _DetailBookingState();
}

class _DetailBookingState extends State<DetailBooking> {
  bool isAllowBack = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: isAllowBack,
        surfaceTintColor: Colors.white,
        shadowColor: Colors.grey,
        // leading: IconButton(
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        //   icon: const Icon(
        //     Icons.keyboard_arrow_left,
        //   ),
        // ),
        // centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Text(
            "Chi tiết đơn đặt",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black.withOpacity(0.65),
                fontSize: 20,
                fontFamily: GoogleFonts.nunito().fontFamily),
          ),
        ),
        backgroundColor: Colors.white,
        actions: [
          (isAllowBack == false)
              ? IconButton(
                  onPressed: () {
                    // Navigator.pop(context);
                    // Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.close_rounded,
                    color: AppColors.primaryColor3.withOpacity(0.7),
                    size: 27,
                  ),
                )
              : const SizedBox(),
        ],
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
                      WidgetDetailBooking().richText('Mã đơn',
                          'f7cf26d0-8beb-4021-a053-6b80aef63c15', null),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          children: [
                            Text(
                              'Homestay Latana',
                              style: TextStyle(
                                  fontFamily: GoogleFonts.nunito().fontFamily,
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
                      WidgetDetailBooking().richText(
                          'Thời gian',
                          '22/4/2024 - 28/4/2024',
                          Icons.calendar_month_outlined),
                      const SizedBox(
                        height: 2,
                      ),
                      WidgetDetailBooking().richText(
                        'Tổng số ngày',
                        '6 ngày',
                        Icons.numbers,
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      WidgetDetailBooking().richText(
                        'Tổng số phòng',
                        '2 phòng',
                        Icons.door_sliding_outlined,
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      WidgetDetailBooking().richText(
                        'Địa chỉ',
                        'Ngô Quyền, Phường 6, Lâm Đồng, Đà Lạt',
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
