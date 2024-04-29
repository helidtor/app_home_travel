import 'package:equatable/equatable.dart';
import 'package:mobile_home_travel/models/notification/notification_model.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object> get props => [];
}

class NotificationInitial extends NotificationState {}

class NotificationLoading extends NotificationState {}

class GetNotificationSuccess extends NotificationState {
  final List<NotificationModel> listNotification;
  const GetNotificationSuccess({required this.listNotification});
  @override
  List<Object> get props => [listNotification];
}

class NotificationError extends NotificationState {
  final String error;

  const NotificationError({required this.error});

  @override
  List<Object> get props => [error];
}

class NotificationEmpty extends NotificationState {
  final String noti;

  const NotificationEmpty({required this.noti});

  @override
  List<Object> get props => [noti];
}