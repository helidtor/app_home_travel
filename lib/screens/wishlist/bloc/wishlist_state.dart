import 'package:equatable/equatable.dart';
import 'package:mobile_home_travel/models/booking/wishlist_model.dart';
import 'package:mobile_home_travel/models/homestay/general_homestay/homestay_model.dart';

abstract class WishlistState extends Equatable {
  const WishlistState();

  @override
  List<Object> get props => [];
}

class WishlistInitial extends WishlistState {}

class WishlistLoading extends WishlistState {}

class GetWishlistSuccess extends WishlistState {
  final List<WishlistModel> listWishlist;
  const GetWishlistSuccess({required this.listWishlist});
  @override
  List<Object> get props => [listWishlist];
}

class WishlistError extends WishlistState {
  final String error;

  const WishlistError({required this.error});

  @override
  List<Object> get props => [error];
}

class WishlistEmpty extends WishlistState {
  final String noti;

  const WishlistEmpty({required this.noti});

  @override
  List<Object> get props => [noti];
}