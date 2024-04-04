// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_home_travel/format/format.dart';

import 'package:mobile_home_travel/models/wallet/transaction_model.dart';
import 'package:mobile_home_travel/themes/app_colors.dart';

class TransactionRow extends StatefulWidget {
  TransactionModel transactionModel;
  TransactionRow({
    Key? key,
    required this.transactionModel,
  }) : super(key: key);

  @override
  State<TransactionRow> createState() => _TransactionRowState();
}

class _TransactionRowState extends State<TransactionRow> {
  late TransactionModel transactionModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    transactionModel = widget.transactionModel;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: (transactionModel.status == 'SUCCESS')
              ? Colors.green.withOpacity(0.3)
              : Colors.red.withOpacity(0.3),
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 15, left: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(200),
                      // border:
                      //     Border.all(color: AppColors.primaryColor3, width: 1),
                    ),
                    child: Image.asset(
                      _convertTypeImage(transactionModel.type!),
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _convertType(transactionModel.type!),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black.withOpacity(0.8),
                          fontFamily: GoogleFonts.nunito().fontFamily,
                        ),
                      ),
                      Text(
                        FormatProvider().convertDate(
                            transactionModel.createdDate.toString()),
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.black.withOpacity(0.5),
                          fontSize: 12,
                          fontFamily: GoogleFonts.nunito().fontFamily,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Text(
                (_convertPlusOrMinus(transactionModel.type!))
                    ? '+${FormatProvider().formatPrice(transactionModel.price.toString())}đ'
                    : '-${FormatProvider().formatPrice(transactionModel.price.toString())}đ',
                style: TextStyle(
                  color: (_convertPlusOrMinus(transactionModel.type!))
                      ? const Color.fromARGB(255, 21, 149, 25)
                      : Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  fontFamily: GoogleFonts.nunito().fontFamily,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

String _convertType(String inputType) {
  switch (inputType) {
    case 'TOPUP':
      return 'Nạp tiền vào ví';
    case 'PAID':
      return 'Thanh toán bằng ví';
    case 'PAID_WITH_CASH':
      return 'Thanh toán bằng thẻ';
    default:
      return '';
  }
}

String _convertTypeImage(String inputType) {
  switch (inputType) {
    case 'TOPUP':
      return 'assets/images/TOPUP.png';
    case 'PAID':
      return 'assets/images/PAID.png';
    case 'PAID_WITH_CASH':
      return 'assets/images/PAID_WITH_CASH.png';
    default:
      return '';
  }
}

bool _convertPlusOrMinus(String inputType) {
  switch (inputType) {
    case 'TOPUP':
      return true;
    case 'PAID':
      return false;
    case 'PAID_WITH_CASH':
      return false;
    default:
      return false;
  }
}
