// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:mobile_home_travel/models/booking/booking_detail_model.dart';
import 'package:mobile_home_travel/models/user/profile_user_model.dart';

class BookingHomestayModel {
  String? id;
  num? totalPrice;
  String? checkInDate;
  String? checkOutDate;
  String? status;
  String? createdDate;
  String? touristId;
  num? totalCapacity;
  UserProfileModel? tourist;
  List<BookingDetailModel>? bookingDetails;
  BookingHomestayModel({
    this.id,
    this.totalPrice,
    this.checkInDate,
    this.checkOutDate,
    this.status,
    this.createdDate,
    this.touristId,
    this.totalCapacity,
    this.tourist,
    this.bookingDetails,
  });

  BookingHomestayModel copyWith({
    String? id,
    num? totalPrice,
    String? checkInDate,
    String? checkOutDate,
    String? status,
    String? createdDate,
    String? touristId,
    num? totalCapacity,
    UserProfileModel? tourist,
    List<BookingDetailModel>? bookingDetails,
  }) {
    return BookingHomestayModel(
      id: id ?? this.id,
      totalPrice: totalPrice ?? this.totalPrice,
      checkInDate: checkInDate ?? this.checkInDate,
      checkOutDate: checkOutDate ?? this.checkOutDate,
      status: status ?? this.status,
      createdDate: createdDate ?? this.createdDate,
      touristId: touristId ?? this.touristId,
      totalCapacity: totalCapacity ?? this.totalCapacity,
      tourist: tourist ?? this.tourist,
      bookingDetails: bookingDetails ?? this.bookingDetails,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'totalPrice': totalPrice,
      'checkInDate': checkInDate,
      'checkOutDate': checkOutDate,
      'status': status,
      'createdDate': createdDate,
      'touristId': touristId,
      'totalCapacity': totalCapacity,
      'tourist': tourist?.toMap(),
      'bookingDetails': bookingDetails?.map((x) => x.toMap()).toList(),
    };
  }

  factory BookingHomestayModel.fromMap(Map<String, dynamic> map) {
    return BookingHomestayModel(
      id: map['id'] != null ? map['id'] as String : null,
      totalPrice: map['totalPrice'] != null ? map['totalPrice'] as num : null,
      checkInDate:
          map['checkInDate'] != null ? map['checkInDate'] as String : null,
      checkOutDate:
          map['checkOutDate'] != null ? map['checkOutDate'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      createdDate:
          map['createdDate'] != null ? map['createdDate'] as String : null,
      touristId: map['touristId'] != null ? map['touristId'] as String : null,
      totalCapacity:
          map['totalCapacity'] != null ? map['totalCapacity'] as num : null,
      tourist: map['tourist'] != null
          ? UserProfileModel.fromMap(map['tourist'] as Map<String, dynamic>)
          : null,
      bookingDetails: map['bookingDetails'] != null
          ? List<BookingDetailModel>.from(
              (map['bookingDetails']).map<BookingDetailModel?>(
                (x) => BookingDetailModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BookingHomestayModel.fromJson(String source) =>
      BookingHomestayModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BookingHomestayModel(id: $id, totalPrice: $totalPrice, checkInDate: $checkInDate, checkOutDate: $checkOutDate, status: $status, createdDate: $createdDate, touristId: $touristId, totalCapacity: $totalCapacity, tourist: $tourist, bookingDetails: $bookingDetails)';
  }

  @override
  bool operator ==(covariant BookingHomestayModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.totalPrice == totalPrice &&
        other.checkInDate == checkInDate &&
        other.checkOutDate == checkOutDate &&
        other.status == status &&
        other.createdDate == createdDate &&
        other.touristId == touristId &&
        other.totalCapacity == totalCapacity &&
        other.tourist == tourist &&
        listEquals(other.bookingDetails, bookingDetails);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        totalPrice.hashCode ^
        checkInDate.hashCode ^
        checkOutDate.hashCode ^
        status.hashCode ^
        createdDate.hashCode ^
        touristId.hashCode ^
        totalCapacity.hashCode ^
        tourist.hashCode ^
        bookingDetails.hashCode;
  }
}
