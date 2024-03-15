import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_home_travel/api/api_homestay.dart';
import 'package:mobile_home_travel/screens/homestay/homestay/bloc/homestay_event.dart';
import 'package:mobile_home_travel/screens/homestay/homestay/bloc/homestay_state.dart';

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
        var listHomestay = await ApiHomestay.getAllHomestay();
        emit(HomestaySuccess(list: listHomestay!));
      } else {
        emit(const HomestayError(error: "Lỗi bài homestay"));
      }
    } catch (e) {
      print("Loi bai homestay: $e");
      emit(const HomestayError(error: "Lỗi tải bài"));
    }
  }
}
