import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_home_travel/api/api_user.dart';
import 'package:mobile_home_travel/screens/notifications/bloc/notification_event.dart';
import 'package:mobile_home_travel/screens/notifications/bloc/notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(NotificationInitial()) {
    // event handler was added
    on<NotificationEvent>((event, emit) async {
      await post(emit, event);
    });
  }

  post(Emitter<NotificationState> emit, NotificationEvent event) async {
    emit(NotificationLoading());
    try {
      if (event is GetListNotification) {
        var listNotification = await ApiUser.getListNotification();
        if (listNotification!.isNotEmpty) {
          emit(GetNotificationSuccess(listNotification: listNotification));
        } else {
          emit(const NotificationEmpty(noti: 'Chưa có thông báo!'));
        }
      }
    } catch (e) {
      print("Loi get Notification: $e");
      emit(const NotificationError(error: "Lỗi danh sách thông báo!"));
    }
  }
}
