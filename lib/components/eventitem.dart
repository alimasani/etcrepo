import 'package:etc/helper/globals.dart';
import 'package:etc/helper/methods.dart';
import 'package:flutter/material.dart';
class EventItem extends StatelessWidget {
  final dynamic eItem;
  const EventItem({Key key, this.eItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(00.0,10.0,00.0,10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
        Container(
          width:45.0, 
          padding: EdgeInsets.all(7.0),
          decoration: BoxDecoration(
            border:Border.all(color:darkGrayColor),
            borderRadius: BorderRadius.all(Radius.circular(7.0))

          ),
          child:Column(
            children:<Widget>[
               Text(HelperMethods().formatDateTime(format:"dd",dateTime:eItem['startDateTime']),style: TextStyle(fontSize:20.0, height:1.2), textAlign: TextAlign.center,) ,
               Text(HelperMethods().formatDateTime(format:"MMM",dateTime:eItem['startDateTime']),style: TextStyle(fontSize:12.0, height:1.2), textAlign: TextAlign.center,) 
            ]
          )
        ),
        Expanded(
          
                  child: Container(
                    margin:EdgeInsets.only(left:10.0),
                    child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
            Text(eItem['eventTitle'], style:TextStyle(fontSize:16.0, fontWeight:FontWeight.w600, height:1.3)),
            Text(eItem['eventText'],style:TextStyle(fontSize:14.0,height:1.3)),
            RichText(
              text: TextSpan(text: "From: ",
              style: TextStyle(color:grayColor, fontWeight: FontWeight.w600),
              children:<TextSpan>[
              TextSpan(text:HelperMethods().formatDateTime(format:"dd MMM yyyy HH:mm",dateTime:eItem['startDateTime']), style: TextStyle(fontWeight: FontWeight.w400)),
              TextSpan(text:" To: ", style: TextStyle(fontWeight: FontWeight.w600)),
              TextSpan(text:HelperMethods().formatDateTime(format:"dd MMM yyyy HH:mm",dateTime:eItem['endDateTime']), style: TextStyle(fontWeight: FontWeight.w400)),
              
            ])),
          ],),
                  ),
        )
      ],),
      decoration: BoxDecoration(
        border:Border(bottom: BorderSide(color: Colors.black12))
      ),
      padding: EdgeInsets.only(bottom:20.0, left:20.0, right:20.0),
    );
  }
}