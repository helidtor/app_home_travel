// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile_home_travel/models/user/profile_user_model.dart';
import 'package:mobile_home_travel/utils/format/format.dart';
import 'package:mobile_home_travel/models/booking/booking_homestay_model.dart';
import 'package:mobile_home_travel/screens/booking/step_review_booking/ui/detail_booking/utils/row_text.dart';
import 'package:mobile_home_travel/screens/booking/step_review_booking/ui/review_booking/review_booking.dart';
import 'package:mobile_home_travel/themes/app_colors.dart';

class CancelledHistoryRow extends StatefulWidget {
  BookingHomestayModel bookingHomestayModel;
  UserProfileModel userInfor;
  CancelledHistoryRow({
    super.key,
    required this.userInfor,
    required this.bookingHomestayModel,
  });

  @override
  State<CancelledHistoryRow> createState() => _CancelledHistoryRowState();
}

class _CancelledHistoryRowState extends State<CancelledHistoryRow> {
  late BookingHomestayModel bookingHomestayModel;
  UserProfileModel? userInfor;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bookingHomestayModel = widget.bookingHomestayModel;
    userInfor = widget.userInfor;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 200,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: 175,
              width: screenWidth * 0.8,
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
                    width: screenWidth * 0.7,
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RowText().richText(
                            title: 'Mã đơn',
                            content: bookingHomestayModel.id!.substring(0, 13),
                            icon: Icons.qr_code),
                        RowText().richText(
                            title: 'Thời gian tạo',
                            content: FormatProvider().convertDateTime(
                                bookingHomestayModel.createdDate.toString()),
                            icon: Icons.date_range_outlined),
                        RowText().richText(
                            title: 'Thời gian ở',
                            content: (bookingHomestayModel.checkInDate ==
                                    bookingHomestayModel.checkOutDate)
                                ? '${FormatProvider().convertDate(bookingHomestayModel.checkInDate.toString())} (1 ngày)'
                                : '${FormatProvider().convertDate(bookingHomestayModel.checkInDate.toString())} - ${FormatProvider().convertDate(bookingHomestayModel.checkOutDate.toString())}',
                            icon: Icons.date_range_outlined),
                        RowText().richText(
                            title: 'Tổng tiền',
                            content:
                                '${FormatProvider().formatPrice(bookingHomestayModel.totalPrice.toString())}vnđ',
                            icon: Icons.attach_money_sharp),
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
                            isFromPending: false,
                            userProfileModel: userInfor,
                            bookingHomestayModel: bookingHomestayModel,
                            isAllowBack: true,
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
                          color: AppColors.white,
                          border: Border.all(
                            color: Colors.black.withOpacity(0.4),
                            width: 0.8,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          'Xem chi tiết',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black.withOpacity(0.7),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
            Positioned(
              top: 0,
              child: Container(
                width: 55,
                height: 55,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(300)),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: (bookingHomestayModel.bookingDetails![0].room!
                            .homeStay!.images!.isNotEmpty)
                        ? Image.network(bookingHomestayModel.bookingDetails![0]
                                .room!.homeStay!.images!.first.url!)
                            .image
                        : const AssetImage('assets/images/failed_pay.jpg'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
