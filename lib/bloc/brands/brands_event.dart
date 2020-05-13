
import 'package:equatable/equatable.dart';

abstract class BrandsEvent extends Equatable {
  const BrandsEvent();
}


class GetBrands extends BrandsEvent {
    
  const GetBrands();

  @override
  List<Object> get props => [];
}

class GetPopularBrands extends BrandsEvent {
    
  const GetPopularBrands();

  @override
  List<Object> get props => [];
}
