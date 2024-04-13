// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile_home_travel/utils/format/format.dart';
import 'package:mobile_home_travel/models/booking/booking_homestay_model.dart';
import 'package:mobile_home_travel/screens/booking/step_review_booking/ui/detail_booking/util/row_text.dart';
import 'package:mobile_home_travel/screens/booking/step_review_booking/ui/review_booking/review_booking.dart';
import 'package:mobile_home_travel/themes/app_colors.dart';

class PendingHistoryRow extends StatefulWidget {
  BookingHomestayModel bookingHomestayModel;
  PendingHistoryRow({
    super.key,
    required this.bookingHomestayModel,
  });

  @override
  State<PendingHistoryRow> createState() => _PendingHistoryRowState();
}

class _PendingHistoryRowState extends State<PendingHistoryRow> {
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

    return SizedBox(
      height: 170,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 150,
            width: screenWidth * 0.85,
            decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromARGB(253, 255, 255, 255),
                ),
                color: const Color.fromARGB(253, 255, 255, 255),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 0.5,
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  )
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: screenWidth * 0.5,
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RowText().richText(
                          'Mã đơn', bookingHomestayModel.id!, Icons.qr_code),
                      RowText().richText(
                          'Ngày tạo',
                          FormatProvider().convertDateTime(
                              bookingHomestayModel.createdDate.toString()),
                          Icons.date_range_outlined),
                      RowText().richText(
                          'Tổng tiền',
                          '${FormatProvider().formatPrice(bookingHomestayModel.totalPrice.toString())}vnđ',
                          Icons.attach_money_sharp),
                      // Text(
                      //   bookingHomestayModel.id.toString(),
                      //   style: TextStyle(
                      //     overflow: TextOverflow.clip,
                      //     // fontWeight: FontWeight.bold,
                      //     fontSize: 13,
                      //     color: Colors.black.withOpacity(0.8),
                      //   ),
                      // ),
                      // Text(
                      //   FormatProvider().convertDateTime(
                      //       bookingHomestayModel.createdDate.toString()),
                      //   style: TextStyle(
                      //     fontStyle: FontStyle.italic,
                      //     color: Colors.black.withOpacity(0.5),
                      //     fontSize: 14,
                      //   ),
                      // ),
                    ],
                  ),
                ),
                // Text(
                //   '${FormatProvider().formatPrice(bookingHomestayModel.totalPrice.toString())}vnđ',
                //   style: const TextStyle(
                //     color: Color.fromARGB(255, 21, 149, 25),
                //     fontWeight: FontWeight.bold,
                //     fontSize: 14,
                //   ),
                // ),
                const SizedBox(
                  height: 10,
                ),
                Divider(
                  indent: 30,
                  endIndent: 30,
                  color: AppColors.primaryColor3.withOpacity(0.2),
                  height: 1,
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReviewBooking(
                          totalRoom: 1,
                          bookingHomestayModel: bookingHomestayModel,
                          isAllowBack: false,
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      alignment: Alignment.center,
                      height: 25,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor3.withOpacity(0.8),
                        border: Border.all(
                          color: Colors.black.withOpacity(0.4),
                          width: 0.8,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Text(
                        'Tiếp tục đặt',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(200),
                // border:
                //     Border.all(color: AppColors.primaryColor3, width: 1),
              ),
              child: Image.asset(
                'assets/images/waiting_booking.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
