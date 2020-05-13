part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
}

class GetProfile extends ProfileEvent {

  const GetProfile();

  @override
  List<Object> get props => [];
}
