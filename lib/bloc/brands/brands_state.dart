import 'package:equatable/equatable.dart';
import 'package:etc/models/models.dart';

abstract class BrandsState extends Equatable {
  const BrandsState();
}

class BrandsInitial extends BrandsState {
  const BrandsInitial();
  @override
  List<Object> get props => [];
}

class BrandsLoading extends BrandsState {
  const BrandsLoading();
  @override
  List<Object> get props => [];
}

class BrandsSuccess extends BrandsState {
  final List<dynamic> brands;
  const BrandsSuccess([this.brands = const []]);
  @override
  List<Object> get props => [brands];
}

class BrandsError extends BrandsState {
  final String message;
  const BrandsError(this.message);
  @override
  List<Object> get props => [message];
}