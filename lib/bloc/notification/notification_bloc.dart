import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:etc/helper/services.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {

  final Services _services;
  NotificationBloc(this._services);

  @override
  NotificationState get initialState => NotificationInitial();

  @override
  Stream<NotificationState> mapEventToState(
    NotificationEvent event,
  ) async* {
    if(event is GetNotifications){
      yield NotificationLoading();
      try {
        final notList = await _services.getNotifications();
        print(notList);
        yield NotificationSuccess(notList);
      }catch (e){
        yield NotificationError(e.toString());
      }
    }
  }
}
