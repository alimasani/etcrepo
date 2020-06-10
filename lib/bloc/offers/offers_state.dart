import 'package:equatable/equatable.dart';

abstract class OffersState extends Equatable {
  const OffersState();
}

class OffersInitial extends OffersState {
  const OffersInitial();
  @override
  List<Object> get props => [];
}

class OffersLoading extends OffersState {
  const OffersLoading();
  @override
  List<Object> get props => [];
}

class OffersSuccess extends OffersState {
  final List<dynamic> offers;
  const OffersSuccess([this.offers = const []]);
  @override
  List<Object> get props => [offers];
}

class OfferDetailsSuccess extends OffersState {
  final dynamic offerdetails;
  const OfferDetailsSuccess([this.offerdetails]);
  @override
  List<Object> get props => [offerdetails];
}

class OffersError extends OffersState {
  final String message;
  const OffersError(this.message);
  @override
  List<Object> get props => [message];
}


class OfferChanged extends OffersState {
  final String offerId;
  
  const OfferChanged(this.offerId);

  @override
  List<String> get props => [this.offerId];
}
