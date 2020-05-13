import 'package:equatable/equatable.dart';

abstract class OfferdetailsState extends Equatable {
  const OfferdetailsState();
}

class OfferdetailsInitial extends OfferdetailsState {
  @override
  List<Object> get props => [];
}

class OfferdetailsLoading extends OfferdetailsState {
  const OfferdetailsLoading();
  @override
  List<Object> get props => [];
}

class OfferdetailsSuccess extends OfferdetailsState {
  final dynamic offerdetails;
  const OfferdetailsSuccess([this.offerdetails]);
  @override
  List<Object> get props => [offerdetails];
}

class OfferdetailsError extends OfferdetailsState {
  final String message;
  const OfferdetailsError(this.message);
  @override
  List<Object> get props => [message];
}