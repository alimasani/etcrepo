import 'package:etc/helper/globals.dart';
import 'package:etc/helper/methods.dart';
import 'package:flutter/material.dart';
class EventItem extends StatelessWidget {
  final dynamic eItem;
  const EventItem({Key key, this.eItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20.0,10.0,20.0,10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
        Container(
          width:45.0, 
          padding: EdgeInsets.all(7.0),
          decoration: BoxDecoration(
            border:Border.all(color:blueColor),
            borderRadius: BorderRadius.all(Radius.circular(7.0))

          ),
          child:Text(HelperMethods().formatDateTime(format:"dd",dateTime:eItem['date']),style: TextStyle(fontSize:20.0), textAlign: TextAlign.center,)
        ),
        Expanded(
          
                  child: Container(
                    margin:EdgeInsets.only(left:10.0),
                    child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
            Text(eItem['eventTitle'], style:TextStyle(fontSize:16.0, fontWeight:FontWeight.w600, height:1.3)),
            Text(eItem['eventText'],style:TextStyle(fontSize:14.0,height:1.3)),
          ],),
                  ),
        )
      ],),
    );
  }
}