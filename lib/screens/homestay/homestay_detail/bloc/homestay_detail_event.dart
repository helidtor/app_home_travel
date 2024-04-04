// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

abstract class HomestayDetailEvent extends Equatable {
  const HomestayDetailEvent();

  @override
  List<Object> get props => [];
}

class GetInforDisplay extends HomestayDetailEvent {}

class WishlistHomestay extends HomestayDetailEvent {
  bool isWishlist;
  WishlistHomestay({
    required this.isWishlist,
  });
}
