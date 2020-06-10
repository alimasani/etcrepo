import 'package:equatable/equatable.dart';

abstract class FeaturedOffersState extends Equatable {
  const FeaturedOffersState();
}

class FeaturedOffersInitial extends FeaturedOffersState {
  const FeaturedOffersInitial();
  @override
  List<Object> get props => [];
}

class FeaturedOffersLoading extends FeaturedOffersState {
  const FeaturedOffersLoading();
  @override
  List<Object> get props => [];
}

class FeaturedOffersSuccess extends FeaturedOffersState {
  final List<dynamic> offers;
  const FeaturedOffersSuccess([this.offers = const []]);
  @override
  List<Object> get props => [offers];
}

class FeaturedOffersError extends FeaturedOffersState {
  final String message;
  const FeaturedOffersError(this.message);
  @override
  List<Object> get props => [message];
}

class FeaturedOfferChanged extends FeaturedOffersState {
  final String offerId;
  
  const FeaturedOfferChanged(this.offerId);

  @override
  List<String> get props => [this.offerId];
}
