import 'package:etc/helper/globals.dart';
import 'package:flutter/material.dart';
class NoRecords extends StatelessWidget {
  final String title;
  final String message;
  final String icon;
  const NoRecords({Key key, this.title, this.message, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children:<Widget>[
            Text(title, textAlign: TextAlign.center, style: TextStyle(fontSize: 20.0, color: blueColor, fontWeight: FontWeight.w600),),
            SizedBox(height: 10.0,),
            Text(message, textAlign: TextAlign.center, style: TextStyle(fontSize: 18.0, color: grayColor, fontWeight: FontWeight.w400, height: 1.2),),
            
            
          ]
        ),
      ),
    );
  }
}