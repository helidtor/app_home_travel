// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// import 'package:mobile_home_travel/models/booking/booking_detail_model.dart';
// import 'package:mobile_home_travel/utils/format/format.dart';

// class RowPriceDetail extends StatefulWidget {
//   List<BookingDetailModel> listBookingDetail;
//   RowPriceDetail({
//     super.key,
//     required this.listBookingDetail,
//   });

//   @override
//   State<RowPriceDetail> createState() => _RowPriceDetailState();
// }

// class _RowPriceDetailState extends State<RowPriceDetail> {
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Expanded(
//           flex: 2,
//           child: Text(
//             '${FormatProvider().formatPrice(normalPrice.toString())} đ',
//             style: const TextStyle(fontSize: 12),
//           ),
//         ), //giá trong tuần
//         const Expanded(flex: 1, child: Text('x')),
//         Expanded(
//           flex: 4,
//           child: RichText(
//             text: TextSpan(
//               children: [
//                 TextSpan(
//                   text: quantityNormalDay.toString(), //số ngày trong tuần
//                   style: const TextStyle(
//                     fontSize: 13,
//                     color: Colors.black87,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const TextSpan(
//                   text: ' ngày trong tuần',
//                   style: TextStyle(
//                     color: Colors.black87,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         Expanded(
//           flex: 2,
//           child: Text(
//             '${FormatProvider().formatPrice((quantityNormalDay * normalPrice).toString())} đ', //tổng giá trong tuần
//             style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
//           ),
//         ),
//       ],
//     );
//   }
// }
