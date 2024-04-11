// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:mobile_home_travel/format/format.dart';
import 'package:mobile_home_travel/models/booking/booking_homestay_model.dart';
import 'package:mobile_home_travel/screens/booking/step_review_booking/ui/review_booking/checkout_booking.dart';
import 'package:mobile_home_travel/screens/booking/step_review_booking/ui/review_booking/review_booking.dart';

class HistoryRow extends StatefulWidget {
  BookingHomestayModel bookingHomestayModel;
  HistoryRow({
    super.key,
    required this.bookingHomestayModel,
  });

  @override
  State<HistoryRow> createState() => _HistoryRowState();
}

class _HistoryRowState extends State<HistoryRow> {
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

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ReviewBooking(
                    totalRoom: 0,
                    bookingHomestayModel: bookingHomestayModel,
                    isAllowBack: true,
                  )),
        );
      },
      child: Container(
        width: screenWidth,
        child: Row(
          children: [
            Container(
              width: 35,
              height: 35,
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
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              width: screenWidth * 0.6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    bookingHomestayModel.id.toString(),
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black.withOpacity(0.8),
                    ),
                  ),
                  Text(
                    FormatProvider().convertDateTime(
                        bookingHomestayModel.createdDate.toString()),
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.black.withOpacity(0.5),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              '${FormatProvider().formatPrice(bookingHomestayModel.totalPrice.toString())}vnđ',
              style: const TextStyle(
                color: Color.fromARGB(255, 21, 149, 25),
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            )
          ],
        ),
      ),
    );
  }
}
