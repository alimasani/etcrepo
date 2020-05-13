import 'package:etc/helper/globals.dart';
import 'package:flutter/material.dart';
class LineDivider extends StatelessWidget {
  const LineDivider({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
                  height: 15.0,     
                ),
        Divider(height: 2.0, color: grayColor,),
        SizedBox(
                  height: 15.0,     
                ),
      ],
    );
  }
}