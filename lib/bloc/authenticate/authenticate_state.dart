part of 'authenticate_bloc.dart';

abstract class AuthenticateState extends Equatable {
  const AuthenticateState();
}

class AuthenticateInitial extends AuthenticateState {
  @override
  List<Object> get props => [];
}

class AuthenticateLoading extends AuthenticateState {
  @override
  List<Object> get props => [];
}

class AuthenticateSuccess extends AuthenticateState {
  final dynamic profile;
  const AuthenticateSuccess([this.profile = const []]);
  @override
  List<Object> get props => [profile];
}

class AuthenticateError extends AuthenticateState {
  @override
  List<Object> get props => [];
}
