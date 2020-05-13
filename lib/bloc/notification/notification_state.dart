part of 'notification_bloc.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();
}


class NotificationInitial extends NotificationState {
  @override
  List<Object> get props => [];
}

class NotificationLoading extends NotificationState {
  const NotificationLoading();
  @override
  List<Object> get props => [];
}

class NotificationSuccess extends NotificationState {
  final dynamic notifications;
  const NotificationSuccess([this.notifications = const []]);
  @override
  List<Object> get props => [notifications];
}

class NotificationError extends NotificationState {
  final String message;
  const NotificationError(this.message);
  @override
  List<Object> get props => [message];
}