
import 'package:equatable/equatable.dart';

abstract class UsersEvent extends Equatable {
  const UsersEvent();
}


class LoginUser extends UsersEvent {

  final String username;
  final String password;
    
  const LoginUser({this.username, this.password});

  @override
  List<Object> get props => [username,password];
}

class LogoutUser extends UsersEvent {

  const LogoutUser();

  @override
  List<Object> get props => [];
}

