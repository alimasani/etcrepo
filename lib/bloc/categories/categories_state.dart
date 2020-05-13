import 'package:equatable/equatable.dart';
import 'package:etc/models/models.dart';

abstract class CategoriesState extends Equatable {
  const CategoriesState();
}

class CategoriesInitial extends CategoriesState {
  const CategoriesInitial();
  @override
  List<Object> get props => [];
}

class CategoriesLoading extends CategoriesState {
  const CategoriesLoading();
  @override
  List<Object> get props => [];
}

class CategoriesSuccess extends CategoriesState {
  final List<dynamic> categories;
  const CategoriesSuccess([this.categories = const []]);
  @override
  List<Object> get props => [categories];
}

class CategoriesError extends CategoriesState {
  final String message;
  const CategoriesError(this.message);
  @override
  List<Object> get props => [message];
}