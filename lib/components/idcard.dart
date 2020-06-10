import 'package:cached_network_image/cached_network_image.dart';
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
                        fontSize: 17.0,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 10.0),
                  Container(
                      width: 130.0,
                      height: 120.0,
                      child: CachedNetworkImage(
                        imageUrl:profile['userProfile']['linkReferences'][0]['link'],
                        width: 130.0,
                        height: 120.0,
                        fit: BoxFit.fitWidth,
                      )),
                  SizedBox(height: 5.0),
                  Text(
                    profile['userProfile']['userName'],
                    style: offerInfoWhite,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    profile['userProfile']['primaryMobile'],
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
                    width: 90.0,
                  ),
                  SizedBox(height: 10.0),
                  Text(
                      profile['userProfile']['firstName'] +
                          ' ' +
                          profile['userProfile']['lastName'],
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600)),
                  Text('ID: ' + profile['user']['membershipID'],
                      style: TextStyle(color: Colors.white, fontSize: 12.0)),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text('Member Since',
                      style: TextStyle(color: Colors.white, fontSize: 12.0)),
                  Text(HelperMethods().formatDateTime(format:"dd MMM yyyy HH:mm",dateTime:profile['user']['memberSince']),
                      style: TextStyle(color: Colors.white, fontSize: 12.0)),
                  SizedBox(
                    height: 10.0,
                  ),
                  QrImage(
                    data: profile['user']['membershipID']+":"+profile['user']['memberSince']+":"+profile['userProfile']['firstName'] +' ' +profile['userProfile']['lastName']+":"+profile['userProfile']['primaryEmail']+":"+profile['userProfile']['primaryMobile']+":"+profile['userProfile']['linkReferences'][0]['link'],
                    version: QrVersions.auto,
                    size: 90.0,
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.all(7.0),
                  ),
                ]),
          )
        ],
      ),
      height: 210.0,
      decoration: BoxDecoration(
        border:Border.all(color: Colors.white60),
        borderRadius: BorderRadius.circular(15.0),
        color: blueColor,
        image: DecorationImage(
                image: AssetImage("assets/img/card-bg.jpg"), fit: BoxFit.cover)
      ),
    );
  }
}
