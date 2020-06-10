import 'dart:convert';

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

  String maskEmail(email){
    if (email == "") {

            return email;

        } else {
            var tmp = email.split("@");
            var email1 = tmp[0];
            var email2 = tmp[1].split(".");
            var emailDomain = email2[0];
            var emailExt = email2[1];

            var maskStr = email1.substring(2).replaceAll(RegExp(r"[a-zA-Z0-9_]"), '*');
            var maskDomain = emailDomain.substring(1).replaceAll(RegExp(r"[a-zA-Z0-9_]"), '*');

            return email1.substring(0, 2) + maskStr + "@" + emailDomain.substring(0, 1) + maskDomain + "." + emailExt;

        }
  }

  getSequenceArray (int val){
    var newArray = [];
    for(var i=0; i<val; i++){
      newArray.add(i);
    }
    return newArray;
  }

  bool isValidEmail(String em) {

    String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }

  printJson (json){
    JsonEncoder encoder = new JsonEncoder.withIndent('  ');
    String prettyprint = encoder.convert(json);
    print(prettyprint);
  }

}