import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:etc/helper/app_exaptions.dart';
import 'package:etc/helper/globals.dart';
import 'package:etc/helper/services.dart';

import '../bloc.dart';

class EventsBloc extends Bloc<EventsEvent, EventsState> {

  final Services _services;
  EventsBloc(this._services);

  @override
  EventsState get initialState => EventsInitial();

  @override
  Stream<EventsState> mapEventToState(
    EventsEvent event,
  ) async* {
    yield EventsLoading();
    if(event is GetEvents){
        try {
          var params = {};
        params['startDateTime']=event.startDateTime;
        params['endDateTime']=event.endDateTime;
        final eveList = await _services.getEvents(data:params,start:"0",offset:rowsPerPage);
        // var newList = [];
        // int j =0;
        
        // for(var k=0; k<eveList.length;k++){
          
        //   var eve = eveList[k];
          
        //   var eveDays = DateTime.parse(eve['endDateTime']).difference(DateTime.parse(eve['startDateTime'])).inDays;  

        //   for(var i=0; i<(eveDays+1); i++){
        //         var newObj= {};    
        //         newObj["eventID"] = eve["eventID"];
        //         newObj["eventTitle"] = eve["eventTitle"];
        //         newObj["eventText"] = eve["eventText"];
        //         newObj["eventImage"] = eve["eventImage"];
        //         newObj["startDateTime"] = eve["startDateTime"];
        //         newObj["endDateTime"] = eve["endDateTime"];
        //         newObj['date']=DateTime.parse(eve['startDateTime']).add(Duration(days:i)).toString();
        //         newList.add(newObj);
        //     }
        // }  

        yield EventsSuccess(eveList);
        }on BadRequestException {
          yield EventsError("No Records Found");
        }on UnauthorisedException {
          yield EventsError("Unauthorized Access");
        }on NotFoundException {
          yield EventsError("URL not found");
        }
    }
  }
}
