import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:etc/helper/services.dart';

import '../bloc.dart';

class BrandsBloc extends Bloc<BrandsEvent, BrandsState> {
  
  final Services _services;
  BrandsBloc(this._services);

  @override
  BrandsState get initialState => BrandsInitial();

  @override
  Stream<BrandsState> mapEventToState(
    BrandsEvent event,
  ) async* {
    yield BrandsLoading();
    if(event is GetBrands){
        final brandsList = await _services.getBrands(null);
        yield BrandsSuccess(brandsList);
    }else if(event is GetPopularBrands){
        var reqParam = {};
        reqParam['viewPopularBrands']="true";
        final brandsList = await _services.getBrands(reqParam);
        yield BrandsSuccess(brandsList);
    }
  }
}
