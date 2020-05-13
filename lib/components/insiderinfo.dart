import 'package:flutter/material.dart';

class InsiderInfo extends StatelessWidget {
  final dynamic data;
  const InsiderInfo({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      elevation: 0.0,
      // backgroundColor: Colors.transparent,
      contentPadding: EdgeInsets.all(0.0),
          children:<Widget> [Container(
            width: 320.0,
        child: Column(
          children: <Widget>[
              Text("Insider Knowledge",style:TextStyle(color:Colors.white, fontSize:16.0, fontFamily: 'Proxima Nova Soft'), textAlign: TextAlign.center,)
          ],
        ),
      ),]
    );
  }
}
