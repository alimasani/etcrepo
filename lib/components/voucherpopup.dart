import 'package:etc/helper/globals.dart';
import 'package:flutter/material.dart';
class VoucherPopup extends StatefulWidget {
  final dynamic vItem;
  VoucherPopup({Key key, this.vItem}) : super(key: key);

  @override
  _VoucherPopupState createState() => _VoucherPopupState();
}

class _VoucherPopupState extends State<VoucherPopup> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10.0,20.0,10.0,10.0),
          child: Container(
        padding: EdgeInsets.fromLTRB(10.0,20.0,10.0,10.0),
         decoration: BoxDecoration(
           color:primaryColor,
         ),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children:<Widget>[
           Text("Estimated Saving".toUpperCase(), style:TextStyle(color:Colors.white, fontSize: 16.0, height: 1.3), textAlign: TextAlign.center,),
           Text("A", style:TextStyle(color:Colors.white, fontSize: 16.0, height: 1.3), textAlign: TextAlign.center,)
         ]),
      ),
    );
  }
}