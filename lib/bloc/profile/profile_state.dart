part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
}

class ProfileInitial extends ProfileState {
  @override
  List<Object> get props => [];
}

class ProfileLoading extends ProfileState {
  const ProfileLoading();
  @override
  List<Object> get props => [];
}

class ProfileSuccess extends ProfileState {
  final dynamic profile;
  const ProfileSuccess([this.profile = const []]);
  @override
  List<Object> get props => [profile];
}

class ProfileError extends ProfileState {
  final String message;
  const ProfileError(this.message);
  @override
  List<Object> get props => [message];
}