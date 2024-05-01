import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_home_travel/api/api_homestay.dart';
import 'package:mobile_home_travel/screens/homestay/homestay_detail/bloc/homestay_detail_state.dart';
import 'package:mobile_home_travel/screens/homestay/homestay_detail/bloc/homestay_detail_event.dart';
import 'package:mobile_home_travel/utils/shared_preferences_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomestayDetailBloc
    extends Bloc<HomestayDetailEvent, HomestayDetailState> {
  HomestayDetailBloc() : super(HomestayDetailInitial()) {
    // event handler was added
    on<HomestayDetailEvent>((event, emit) async {
      await post(emit, event);
    });
  }

  post(Emitter<HomestayDetailState> emit, HomestayDetailEvent event) async {
    emit(HomestayDetailLoading());
    try {
      if (event is GetInforDisplay) {
        String? idHomestay = SharedPreferencesUtil.getIdHomestay();
        String? idTourist = SharedPreferencesUtil.getIdUserCurrent();
        SharedPreferencesUtil.setListIdPicked([]); // xóa list id phòng được chọn
        var homestayDetail =
            await ApiHomestay.getDetailHomestay(idHomestay: idHomestay!);
        if (homestayDetail != null) {
          print('Rating là: ${homestayDetail.rating}');
          var isWishlist = await ApiHomestay.getWishlistByIdTouristAndHomeStay(
              idHomestay: idHomestay, idTourist: idTourist!);
          if (isWishlist != null) {
            SharedPreferencesUtil.setIdWishlist(isWishlist.id!);
            emit(GetDisplaySuccess(
                homestayDetailModel: homestayDetail, iswishlist: true));
          } else {
            emit(GetDisplaySuccess(
                homestayDetailModel: homestayDetail, iswishlist: false));
          }
        } else {
          emit(GetDisplayFailure(error: 'Lỗi thông tin'));
        }
      } else if (event is WishlistHomestay) {
        if (event.isWishlist == false) {
          //bỏ wishlist -> xóa
          var deleteWishlist = await ApiHomestay.deleteWishlistHomestay();
          if (deleteWishlist == true) {
            emit(WishlistSuccessState());
          }
        } else if (event.isWishlist == true) {
          //thêm wishlist -> tạo
          var createWishlist = await ApiHomestay.wishlistHomestay();
          if (createWishlist == true) {
            emit(WishlistSuccessState());
          }
        }
      }
    } catch (e) {
      emit(GetDisplayFailure(error: 'Lỗi $e'));
    }
  }
}
