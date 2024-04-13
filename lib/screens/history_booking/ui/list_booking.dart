// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:mobile_home_travel/models/booking/booking_homestay_model.dart';
import 'package:mobile_home_travel/models/user/profile_user_model.dart';
import 'package:mobile_home_travel/screens/history_booking/ui/history_row/cancelled_history_row.dart';
import 'package:mobile_home_travel/screens/history_booking/ui/history_row/deposit_history_row.dart';
import 'package:mobile_home_travel/screens/history_booking/ui/history_row/paid_history_row.dart';
import 'package:mobile_home_travel/screens/history_booking/ui/history_row/pending_history_row.dart';

class ListBooking extends StatefulWidget {
  List<BookingHomestayModel> listBooking;
  UserProfileModel userInfor;
  String typeHistory;
  ListBooking({
    super.key,
    required this.listBooking,
    required this.userInfor,
    required this.typeHistory,
  });

  @override
  State<ListBooking> createState() => _ListBookingState();
}

class _ListBookingState extends State<ListBooking> {
  List<BookingHomestayModel>? listBooking;
  String? typeHistory;
  UserProfileModel? userInfor;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listBooking = widget.listBooking;
    typeHistory = widget.typeHistory;
    userInfor = widget.userInfor;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 200,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 60),
          child: Column(
            children: List.generate(
              listBooking!.length,
              (index) => Padding(
                padding: const EdgeInsets.all(10),
                child: (typeHistory == 'PENDING')
                    ? PendingHistoryRow(
                        bookingHomestayModel: listBooking![index])
                    : (typeHistory == 'DEPOSIT')
                        ? DepositHistoryRow(
                            userInfor: userInfor!,
                            bookingHomestayModel: listBooking![index])
                        : (typeHistory == 'PAID')
                            ? PaidHistoryRow(
                                bookingHomestayModel: listBooking![index])
                            : (typeHistory == 'CANCELLED')
                                ? CancelledHistoryRow(
                                    bookingHomestayModel: listBooking![index])
                                : const SizedBox(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
