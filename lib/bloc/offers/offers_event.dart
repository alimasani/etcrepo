import 'package:equatable/equatable.dart';

abstract class OffersEvent extends Equatable {
  const OffersEvent();
}

class GetOffers extends OffersEvent {
  final dynamic data;
  final bool resetList;  
  const GetOffers({this.data,this.resetList});

  @override
  List<Object> get props => [];
}

// class GetFeaturedOffers extends OffersEvent {
    
//   const GetFeaturedOffers();

//   @override
//   List<Object> get props => [];
// }

class FilterOffers extends OffersEvent {
    
  const FilterOffers();

  @override
  List<Object> get props => [];
}

class ChangeOfferDetail extends OffersEvent {
  final List<dynamic> offerList;

  const ChangeOfferDetail(this.offerList);

  @override
  List<String> get props => [];
}
