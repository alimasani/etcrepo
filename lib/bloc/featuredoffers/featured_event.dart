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

class ChangeFeaturedOfferDetail extends FeaturedOffersEvent {
  final List<dynamic> offerList;

  const ChangeFeaturedOfferDetail(this.offerList);

  @override
  List<String> get props => [];
}
