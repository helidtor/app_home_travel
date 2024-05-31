// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_home_travel/utils/format/format.dart';
import 'package:mobile_home_travel/screens/wallet/ui/wallet_screen.dart';
import 'package:mobile_home_travel/widgets/input/text_content.dart';
import 'package:mobile_home_travel/widgets/notification/error_provider.dart';
import 'package:mobile_home_travel/widgets/notification/success_provider.dart';

import 'package:mobile_home_travel/api/api_booking.dart';
import 'package:mobile_home_travel/models/booking/booking_homestay_model.dart';
import 'package:mobile_home_travel/screens/web_view/web_view.dart';
import 'package:mobile_home_travel/themes/app_colors.dart';
import 'package:mobile_home_travel/widgets/buttons/round_gradient_button.dart';
import 'package:toastification/toastification.dart';

class CheckoutBooking extends StatefulWidget {
  BookingHomestayModel bookingHomestayModel;
  num balance;
  bool? isCheckOutDeposit;
  CheckoutBooking({
    super.key,
    this.isCheckOutDeposit,
    required this.bookingHomestayModel,
    required this.balance,
  });

  @override
  State<CheckoutBooking> createState() => _CheckoutBookingState();
}

class _CheckoutBookingState extends State<CheckoutBooking> {
  bool isCheckedPayWallet = false;
  bool isCheckedPayCard = false;
  bool isCheckedDeposit = false;
  bool isCheckedPayFull = false;
  late BookingHomestayModel booking;
  late num balance;
  bool isCheckOutDeposit = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    booking = widget.bookingHomestayModel;
    balance = widget.balance;
    if (widget.isCheckOutDeposit != null) {
      isCheckOutDeposit = widget.isCheckOutDeposit!;
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: !isCheckOutDeposit ? screenHeight * 0.9 : screenHeight * 0.77,
      width: screenWidth,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(
            indent: 160,
            endIndent: 160,
            thickness: 3,
            color: AppColors.primaryColor1.withOpacity(0.2),
          ),

          //bảng chọn thanh toán cọc hoặc trả full
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: Text(
              isCheckOutDeposit ? 'Hoàn tất thanh toán' : 'Gói thanh toán',
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Center(
            child: !isCheckOutDeposit
                ? Column(
                    children: [
                      _rowSelection(
                        title: (booking.bookingDetails![0].room!.homeStay!
                                    .depositRate! ==
                                0)
                            ? 'Ưu đãi 0₫'
                            : 'Thanh toán cọc (${booking.bookingDetails![0].room!.homeStay!.depositRate!}%)',
                        description: (booking.bookingDetails![0].room!.homeStay!
                                    .depositRate! ==
                                0)
                            ? 'Đặt trước hoàn toàn miễn phí!'
                            : 'Trả trước ${FormatProvider().formatPrice(((booking.totalPrice)! * booking.bookingDetails![0].room!.homeStay!.depositRate! / 100).toString())} vnđ',
                        icon: FontAwesomeIcons.scaleBalanced,
                        width: screenWidth * 0.85,
                        checkbox: Checkbox(
                          activeColor: AppColors.primaryColor3,
                          shape: const CircleBorder(),
                          value: isCheckedDeposit,
                          onChanged: (newValue) async {
                            setState(() {
                              isCheckedDeposit = newValue!;
                              isCheckedPayFull = false;
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      _rowSelection(
                        title: 'Thanh toán toàn bộ',
                        description:
                            'Trả hết ${FormatProvider().formatPrice(booking.totalPrice.toString())} vnđ',
                        icon: FontAwesomeIcons.moneyBill,
                        width: screenWidth * 0.85,
                        checkbox: Checkbox(
                          activeColor: AppColors.primaryColor3,
                          shape: const CircleBorder(),
                          value: isCheckedPayFull,
                          onChanged: (newValue) async {
                            setState(() {
                              isCheckedPayFull = newValue!;
                              isCheckedDeposit = false;
                            });
                          },
                        ),
                      ),
                    ],
                  )
                : _rowSelection(
                    title: 'Thanh toán nốt đơn',
                    description:
                        'Số tiền còn thiếu: ${FormatProvider().formatPrice(((booking.totalPrice! * (100 - booking.bookingDetails![0].room!.homeStay!.depositRate!) / 100)).toString())} vnđ',
                    icon: FontAwesomeIcons.scaleBalanced,
                    width: screenWidth * 0.85,
                    checkbox: Checkbox(
                      activeColor: AppColors.primaryColor3,
                      shape: const CircleBorder(),
                      value: isCheckedDeposit,
                      onChanged: (newValue) async {
                        setState(() {
                          isCheckedDeposit = newValue!;
                          isCheckedPayFull = false;
                        });
                      },
                    ),
                  ),
          ),
          const SizedBox(
            height: 20,
          ),
          //bảng chọn phương thức thanh toán
          Divider(
            thickness: 10,
            color: AppColors.primaryColor1.withOpacity(0.1),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: Text(
              'Phương thức thanh toán',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _rowSelection(
                  title: 'Ví của tôi',
                  description:
                      'Số dư: ${FormatProvider().formatPrice(balance.toString())} vnđ',
                  icon: FontAwesomeIcons.wallet,
                  width: screenWidth * 0.85,
                  checkbox: Checkbox(
                    activeColor: AppColors.primaryColor3,
                    shape: const CircleBorder(),
                    value: isCheckedPayWallet,
                    onChanged: (newValue) async {
                      setState(() {
                        isCheckedPayWallet = newValue!;
                        isCheckedPayCard = false;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                _rowSelection(
                  title: 'Ngân hàng',
                  description: 'Thanh toán qua VN Pay',
                  icon: Icons.account_balance_sharp,
                  width: screenWidth * 0.85,
                  checkbox: Checkbox(
                    activeColor: AppColors.primaryColor3,
                    shape: const CircleBorder(),
                    value: isCheckedPayCard,
                    onChanged: (newValue) async {
                      setState(() {
                        isCheckedPayCard = newValue!;
                        isCheckedPayWallet = false;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Divider(
            thickness: 10,
            color: AppColors.primaryColor1.withOpacity(0.1),
          ),
          const Spacer(),
          Center(
            child: RoundGradientButton(
                textSize: 18,
                width: screenWidth * 0.85,
                height: screenHeight * 0.05,
                title: 'Thanh toán',
                onPressed: () async {
                  if (isCheckedPayWallet && isCheckedDeposit) {
                    // trả ví và trả cọc
                    if (balance >=
                        (booking.totalPrice! *
                            booking.bookingDetails![0].room!.homeStay!
                                .depositRate! /
                            100)) {
                      var isPaid = await ApiBooking.checkoutDepositByWallet(
                          idBooking: booking.id!);
                      if (isPaid == true) {
                        //thanh toán thành công
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const WalletScreen()),
                        );
                        SuccessNotiProvider()
                            .ToastSuccess(context, 'Thanh toán thành công!');
                      } else {
                        //thanh toán thất bại
                        Navigator.pop(context);
                        ErrorNotiProvider()
                            .ToastError(context, 'Thanh toán thất bại!');
                      }
                    } else {
                      Navigator.pop(context);
                      ErrorNotiProvider().showError(context,
                          'Số dư không đủ! Vui lòng nạp thêm tiền vào ví!');
                    }
                  } else if (isCheckedPayWallet && isCheckedPayFull) {
                    //trả ví và trả full
                    if (balance >= (booking.totalPrice!)) {
                      var isPaid = await ApiBooking.checkoutFullByWallet(
                          idBooking: booking.id!);
                      if (isPaid == true) {
                        //thanh toán thành công
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const WalletScreen()),
                        );
                        SuccessNotiProvider()
                            .ToastSuccess(context, 'Thanh toán thành công!');
                      } else {
                        //thanh toán thất bại
                        Navigator.pop(context);
                        ErrorNotiProvider()
                            .showError(context, 'Thanh toán thất bại!');
                      }
                    } else {
                      Navigator.pop(context);
                      ErrorNotiProvider().showError(context,
                          'Số dư không đủ! Vui lòng nạp thêm tiền vào ví!');
                    }
                  } else if (isCheckedPayCard && isCheckedDeposit) {
                    // trả thẻ và trả cọc
                    var urlPayment = await ApiBooking.checkoutDepositByCard(
                        idBooking: booking.id!);
                    if (urlPayment != null) {
                      print('Link thanh toán là $urlPayment');
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => WebView(url: urlPayment),
                        ),
                      );
                    }
                  } else if (isCheckedPayCard && isCheckedPayFull) {
                    // trả thẻ và trả full
                    var urlPayment = await ApiBooking.checkoutFullByCard(
                        idBooking: booking.id!);
                    if (urlPayment != null) {
                      print('Link thanh toán là $urlPayment');
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => WebView(url: urlPayment),
                        ),
                      );
                    }
                  } else if ((!isCheckedPayCard || //kiểm tra xem có tick chọn gói và phương thức thanh toán chưa
                          !isCheckedPayWallet) &&
                      (!isCheckedPayFull || !isCheckedDeposit)) {
                    toastification.show(
                        pauseOnHover: false,
                        showProgressBar: false,
                        progressBarTheme: const ProgressIndicatorThemeData(
                          color: Colors.red,
                        ),
                        icon: const Icon(
                          Icons.error_outline_rounded,
                          color: Colors.red,
                        ),
                        foregroundColor: Colors.black,
                        context: context,
                        type: ToastificationType.error,
                        style: ToastificationStyle.flatColored,
                        title: const TextContent(
                          contentText:
                              'Vui lòng chọn gói và phương thức thanh toán!',
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        autoCloseDuration: const Duration(milliseconds: 2000),
                        animationDuration: const Duration(milliseconds: 250),
                        alignment: Alignment.topCenter);
                  }
                }),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

Widget _rowSelection({
  required String title,
  required String description,
  required IconData icon,
  required double width,
  Widget? checkbox,
}) {
  return Container(
    width: width,
    height: 70,
    decoration: BoxDecoration(
      border: Border.all(
        width: 0.5,
        color: Colors.black.withOpacity(0.7),
      ),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: AppColors.primaryColor1.withOpacity(0.2),
          spreadRadius: 0.1,
          blurRadius: 9,
          offset: const Offset(0, 2),
        ),
      ],
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Icon(
                icon,
                color: AppColors.primaryColor1,
                size: 25,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  description,
                  style: const TextStyle(
                    color: Colors.black38,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
        checkbox ?? const SizedBox(),
      ],
    ),
  );
}
