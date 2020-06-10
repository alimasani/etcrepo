import 'dart:async';

import 'package:bloc/bloc.dart';
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

    final currentState = state;

    // yield OffersLoading();
    if(event is GetOffers){
        var reqParams = event.data??{};
        print("getting current location");
        var position = null;

        var permission = await Geolocator().isLocationServiceEnabled();
        print(permission);
        if(permission == false){
          position = null;
        }else {
          position = await Geolocator().getCurrentPosition();
        }
        if(position!=null){
          var userloc = {};
          userloc['latitude'] = position.latitude.toString();
          userloc['longitude'] = position.longitude.toString();
          reqParams['userLocation']=userloc;
        }
        
        try{
          int startPage = 0;
          if(event.resetList == true){
            startPage = 1;
            final offersList = await _services.getOffers(data:reqParams,start:startPage.toString(),offset:rowsPerPage);
            yield OffersSuccess(offersList);
          }else {
            var oList = [];
            if(currentState is OffersSuccess){
              oList = currentState.offers;
            }
            startPage = (oList.length/int.parse(rowsPerPage)).round();
            startPage = startPage + 1;
            final offersList = await _services.getOffers(data:reqParams,start:startPage.toString(),offset:rowsPerPage);
            yield OffersSuccess(oList + offersList);
          }
        }catch(e){
          yield OffersError(e.toString());
        }
        
    }else if(event is GetFeaturedOffers){
        var reqParam = {};
        reqParam['viewFeaturedOffers']="false";
        final offersList = await _services.getOffers(data:reqParam,start:"1",offset:"3");
        yield OffersSuccess(offersList);
    } else if (event is ChangeOfferDetail) {
      var offerList = event.offerList;
      yield OffersSuccess(offerList);
    }
  }
}
