// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:mobile_home_travel/constant/data_constant/preset_price.dart';
import 'package:mobile_home_travel/utils/format/format.dart';
import 'package:mobile_home_travel/themes/app_colors.dart';

class PresetPriceWallet extends StatefulWidget {
  TextEditingController priceController;
  PresetPriceWallet({
    Key? key,
    required this.priceController,
  }) : super(key: key);

  @override
  State<PresetPriceWallet> createState() => _PresetPriceWalletState();
}

class _PresetPriceWalletState extends State<PresetPriceWallet> {
  int isIndexpicked = -1; //đổi màu ô chọn giá nạp wallet

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    TextEditingController priceController = widget.priceController;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: SizedBox(
        height: screenHeight * 0.3,
        width: screenWidth,
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, mainAxisExtent: 90),
          itemCount: listPrice.length,
          itemBuilder: (context, index) {
            return Center(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isIndexpicked = index;
                    priceController.text = listPrice[index];
                  });
                },
                child: !(isIndexpicked == index)
                    ? Container(
                        alignment: Alignment.center,
                        width: 120,
                        height: 70,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                width: 2,
                                color: Colors.black.withOpacity(0.1))),
                        child: Text(
                          '${FormatProvider().formatPrice(listPrice[index])}₫',
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.3),
                            fontSize: 18,
                          ),
                        ),
                      )
                    : Container(
                        alignment: Alignment.center,
                        width: 120,
                        height: 70,
                        decoration: BoxDecoration(
                            color: AppColors.primaryColor1,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                width: 2, color: AppColors.primaryColor3)),
                        child: Text(
                          '${FormatProvider().formatPrice(listPrice[index])}₫',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
              ),
            );
          },
        ),
      ),
    );
  }
}
