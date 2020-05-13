import 'package:intl/intl.dart';

class HelperMethods {
  
  Map<String,dynamic> searchArray(List<dynamic> arr, String fld, String val){
    return arr.firstWhere((item)=>item[fld]==val, orElse: ()=> {"communicationType":"Office Website","value":""});
  }
  
  List<dynamic> searchArrayList(List<dynamic> arr, String fld, String val){
    return arr.where((item)=> item[fld]==val).toList();
  }

  String formatDateTime({String format, String dateTime}){
    if(dateTime=='' || dateTime==null){
      return dateTime;
    }
     var ndt = DateTime.parse(dateTime);
     return DateFormat(format).format(ndt);
  }
  
  String formatTime({String format, String dateTime}){
     var ndt = DateTime.parse("2020-04-20 " + dateTime);
     return DateFormat(format).format(ndt);
  }
  
  String dateDifference({String startDate, String currentDate}){
     var sd = DateTime.parse(startDate);
     var cd = DateTime.parse(currentDate);
     
     var res = cd.difference(sd);
     if(res.inDays>0){
       return res.inDays.toString() + " d";
     }else if(res.inHours>0){
       return res.inHours.toString() + " h";
     }else if(res.inMinutes>0){
       return res.inMinutes.toString() + " m";
     }else {
       return "";
     } 

  }

  getSequenceArray (int val){
    var newArray = [];
    for(var i=0; i<val; i++){
      newArray.add(i);
    }
    return newArray;
  }

}