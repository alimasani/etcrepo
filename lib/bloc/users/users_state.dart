import 'package:equatable/equatable.dart';

abstract class UsersState extends Equatable {
  const UsersState();
}

class UsersInitial extends UsersState {
  const UsersInitial();
  @override
  List<Object> get props => [];
}

class UsersLoading extends UsersState {
  const UsersLoading();
  @override
  List<Object> get props => [];
}

class UsersSuccess extends UsersState {
  final dynamic Users;
  const UsersSuccess([this.Users = const []]);
  @override
  List<Object> get props => [Users];
}

class UsersError extends UsersState {
  final String message;
  const UsersError(this.message);
  @override
  List<Object> get props => [message];
}