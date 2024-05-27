// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile_home_travel/models/user/profile_user_model.dart';
import 'package:mobile_home_travel/screens/booking/step_review_booking/ui/review_booking/utils/checkout_booking.dart';
import 'package:mobile_home_travel/screens/feedback_homestay/ui/feedback_homestay_screen.dart';
import 'package:mobile_home_travel/screens/history_booking/utils/check_date.dart';
import 'package:mobile_home_travel/utils/format/format.dart';
import 'package:mobile_home_travel/models/booking/booking_homestay_model.dart';
import 'package:mobile_home_travel/screens/booking/step_review_booking/ui/detail_booking/utils/row_text.dart';
import 'package:mobile_home_travel/screens/booking/step_review_booking/ui/review_booking/review_booking.dart';
import 'package:mobile_home_travel/themes/app_colors.dart';

class OngoingHistoryRow extends StatefulWidget {
  BookingHomestayModel bookingHomestayModel;
  UserProfileModel userInfor;

  OngoingHistoryRow({
    super.key,
    required this.bookingHomestayModel,
    required this.userInfor,
  });

  @override
  State<OngoingHistoryRow> createState() => _OngoingHistoryRowState();
}

class _OngoingHistoryRowState extends State<OngoingHistoryRow> {
  late BookingHomestayModel bookingHomestayModel;
  UserProfileModel? userInfor;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bookingHomestayModel = widget.bookingHomestayModel;
    // print(
    //     'Ngày checkin ${bookingHomestayModel.checkInDate} Ngày checkout ${bookingHomestayModel.checkOutDate}');
    // print(checkDateProvider().isOngoingDate(bookingHomestayModel)
    //     ? 'Danh sách đơn đang diễn ra: $bookingHomestayModel'
    //     : 'Kết quả: ${checkDateProvider().isOngoingDate(bookingHomestayModel)}');
    userInfor = widget.userInfor;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return
        // checkDateProvider().isOngoingDate(bookingHomestayModel)
        (bookingHomestayModel.isCheckin == true)
            ? Padding(
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
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
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
                                      content: bookingHomestayModel.id!
                                          .substring(0, 13),
                                      icon: Icons.qr_code),
                                  RowText().richText(
                                      title: 'Tên homestay',
                                      content: bookingHomestayModel
                                          .bookingDetails![0]
                                          .room!
                                          .homeStay!
                                          .name!,
                                      icon: Icons.home_outlined),
                                  RowText().richText(
                                      title: 'Thời gian đặt',
                                      content: FormatProvider().convertDateTime(
                                          bookingHomestayModel.createdDate
                                              .toString()),
                                      icon: Icons.date_range_outlined),
                                  RowText().richText(
                                      title: 'Thời gian ở',
                                      content: (bookingHomestayModel
                                                  .checkInDate ==
                                              bookingHomestayModel.checkOutDate)
                                          ? '${FormatProvider().convertDate(bookingHomestayModel.checkInDate.toString())} (1 ngày)'
                                          : '${FormatProvider().convertDate(bookingHomestayModel.checkInDate.toString())} - ${FormatProvider().convertDate(bookingHomestayModel.checkOutDate.toString())}',
                                      icon: Icons.date_range_outlined),
                                  (bookingHomestayModel.status == 'DEPOSIT')
                                      ? RowText().richText(
                                          title: 'Trạng thái',
                                          textStyleContent: const TextStyle(
                                            height: 1.5,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                235, 200, 154, 63),
                                            fontSize: 13,
                                          ),
                                          content:
                                              'Đã cọc (còn thiếu: ${FormatProvider().formatPrice(((bookingHomestayModel.totalPrice! * (100 - bookingHomestayModel.bookingDetails![0].room!.homeStay!.depositRate!) / 100)).toString())}₫)',
                                          icon:
                                              Icons.playlist_add_check_rounded)
                                      : RowText().richText(
                                          textStyleContent: const TextStyle(
                                            height: 1.5,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 49, 152, 52),
                                            fontSize: 14,
                                          ),
                                          title: 'Trạng thái',
                                          content: 'Đã thanh toán toàn bộ',
                                          icon:
                                              Icons.playlist_add_check_rounded),
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                (bookingHomestayModel.status == 'DEPOSIT')
                                    ? Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            showModalBottomSheet<void>(
                                              isScrollControlled: true,
                                              context: context,
                                              builder: (BuildContext context) {
                                                return CheckoutBooking(
                                                  isCheckOutDeposit: true,
                                                  bookingHomestayModel:
                                                      bookingHomestayModel,
                                                  balance: userInfor!
                                                      .wallets!.first.balance!,
                                                );
                                              },
                                            );
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 5),
                                            child: Container(
                                              alignment: Alignment.center,
                                              height: 25,
                                              decoration: BoxDecoration(
                                                color: AppColors.primaryColor3
                                                    .withOpacity(0.8),
                                                border: Border.all(
                                                  color: Colors.black
                                                      .withOpacity(0.4),
                                                  width: 0.8,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: const Text(
                                                'Thanh toán nốt',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : const SizedBox(),
                                // Expanded(
                                //   child: GestureDetector(
                                //     onTap: () {
                                //       Navigator.push(
                                //         context,
                                //         MaterialPageRoute(
                                //           builder: (context) =>
                                //               FeedbackHomestayScreen(
                                //             homestayModel: bookingHomestayModel
                                //                 .bookingDetails?[0].room!.homeStay!,
                                //             isCreateFeedback: true,
                                //           ),
                                //         ),
                                //       );
                                //     },
                                //     child: Padding(
                                //       padding:
                                //           const EdgeInsets.only(left: 5, right: 5),
                                //       child: Container(
                                //         alignment: Alignment.center,
                                //         height: 25,
                                //         decoration: BoxDecoration(
                                //           color: AppColors.primaryColor3
                                //               .withOpacity(0.8),
                                //           border: Border.all(
                                //             color: Colors.black.withOpacity(0.4),
                                //             width: 0.8,
                                //           ),
                                //           borderRadius: BorderRadius.circular(5),
                                //         ),
                                //         child: const Text(
                                //           'Viết đánh giá',
                                //           style: TextStyle(
                                //             fontWeight: FontWeight.bold,
                                //             fontSize: 14,
                                //             color: Colors.white,
                                //           ),
                                //         ),
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      print(
                                          'Thông tin booking từ history: $bookingHomestayModel');
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ReviewBooking(
                                            isFromPending: false,
                                            userProfileModel: userInfor,
                                            bookingHomestayModel:
                                                bookingHomestayModel,
                                            isAllowBack: true,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 5, right: 10),
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 25,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color:
                                                Colors.black.withOpacity(0.4),
                                            width: 0.8,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Text(
                                          'Xem đơn',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            color:
                                                Colors.black.withOpacity(0.5),
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
                            borderRadius:
                                const BorderRadius.all(Radius.circular(300)),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: (bookingHomestayModel.bookingDetails![0]
                                      .room!.homeStay!.images!.isNotEmpty)
                                  ? Image.network(bookingHomestayModel
                                          .bookingDetails![0]
                                          .room!
                                          .homeStay!
                                          .images!
                                          .first
                                          .url!)
                                      .image
                                  : const AssetImage(
                                      'assets/images/ONGOING.png'),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : const SizedBox();
  }
}
