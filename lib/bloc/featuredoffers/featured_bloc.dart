import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:etc/bloc/bloc.dart';
import 'package:etc/helper/globals.dart';
import 'package:etc/helper/services.dart';
import 'package:geolocator/geolocator.dart';


class FeaturedOffersBloc extends Bloc<FeaturedOffersEvent, FeaturedOffersState> {

  final Services _services;
  FeaturedOffersBloc(this._services);  

  @override
  FeaturedOffersState get initialState => FeaturedOffersInitial();

  @override
  Stream<FeaturedOffersState> mapEventToState(
    FeaturedOffersEvent event,
  ) async* {
    yield FeaturedOffersLoading();
    if(event is GetFeaturedOffers){
        var reqParams = {};

        print("XXXXXXX");
        print(event.userProfile);
        print("XXXXXXX");
        if(event.userProfile!=null && event.userProfile!=''){
          if(event.userProfile.length>0){
            reqParams['userName']=event.userProfile['userProfile']['userName'];
            reqParams['userID']=event.userProfile['user']['userID'];
          }
        }
        
        reqParams['viewFeaturedOffers']="false";
        Position position = await Geolocator().getCurrentPosition();
        print(position);
        var userloc = {};
        userloc['latitude'] = position.latitude.toString();
        userloc['longitude'] = position.longitude.toString();
        reqParams['userLocation']=userloc;
        print(reqParams);
        final offersList = await _services.getOffers(data:reqParams,start:"1",offset:rowsPerPage);
        yield FeaturedOffersSuccess(offersList);
    }
  }
}
