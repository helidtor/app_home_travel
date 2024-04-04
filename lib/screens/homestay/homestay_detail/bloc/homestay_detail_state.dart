// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:mobile_home_travel/models/booking/wishlist_model.dart';
import 'package:mobile_home_travel/models/homestay/homestay_detail_model.dart';

abstract class HomestayDetailState extends Equatable {
  const HomestayDetailState();

  @override
  List<Object> get props => [];
}

class HomestayDetailInitial extends HomestayDetailState {}

class HomestayDetailLoading extends HomestayDetailState {}

class GetDisplaySuccess extends HomestayDetailState {
  HomestayDetailModel homestayDetailModel;
  bool iswishlist;
  GetDisplaySuccess({
    required this.homestayDetailModel,
    required this.iswishlist,
  });
}

class GetDisplayFailure extends HomestayDetailState {
  String error;
  GetDisplayFailure({
    required this.error,
  });
}

class WishlistSuccessState extends HomestayDetailState {}
