// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_home_travel/utils/format/format.dart';

import 'package:mobile_home_travel/models/wallet/transaction_model.dart';
import 'package:mobile_home_travel/screens/transaction/transaction_detail.dart';
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
    print(transactionModel);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TransactionDetail(
                  transactionModel: transactionModel,
                )),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
        child: Container(
          height: 60,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              //màu nền của giao dịch
              color: (transactionModel.status == 'SUCCESS')
                  ? Colors.green.withOpacity(0.3)
                  : Colors.red.withOpacity(0.2)),
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
                      ),
                      //màu nền ảnh theo status giao dịch
                      child: (transactionModel.status == 'SUCCESS')
                          //ảnh minh họa theo từng loại giao dịch
                          ? Image.asset(
                              FormatProvider()
                                  .convertTypeImage(transactionModel.type!),
                              fit: BoxFit.cover,
                            )
                          : ClipOval(
                              child: SizedBox(
                                width: 40,
                                height: 40,
                                child: ColorFiltered(
                                  colorFilter: ColorFilter.mode(
                                    Colors.red.withOpacity(0.5),
                                    BlendMode.darken,
                                  ),
                                  child: Image.asset(
                                    FormatProvider().convertTypeImage(
                                        transactionModel.type!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //loại giao dịch
                        Text(
                          FormatProvider().convertType(transactionModel.type!),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black.withOpacity(0.8),
                          ),
                        ),
                        (transactionModel.createdDate != null)
                            ? Text(
                                FormatProvider().convertDateTime(
                                    transactionModel.createdDate.toString()),
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: 12,
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ],
                ),
                Text(
                  //hiện dấu cộng hoặc trừ hoặc không hiện dấu
                  (FormatProvider().convertPlusOrMinus(transactionModel.type!))
                      ? '+${FormatProvider().formatPrice(transactionModel.price.toString())}₫'
                      : '-${FormatProvider().formatPrice(transactionModel.price.toString())}₫',
                  style: TextStyle(
                    color: (FormatProvider()
                            .convertPlusOrMinus(transactionModel.type!))
                        ? (transactionModel.status == 'SUCCESS')
                            ? const Color.fromARGB(255, 21, 149, 25)
                            : Colors.black38
                        : Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
