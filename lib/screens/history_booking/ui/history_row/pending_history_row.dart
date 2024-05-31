// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile_home_travel/api/api_booking.dart';
import 'package:mobile_home_travel/models/user/profile_user_model.dart';
import 'package:mobile_home_travel/screens/history_booking/ui/history_screen.dart';
import 'package:mobile_home_travel/screens/history_booking/utils/cancel_function.dart';
import 'package:mobile_home_travel/utils/format/format.dart';
import 'package:mobile_home_travel/models/booking/booking_homestay_model.dart';
import 'package:mobile_home_travel/screens/booking/step_review_booking/ui/detail_booking/utils/row_text.dart';
import 'package:mobile_home_travel/screens/booking/step_review_booking/ui/review_booking/review_booking.dart';
import 'package:mobile_home_travel/themes/app_colors.dart';
import 'package:mobile_home_travel/utils/navigator/navigator_bar.dart';

class PendingHistoryRow extends StatefulWidget {
  BookingHomestayModel bookingHomestayModel;
  UserProfileModel userInfor;
  PendingHistoryRow({
    super.key,
    required this.bookingHomestayModel,
    required this.userInfor,
  });

  @override
  State<PendingHistoryRow> createState() => _PendingHistoryRowState();
}

class _PendingHistoryRowState extends State<PendingHistoryRow> {
  late BookingHomestayModel bookingHomestayModel;
  UserProfileModel? userInfor;
  List<String> listIdRoom = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userInfor = widget.userInfor;
    listIdRoom = widget.bookingHomestayModel.bookingDetails!
        .map((e) => e.roomId!)
        .toList();
    bookingHomestayModel = widget.bookingHomestayModel;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 215,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: 185, //để viền container cắt giữa ảnh
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
                            title: 'Tên homestay',
                            content: bookingHomestayModel
                                .bookingDetails![0].room!.homeStay!.name!,
                            icon: Icons.home_outlined),
                        RowText().richText(
                            title: 'Ngày tạo',
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
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            print(
                                'booking từ lịch sử là: $bookingHomestayModel');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ReviewBooking(
                                  startDate: bookingHomestayModel.checkInDate!,
                                  endDate: bookingHomestayModel.checkOutDate!,
                                  listIdRoom: listIdRoom,
                                  isFromHistoryPendingBooking: true,
                                  userProfileModel: userInfor,
                                  bookingHomestayModel: bookingHomestayModel,
                                  isAllowBack: true,
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
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            CancelFunctionProvider().dialogCancelNoFine(
                              //hộp thoại hủy pending booking
                              context,
                              bookingHomestayModel,
                              true,
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5, right: 10),
                            child: Container(
                              alignment: Alignment.center,
                              height: 25,
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor5.withOpacity(0.7),
                                border: Border.all(
                                  color: Colors.black.withOpacity(0.4),
                                  width: 0.8,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: const Text(
                                'Hủy đơn',
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
                    ],
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
                        : const AssetImage('assets/images/waiting_booking.png'),
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
