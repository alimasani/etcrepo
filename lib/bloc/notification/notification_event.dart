part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();
}


class GetNotifications extends NotificationEvent {

  const GetNotifications();

  @override
  List<Object> get props => [];
}
