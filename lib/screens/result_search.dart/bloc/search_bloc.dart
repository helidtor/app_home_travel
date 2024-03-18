import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_home_travel/api/api_homestay.dart';
import 'package:mobile_home_travel/screens/result_search.dart/bloc/search_event.dart';
import 'package:mobile_home_travel/screens/result_search.dart/bloc/search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    // event handler was added
    on<SearchEvent>((event, emit) async {
      await post(emit, event);
    });
  }

  post(Emitter<SearchState> emit, SearchEvent event) async {
    emit(SearchLoading());
    try {
      if (event is SearchHomestay) {
        var listHomestay =
            await ApiHomestay.searchHomestay(event.capacity, event.location);
        if (listHomestay!.isNotEmpty) {
          emit(SearchSuccess(list: listHomestay));
        } else {
          emit(const SearchEmpty(noti: "Không tìm thấy homestay!"));
        }
      } else {
        emit(const SearchError(error: "Lỗi tìm kiếm homestay"));
      }
    } catch (e) {
      print("Loi tim kiem homestay: $e");
      emit(const SearchError(error: "Lỗi tìm kiếm"));
    }
  }
}
