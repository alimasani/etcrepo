import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:etc/helper/globals.dart';
import 'package:etc/helper/services.dart';

part 'authenticate_event.dart';
part 'authenticate_state.dart';

class AuthenticateBloc extends Bloc<AuthenticateEvent, AuthenticateState> {

  final Services _services;
  AuthenticateBloc(this._services);

  @override
  AuthenticateState get initialState => AuthenticateInitial();

  @override
  Stream<AuthenticateState> mapEventToState(
    AuthenticateEvent event,
  ) async* {

    if(event is AppStarted){
      final status = await _services.getLocalStorage(key:"authToken");
      if(status!=null && status!=''){

        try{
          final profile = await _services.getProfile();
          print(profile);
          currentUserProfile = profile;
          yield AuthenticateSuccess(profile);
        }catch (e){
          print (e);
          currentUserProfile = null;
          yield AuthenticateError();
        }
        
      }else {
        currentUserProfile = null;
        yield AuthenticateError();
      }
    }

    if(event is LoggedIn){
      yield AuthenticateSuccess();
    }

    if(event is LoggedOut){
      currentUserProfile = null;
      yield AuthenticateError();
    }

  }
}
