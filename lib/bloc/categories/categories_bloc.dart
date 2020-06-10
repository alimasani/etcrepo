import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:etc/helper/globals.dart';
import 'package:etc/helper/services.dart';

import '../bloc.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final Services _services;
  CategoriesBloc(this._services);

  @override
  CategoriesState get initialState => CategoriesInitial();

  @override
  Stream<CategoriesState> mapEventToState(
    CategoriesEvent event,
  ) async* {
    yield CategoriesLoading();
    if(event is GetCategories){
        final catList = await _services.getCategories(null);
        gCategories = catList.map((s){
          s['selected']=false;
          return s;
        });
        yield CategoriesSuccess(catList);
    }
  }
}
