// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:mobile_home_travel/models/booking/booking_homestay_model.dart';
import 'package:mobile_home_travel/screens/history_booking/ui/history_row.dart';

class ListBooking extends StatefulWidget {
  List<BookingHomestayModel> listBooking;
  ListBooking({
    super.key,
    required this.listBooking,
  });

  @override
  State<ListBooking> createState() => _ListBookingState();
}

class _ListBookingState extends State<ListBooking> {
  List<BookingHomestayModel>? listBooking;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listBooking = widget.listBooking;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 200,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: List.generate(
            listBooking!.length,
            (index) => Padding(
              padding: const EdgeInsets.all(10),
              child: HistoryRow(bookingHomestayModel: listBooking![index]),
            ),
          ),
        ),
      ),
    );
  }
}
