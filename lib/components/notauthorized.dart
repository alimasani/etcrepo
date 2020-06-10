import 'package:etc/helper/globals.dart';
import 'package:flutter/material.dart';
class NotAuthorized extends StatelessWidget {
  const NotAuthorized({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children:<Widget>[
            Icon(Icons.lock, color: grayColor, size: 40.0,),
            SizedBox(height:40.0),
            Text("Oops! It seems you are not logged-in", textAlign: TextAlign.center, style: TextStyle(fontSize: 20.0, color: blueColor),),
            SizedBox(height:40.0),
            FlatButton(
                      onPressed: () {
                          Navigator.of(context).pushNamed('/login');
                      },
                      child: Container(
                          padding:EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 12.0),
                          child: Text(
                            "LOGIN".toUpperCase(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                height: 1.2,
                                fontWeight: FontWeight.w600),
                          )),
                      color: blueColor,
                    )
          ]
        ),
      ),
    );
  }
}