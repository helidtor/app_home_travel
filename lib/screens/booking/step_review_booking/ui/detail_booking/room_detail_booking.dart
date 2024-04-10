import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_home_travel/screens/booking/step_review_booking/ui/detail_booking/widget_detail_booking.dart';
import 'package:mobile_home_travel/themes/app_colors.dart';

class RoomDetailBooking extends StatefulWidget {
  const RoomDetailBooking({super.key});

  @override
  State<RoomDetailBooking> createState() => _RoomDetailBookingState();
}

class _RoomDetailBookingState extends State<RoomDetailBooking> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
      ),
      child: Container(
        height: screenHeight / 6,
        width: screenWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
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
          padding: const EdgeInsets.only(
            left: 15,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      children: [
                        Text(
                          'Phòng Vui Vẻ',
                          style: TextStyle(
                              fontFamily: GoogleFonts.nunito().fontFamily,
                              fontSize: 20,
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
                  WidgetDetailBooking()
                      .richText('Số giường', '2', Icons.bed_outlined),
                  const SizedBox(
                    height: 3,
                  ),
                  WidgetDetailBooking().richText(
                      'Tổng tiền phòng', '1,000,000₫', Icons.bed_outlined)
                ],
              ),
              const SizedBox(
                width: 130,
                child: ExpansionTile(
                    title: Text(
                  'Chi tiết',
                  style: TextStyle(
                      color: AppColors.primaryColor1,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
