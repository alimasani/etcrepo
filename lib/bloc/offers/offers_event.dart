import 'package:equatable/equatable.dart';

abstract class OffersEvent extends Equatable {
  const OffersEvent();
}

class GetOffers extends OffersEvent {
  final dynamic data;  
  const GetOffers({this.data});

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
