import 'package:equatable/equatable.dart';

abstract class CategoriesEvent extends Equatable {
  const CategoriesEvent();
}

class GetCategories extends CategoriesEvent {
    
  const GetCategories();

  @override
  List<Object> get props => [];
}
