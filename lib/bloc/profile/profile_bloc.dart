import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:etc/helper/services.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final Services _services;
  ProfileBloc(this._services);
  
  @override
  ProfileState get initialState => ProfileInitial();

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    if(event is GetProfile){
      yield ProfileLoading();
      try {
        final profile = await _services.getProfile();
        print(profile);
        yield ProfileSuccess(profile);
      }catch (e){
        yield ProfileError(e.toString());
      }
    }
  }
}
