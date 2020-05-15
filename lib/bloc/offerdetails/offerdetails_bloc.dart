import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:etc/helper/methods.dart';
import 'package:etc/helper/services.dart';
import 'package:geolocator/geolocator.dart';

import '../bloc.dart';

class OfferdetailsBloc extends Bloc<OfferdetailsEvent, OfferdetailsState> {

  final Services _services;
  OfferdetailsBloc(this._services); 

  @override
  OfferdetailsState get initialState => OfferdetailsInitial();

  @override
  Stream<OfferdetailsState> mapEventToState(
    OfferdetailsEvent event,
  ) async* {
    if(event is GetOfferDetails){
        var reqParams = {};
        reqParams['outletID'] = event.outletId;
        reqParams['offerID'] = event.offerId;

        Position position = await Geolocator().getCurrentPosition();
        print(position);
        var userloc = {};
        userloc['latitude'] = position.latitude.toString();
        userloc['longitude'] = position.longitude.toString();
        reqParams['userLocation']=userloc;

        print("XXXXXXX");
        print(event.userProfile);
        print("XXXXXXX");
        if(event.userProfile!=null && event.userProfile!=''){
          if(event.userProfile.length>0){
            reqParams['userName']=event.userProfile['userProfile']['userName'];
            reqParams['userID']=event.userProfile['user']['userID'];
          }
        }
        

        var offersList = await _services.getOfferDetails(reqParams);

        var tmpV = offersList['vouchers'];

        for (var v in tmpV){
          v['brandName'] = offersList['offerInfo']['brand']['brandName'];
          v['cluster'] = offersList['outlet']['locality']['cluster'];
          v['outletName'] = offersList['outlet']['outletName'];
          v['outletID'] = offersList['outlet']['outletID'];
          v['offerID'] = offersList['outlet']['offerID'];
          v['offerID'] = offersList['offerInfo']['offerID'];

        }

        var daysArr = ["Sun","Mon","Tue","Wed","Thu","Fri","Sat"];

        var tmp = offersList['outlet']['workingHours']['displayWorkingHours'];

        var workingHrs = [];

        for(var ti in daysArr){
            print(ti);
            // var t = HelperMethods().searchArrayList(tmp, "weekday", "Sun");
            var t = tmp.where((x)=> x['weekday']==ti).toList();
            print(t);
            var val="";
            for(var j=0; j<t.length; j++){
              if(t[j]['startTime']!='CLOSED'){
                  if(val!='') {
                   val = val + ", " + HelperMethods().formatTime(format:"HH:mm",dateTime:t[j]['startTime']) + " to " + HelperMethods().formatTime(format:"HH:mm",dateTime:t[j]['endTime']);
                  }else {
                     val =HelperMethods().formatTime(format:"HH:mm",dateTime:t[j]['startTime']) + " to " + HelperMethods().formatTime(format:"HH:mm",dateTime:t[j]['endTime']);
                  }
              }else {
                val = "CLOSED";
              }
              
            }

            var fo = {};
            fo['weekday']=ti;
            fo['isToday']=t[0]['isToday'];
            fo['time']=val;
            
            workingHrs.add(fo);

        }

        offersList['outlet']['workingHours']['formattedWorkingHrs'] = workingHrs;

        yield OfferdetailsSuccess(offersList);
    }
  }
}
