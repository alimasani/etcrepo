import 'package:etc/helper/globals.dart';
import 'package:etc/helper/methods.dart';
import 'package:etc/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class IDCard extends StatelessWidget {
  final dynamic profile;
  const IDCard({Key key, this.profile}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 5.0),
                  Text(
                    "Expats Teacher Club",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 10.0),
                  Container(
                      width: 170.0,
                      height: 160.0,
                      child: Image.network(
                        profile['userProfile']['linkReferences'][0]['link'],
                        width: 170.0,
                        height: 160.0,
                        fit: BoxFit.cover,
                      )),
                  SizedBox(height: 5.0),
                  Text(
                    profile['userProfile']['primaryEmail'],
                    style: offerInfoWhite,
                    textAlign: TextAlign.center,
                  )
                ]),
          ),
          Container(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "assets/img/logo-white.png",
                    width: 100.0,
                  ),
                  SizedBox(height: 10.0),
                  Text(
                      profile['userProfile']['firstName'] +
                          ' ' +
                          profile['userProfile']['lastName'],
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600)),
                  Text('ID: ' + profile['user']['membershipID'],
                      style: TextStyle(color: Colors.white, fontSize: 14.0)),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text('Member Since',
                      style: TextStyle(color: Colors.white, fontSize: 14.0)),
                  Text(HelperMethods().formatDateTime(format:"dd MMM yyyy HH:mm",dateTime:profile['user']['memberSince']),
                      style: TextStyle(color: Colors.white, fontSize: 14.0)),
                  SizedBox(
                    height: 10.0,
                  ),
                  QrImage(
                    data: profile['user']['membershipID'],
                    version: QrVersions.auto,
                    size: 100.0,
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.all(10.0),
                  ),
                ]),
          )
        ],
      ),
      height: 230.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: blueColor,
      ),
    );
  }
}
