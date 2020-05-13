
import 'package:equatable/equatable.dart';

abstract class EventsState extends Equatable {
  const EventsState();
}


class EventsInitial extends EventsState {
  const EventsInitial();
  @override
  List<Object> get props => [];
}

class EventsLoading extends EventsState {
  const EventsLoading();
  @override
  List<Object> get props => [];
}

class EventsSuccess extends EventsState {
  final List<dynamic> events;
  const EventsSuccess([this.events = const []]);
  @override
  List<Object> get props => [events];
}

class EventsError extends EventsState {
  final String message;
  const EventsError(this.message);
  @override
  List<Object> get props => [message];
}