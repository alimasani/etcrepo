import 'package:equatable/equatable.dart';

abstract class FeaturedOffersEvent extends Equatable {
  const FeaturedOffersEvent();
}

class GetFeaturedOffers extends FeaturedOffersEvent {
  final dynamic userProfile;
  const GetFeaturedOffers({this.userProfile});

  @override
  List<Object> get props => [userProfile];
}