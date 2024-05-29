// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:mobile_home_travel/models/booking/booking_detail_model.dart';

class PriceRoomModel {
  num? totalPrice;
  List<BookingDetailModel>? bookingDetail;
  PriceRoomModel({
    this.totalPrice,
    this.bookingDetail,
  });

  PriceRoomModel copyWith({
    num? totalPrice,
    List<BookingDetailModel>? bookingDetail,
  }) {
    return PriceRoomModel(
      totalPrice: totalPrice ?? this.totalPrice,
      bookingDetail: bookingDetail ?? this.bookingDetail,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'totalPrice': totalPrice,
      'bookingDetail': bookingDetail?.map((x) => x.toMap()).toList(),
    };
  }

  factory PriceRoomModel.fromMap(Map<String, dynamic> map) {
    return PriceRoomModel(
      totalPrice: map['totalPrice'] != null ? map['totalPrice'] as num : null,
      bookingDetail: map['bookingDetail'] != null
          ? List<BookingDetailModel>.from(
              (map['bookingDetail']).map<BookingDetailModel?>(
                (x) => BookingDetailModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PriceRoomModel.fromJson(String source) =>
      PriceRoomModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'PriceRoomModel(totalPrice: $totalPrice, bookingDetail: $bookingDetail)';

  @override
  bool operator ==(covariant PriceRoomModel other) {
    if (identical(this, other)) return true;

    return other.totalPrice == totalPrice &&
        listEquals(other.bookingDetail, bookingDetail);
  }

  @override
  int get hashCode => totalPrice.hashCode ^ bookingDetail.hashCode;
}
