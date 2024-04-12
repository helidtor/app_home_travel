import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_home_travel/api/api_homestay.dart';
import 'package:mobile_home_travel/screens/homestay/homestay_preview/bloc/homestay_event.dart';
import 'package:mobile_home_travel/screens/homestay/homestay_preview/bloc/homestay_state.dart';

class HomestayBloc extends Bloc<HomestayEvent, HomestayState> {
  HomestayBloc() : super(HomestayInitial()) {
    // event handler was added
    on<HomestayEvent>((event, emit) async {
      await post(emit, event);
    });
  }

  post(Emitter<HomestayState> emit, HomestayEvent event) async {
    emit(HomestayLoading());
    try {
      if (event is GetAllListHomestay) {
        var listHomestayRating =
            await ApiHomestay.getAllHomestayBySort(sortKey: 'Rating');
        var listHomestayNew =
            await ApiHomestay.getAllHomestayBySort(sortKey: 'CreatedDate');
        if (listHomestayNew != null && listHomestayRating != null) {
          emit(HomestaySuccess(
              listNew: listHomestayNew, listRating: listHomestayRating));
        } else {
          emit(const HomestayError(error: "Lỗi bài homestay"));
        }
      } else {
        emit(const HomestayError(error: "Lỗi bài homestay"));
      }
    } catch (e) {
      print("Loi bai homestay: $e");
      emit(const HomestayError(error: "Lỗi tải bài"));
    }
  }
}
