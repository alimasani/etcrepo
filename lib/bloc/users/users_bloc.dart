import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:etc/helper/services.dart';

import '../bloc.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final Services services;
  final AuthenticateBloc authenticateBloc;
  UsersBloc({this.services, this.authenticateBloc});

  @override
  UsersState get initialState => UsersInitial();

  @override
  Stream<UsersState> mapEventToState(
    UsersEvent event,
  ) async* {
    if (event is LoginUser) {
      yield UsersLoading();
      try {
        final user = await services.userLogin(
            username: event.username, password: event.password);
        print(user);
        final saveToken = await services.saveLocalStorage(
            key: "authToken", auth: user['desc']);
            print("--");
        print(await services.getLocalStorage(key:'authToken'));
        print("--");
        authenticateBloc.add(AppStarted());    
        yield UsersSuccess(user['desc']);
      } catch (e) {
        yield UsersError(e.toString());
      }
    }

    if(event is LogoutUser){
      try {
        final user = await services.logoutUser();
        final removeToken = await services.deleteLocalStorage(key:"authToken");
        authenticateBloc.add(AppStarted());
      }catch (e){
        authenticateBloc.add(AppStarted());
      }
      
    }
  }
}
