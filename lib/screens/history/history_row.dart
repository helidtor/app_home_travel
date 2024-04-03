// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:mobile_home_travel/format/format.dart';
import 'package:mobile_home_travel/models/booking/booking_homestay_model.dart';

class HistoryRow extends StatefulWidget {
  BookingHomestayModel bookingHomestayModel;
  HistoryRow({
    Key? key,
    required this.bookingHomestayModel,
  }) : super(key: key);

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

    return Container(
      width: screenWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
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
                  'assets/images/PAID_WITH_CASH.png',
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
                        fontFamily: GoogleFonts.nunito().fontFamily,
                      ),
                    ),
                    Text(
                      FormatProvider().convertDate(
                          bookingHomestayModel.createdDate.toString()),
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.black.withOpacity(0.5),
                        fontSize: 12,
                        fontFamily: GoogleFonts.nunito().fontFamily,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '${FormatProvider().formatPrice(bookingHomestayModel.totalPrice.toString())}vnđ',
                style: TextStyle(
                  color: const Color.fromARGB(255, 21, 149, 25),
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  fontFamily: GoogleFonts.nunito().fontFamily,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
