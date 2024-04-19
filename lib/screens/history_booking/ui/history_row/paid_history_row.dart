// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile_home_travel/models/user/profile_user_model.dart';
import 'package:mobile_home_travel/screens/feedback_homestay/ui/feedback_homestay_screen.dart';
import 'package:mobile_home_travel/utils/format/format.dart';
import 'package:mobile_home_travel/models/booking/booking_homestay_model.dart';
import 'package:mobile_home_travel/screens/booking/step_review_booking/ui/detail_booking/util/row_text.dart';
import 'package:mobile_home_travel/screens/booking/step_review_booking/ui/review_booking/review_booking.dart';
import 'package:mobile_home_travel/themes/app_colors.dart';

class PaidHistoryRow extends StatefulWidget {
  BookingHomestayModel bookingHomestayModel;
  UserProfileModel userInfor;

  PaidHistoryRow({
    super.key,
    required this.bookingHomestayModel,
    required this.userInfor,
  });

  @override
  State<PaidHistoryRow> createState() => _PaidHistoryRowState();
}

class _PaidHistoryRowState extends State<PaidHistoryRow> {
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
                          'Ngày đặt',
                          FormatProvider().convertDateTime(
                              bookingHomestayModel.createdDate.toString()),
                          Icons.date_range_outlined),
                      RowText().richText(
                          'Tổng tiền',
                          '${FormatProvider().formatPrice(bookingHomestayModel.totalPrice.toString())}vnđ',
                          Icons.attach_money_sharp),
                    ],
                  ),
                ),

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
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FeedbackHomestayScreen(
                                homestayModel: bookingHomestayModel
                                    .bookingDetails?[0].room!.homeStay!,
                                isCreateFeedback: true,
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 5),
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
                              'Viết đánh giá',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
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
                          padding: const EdgeInsets.only(left: 5, right: 10),
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
                                fontSize: 14,
                                color: Colors.black.withOpacity(0.7),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                )
                // Row(
                //   children: [

                //   ],
                // ),
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
                'assets/images/success_pay.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
