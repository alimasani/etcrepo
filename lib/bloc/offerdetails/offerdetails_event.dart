
import 'package:equatable/equatable.dart';

abstract class OfferdetailsEvent extends Equatable {
  const OfferdetailsEvent();
}

class GetOfferDetails extends OfferdetailsEvent {
  final String offerId;
  final String outletId;
  final dynamic userProfile;
  const GetOfferDetails({this.outletId,this.offerId,this.userProfile});

  @override
  List<Object> get props => [];
}