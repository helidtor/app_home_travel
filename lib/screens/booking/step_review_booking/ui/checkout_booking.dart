import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_home_travel/themes/app_colors.dart';
import 'package:mobile_home_travel/widgets/buttons/round_gradient_button.dart';

class CheckoutBooking extends StatefulWidget {
  const CheckoutBooking({super.key});

  @override
  State<CheckoutBooking> createState() => _CheckoutBookingState();
}

class _CheckoutBookingState extends State<CheckoutBooking> {
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
                    border: Border.all(width: 0.5, color: Colors.black26),
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
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: screenWidth * 0.85,
                  height: 70,
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.5, color: Colors.black26),
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
                    border: Border.all(width: 0.5, color: Colors.black26),
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
                    children: [
                      
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
                    border: Border.all(width: 0.5, color: Colors.black26),
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
          const Spacer(),
          Center(
            child: RoundGradientButton(
                textSize: 18,
                width: screenWidth * 0.85,
                height: screenHeight * 0.05,
                title: 'Thanh toán',
                onPressed: () {
                  // _bloc.add(CheckoutBookingByCard(idBooking: booking.id!));
                }),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
