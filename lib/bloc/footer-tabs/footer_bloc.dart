import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:etc/bloc/bloc.dart';
import 'package:etc/models/models.dart';

class FooterBloc extends Bloc<FooterEvent, AppTab> {
  @override
  AppTab get initialState => AppTab.home;

  @override
  Stream<AppTab> mapEventToState(FooterEvent event) async* {
    if (event is TabUpdated) {
      yield event.tab;
    }
  }
}