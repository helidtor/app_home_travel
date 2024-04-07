// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_home_travel/format/format.dart';
import 'package:mobile_home_travel/screens/wallet/ui/wallet_screen.dart';
import 'package:mobile_home_travel/widgets/notification/error_bottom.dart';
import 'package:mobile_home_travel/widgets/notification/success_bottom.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:mobile_home_travel/api/api_booking.dart';
import 'package:mobile_home_travel/models/booking/booking_homestay_model.dart';
import 'package:mobile_home_travel/screens/home/home_screen.dart';
import 'package:mobile_home_travel/screens/navigator_bar.dart';
import 'package:mobile_home_travel/screens/web_view/web_view.dart';
import 'package:mobile_home_travel/themes/app_colors.dart';
import 'package:mobile_home_travel/widgets/buttons/round_gradient_button.dart';

class CheckoutBooking extends StatefulWidget {
  BookingHomestayModel bookingHomestayModel;
  num balance;
  CheckoutBooking({
    Key? key,
    required this.bookingHomestayModel,
    required this.balance,
  }) : super(key: key);

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    booking = widget.bookingHomestayModel;
    balance = widget.balance;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight * 0.9,
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
              'Gói thanh toán',
              style: TextStyle(
                color: Colors.black,
                fontFamily: GoogleFonts.nunito().fontFamily,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Center(
            child: Column(
              children: [
                Container(
                  width: screenWidth * 0.85,
                  height: 70,
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 0.5, color: Colors.black.withOpacity(0.7)),
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
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: screenWidth * 0.85,
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
                  child: const Row(
                    children: [],
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: Text(
              'Phương thức thanh toán',
              style: TextStyle(
                color: Colors.black,
                fontFamily: GoogleFonts.nunito().fontFamily,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: screenWidth * 0.85,
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
                          const Padding(
                            padding: EdgeInsets.only(left: 30),
                            child: Icon(
                              FontAwesomeIcons.wallet,
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
                                'Ví của tôi',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  fontFamily: GoogleFonts.nunito().fontFamily,
                                ),
                              ),
                              Text(
                                'Số dư: ${FormatProvider().formatPrice(balance.toString())}₫',
                                style: TextStyle(
                                  color: Colors.black38,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  fontFamily: GoogleFonts.nunito().fontFamily,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Checkbox(
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
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: screenWidth * 0.85,
                  height: 70,
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 0.5, color: Colors.black.withOpacity(0.7)),
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
                          const Padding(
                            padding: EdgeInsets.only(left: 30),
                            child: Icon(
                              Icons.account_balance_sharp,
                              color: AppColors.primaryColor1,
                              size: 27,
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
                                'Ngân hàng',
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.7),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  fontFamily: GoogleFonts.nunito().fontFamily,
                                ),
                              ),
                              Text(
                                'Thanh toán qua VN Pay',
                                style: TextStyle(
                                  color: Colors.black38,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  fontFamily: GoogleFonts.nunito().fontFamily,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Checkbox(
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
                    ],
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
                  if (isCheckedPayWallet) {
                    if (balance >= (booking.totalPrice! / 2)) {
                      var isPaid = await ApiBooking.checkoutByWallet(
                          idBooking: booking.id!);
                      if (isPaid == true) {
                        //thanh toán thành công
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const WalletScreen()),
                        );
                        showSuccess(context, 'Thanh toán thành công');
                      } else {
                        //thanh toán thất bại
                        Navigator.pop(context);
                        showError(context, 'Thanh toán lỗi');
                      }
                    } else {
                      Navigator.pop(context);
                      showError(context,
                          'Số dư không đủ! Vui lòng nạp thêm tiền vào ví!');
                    }
                  } else if (isCheckedPayCard) {
                    var urlPayment =
                        await ApiBooking.checkoutByCard(idBooking: booking.id!);
                    if (urlPayment != null) {
                      print('Link thanh toán là $urlPayment');
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => WebView(url: urlPayment),
                        ),
                      );
                    }
                  } else if (isCheckedPayCard == false &&
                      isCheckedPayWallet == false) {}
                }),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
