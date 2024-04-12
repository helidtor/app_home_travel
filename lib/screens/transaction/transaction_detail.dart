// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_home_travel/utils/format/format.dart';

import 'package:mobile_home_travel/models/wallet/transaction_model.dart';
import 'package:mobile_home_travel/utils/navigator/navigator_bar.dart';

class TransactionDetail extends StatefulWidget {
  TransactionModel transactionModel;
  TransactionDetail({
    Key? key,
    required this.transactionModel,
  }) : super(key: key);

  @override
  State<TransactionDetail> createState() => _TransactionDetailState();
}

class _TransactionDetailState extends State<TransactionDetail> {
  late TransactionModel transactionModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    transactionModel = widget.transactionModel;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        shadowColor: Colors.grey,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.keyboard_arrow_left),
        ),
        // centerTitle: true,
        title: Text(
          "Chi Tiết Giao Dịch",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(182, 0, 0, 0),
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 70,
            width: screenWidth * 0.9,
            decoration: BoxDecoration(
              //màu nền của giao dịch
              color: (transactionModel.status == 'SUCCESS')
                  ? const Color.fromARGB(255, 40, 170, 44)
                  : const Color.fromARGB(255, 205, 65, 55),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(200),
                    ),
                    child: Image.asset(
                      FormatProvider().convertTypeImage(transactionModel.type!),
                      fit: BoxFit.cover,
                    )),
                const SizedBox(
                  width: 20,
                ),
                //loại giao dịch
                Text(
                  FormatProvider().convertType(transactionModel.type!),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Mã giao dịch',
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                      const SizedBox(
                        width: 75,
                      ),
                      Flexible(
                        child: Text(
                          textAlign: TextAlign.end,
                          transactionModel.id.toString(),
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.8),
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Trạng thái',
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                      (transactionModel.status == 'SUCCESS')
                          ? Text(
                              'Thành công',
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            )
                          : Text(
                              'Thất bại',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Số tiền giao dịch',
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                      Text(
                        //hiện dấu cộng hoặc trừ hoặc không hiện dấu
                        (FormatProvider()
                                .convertPlusOrMinus(transactionModel.type!))
                            ? '+${FormatProvider().formatPrice(transactionModel.price.toString())}₫'
                            : '-${FormatProvider().formatPrice(transactionModel.price.toString())}₫',
                        style: TextStyle(
                          color: (FormatProvider()
                                  .convertPlusOrMinus(transactionModel.type!))
                              ? const Color.fromARGB(255, 21, 149, 25)
                              : Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Nguồn tiền',
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                      Text(
                        'Ví của tôi',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Ngày giao dịch',
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                      Text(
                        FormatProvider().convertDate(
                            transactionModel.createdDate.toString()),
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 60),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Giờ giao dịch',
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                      Text(
                        FormatProvider().convertTime(
                            transactionModel.createdDate.toString()),
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  indent: 10,
                  endIndent: 10,
                  thickness: 3,
                  color: (transactionModel.status == 'SUCCESS')
                      ? Colors.green.withOpacity(0.2)
                      : Colors.red.withOpacity(0.2),
                ),
                const SizedBox(
                  height: 50,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NavigatorBar()),
                    );
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: (transactionModel.status == 'SUCCESS')
                              ? Colors.green.withOpacity(0.2)
                              : Colors.red.withOpacity(0.2),
                          spreadRadius: 3,
                          blurRadius: 1,
                          offset: const Offset(0, 0),
                        ),
                      ],
                      border: Border.all(
                          color: Colors.black.withOpacity(0.4), width: 0.3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.home_sharp,
                      color: (transactionModel.status == 'SUCCESS')
                          ? Colors.green.withOpacity(0.7)
                          : Colors.red.withOpacity(0.7),
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
