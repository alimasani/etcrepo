part of 'authenticate_bloc.dart';

abstract class AuthenticateEvent extends Equatable {
  const AuthenticateEvent();
}

class AppStarted extends AuthenticateEvent {
    
  const AppStarted();

  @override
  List<Object> get props => [];
}

class LoggedIn extends AuthenticateEvent {
    
  const LoggedIn();

  @override
  List<Object> get props => [];
}

class LoggedOut extends AuthenticateEvent {
    
  const LoggedOut();

  @override
  List<Object> get props => [];
}