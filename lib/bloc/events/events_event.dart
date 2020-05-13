
import 'package:equatable/equatable.dart';

abstract class EventsEvent extends Equatable {
  const EventsEvent();
}


class GetEvents extends EventsEvent {

  final startDateTime;
  final endDateTime;  
  const GetEvents({this.startDateTime, this.endDateTime});

  @override
  List<Object> get props => [];
}
