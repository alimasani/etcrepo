import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:etc/bloc/bloc.dart';
import 'package:etc/helper/globals.dart';
import 'package:etc/helper/services.dart';
import 'package:geolocator/geolocator.dart';


class OffersBloc extends Bloc<OffersEvent, OffersState> {

  final Services _services;
  OffersBloc(this._services);  

  @override
  OffersState get initialState => OffersInitial();

  @override
  Stream<OffersState> mapEventToState(
    OffersEvent event,
  ) async* {
    yield OffersLoading();
    if(event is GetOffers){
        var reqParams = event.data??{};
        print("getting current location");
        Position position = await Geolocator().getCurrentPosition();
        print(position);
        var userloc = {};
        userloc['latitude'] = position.latitude.toString();
        userloc['longitude'] = position.longitude.toString();
        reqParams['userLocation']=userloc;
        print(reqParams);
        try{
          final offersList = await _services.getOffers(data:reqParams,start:"1",offset:rowsPerPage);
          yield OffersSuccess(offersList);
        }catch(e){
          yield OffersError(e.toString());
        }
        
    }else if(event is GetFeaturedOffers){
        var reqParam = {};
        reqParam['viewFeaturedOffers']="false";
        final offersList = await _services.getOffers(data:reqParam,start:"1",offset:"3");
        yield OffersSuccess(offersList);
    }
  }
}
