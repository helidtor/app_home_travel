// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:mobile_home_travel/models/booking/booking_detail_model.dart';
import 'package:mobile_home_travel/utils/format/format.dart';

class RowPriceDetail extends StatefulWidget {
  BookingDetailModel priceDetail;
  RowPriceDetail({
    super.key,
    required this.priceDetail,
  });

  @override
  State<RowPriceDetail> createState() => _RowPriceDetailState();
}

class _RowPriceDetailState extends State<RowPriceDetail> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            '●  ${FormatProvider().convertDateMonth(widget.priceDetail.startDate!)} - ${FormatProvider().convertDateMonth(widget.priceDetail.endDate!)}',
            style: const TextStyle(fontSize: 12),
          ),
        ), //giá trong tuần
        const Expanded(flex: 1, child: Text('=')),
        Expanded(
          flex: 1,
          child: Text(
            '${FormatProvider().formatPrice(widget.priceDetail.price.toString())} đ',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ),
      ],
    );
  }
}
