import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_home_travel/api/api_homestay.dart';
import 'package:mobile_home_travel/screens/wishlist/bloc/wishlist_event.dart';
import 'package:mobile_home_travel/screens/wishlist/bloc/wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistInitial()) {
    // event handler was added
    on<WishlistEvent>((event, emit) async {
      await post(emit, event);
    });
  }

  post(Emitter<WishlistState> emit, WishlistEvent event) async {
    emit(WishlistLoading());
    try {
      if (event is GetListWishlist) {
        var listWishlist = await ApiHomestay.getListWishlist();
        if (listWishlist!.isNotEmpty) {
          emit(GetWishlistSuccess(listWishlist: listWishlist));
        } else {
          emit(const WishlistEmpty(noti: 'Chưa có homestay yêu thích!'));
        }
      }
    } catch (e) {
      print("Loi get Wishlist: $e");
      emit(const WishlistError(error: "Lỗi danh sách homestay yêu thích!"));
    }
  }
}
