import 'package:etc/helper/globals.dart';
import 'package:etc/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:etc/helper/methods.dart';

class OfferItem extends StatelessWidget {
  final dynamic offerItem;
  const OfferItem({Key key, this.offerItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formattedDate = HelperMethods().formatDateTime(
        format: "dd MMM yyyy", dateTime: offerItem['offerInfo']['validUntil']);

    return Container(
      padding: EdgeInsets.all(0.0),
      margin: EdgeInsets.fromLTRB(0, 5.0, 0, 5.0),
      constraints: BoxConstraints.expand(height: 100.0),
      child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
          elevation: 0.0,
          margin: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 2.0),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                  height: 100.0,
                  width: 100.0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(0, 0, 0, 0.7),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0)),
                    ),
                    child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          children: <Widget>[
                            Container(
                              height: 60.0,
                              child: Image.network(offerItem['offerInfo']
                                  ['brand']['brandLogoURL']),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                              child: Stack(children: <Widget>[
                                Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        offerItem['outlet']['displayName'],
                                        style: offerTitleWhite,
                                        textAlign: TextAlign.left,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Text(
                                        offerItem['outlet']['displayInfo'],
                                        style: offerInfoWhite,
                                        textAlign: TextAlign.left,
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    ],
                                  ),
                                ),
                                Positioned(
                                  bottom: 0.0,
                                  right: 0.0,
                                  child: Column(children: <Widget>[
                                    Image.asset(
                                      'assets/img/' +
                                          offerItem['offerInfo']
                                                  ['subscriptionTypes'][0]
                                              .toLowerCase() +
                                          '.png',
                                      width: 20.0,
                                    ),
                                    Text(
                                      offerItem['offerInfo']
                                          ['subscriptionTypes'][0],
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10.0,
                                          height: 1.2),
                                    )
                                  ]),
                                ),
                                Positioned(
                                    top: 0.0,
                                    right: 0.0,
                                    child: Row(
                                      children: <Widget>[
                                          (offerItem['offerInfo']['isBookmarked']=="true")?Image.asset('assets/img/icon-star-active.png', width: 25.0,):Container(child:null),
                                          (offerItem['offerInfo']['isNewOffer']=="true")?Image.asset('assets/img/new.png', width: 25.0,):Container(child:null),
                                          (offerItem['offerInfo']['isUserEntitledOffer']=="false")?Image.asset('assets/img/lock.png', width: 20.0,):Container(child:null),
                                      ],
                                    ))
                              ]),
                            )
                          ],
                        )),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0)),
                      image: DecorationImage(
                          image: NetworkImage(
                              offerItem["outlet"]["defaultDisplayImage"]),
                          fit: BoxFit.cover))),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Color(0xFFebebeb)),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 0.29,
                        child: Column(children: <Widget>[
                          Text(
                            "kms away",
                            style: TextStyle(
                                fontWeight: FontWeight.w200, height: 1.2),
                          ),
                          Text(
                            offerItem['outlet']['locality']['distance'],
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: blueColor,
                                height: 1.2),
                          )
                        ]),
                        decoration: BoxDecoration(
                            border: Border(
                                right: BorderSide(
                                    color: Colors.black26, width: 1.0))),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.29,
                        child: Column(children: <Widget>[
                          Text(
                            "valid until",
                            style: TextStyle(
                                fontWeight: FontWeight.w200, height: 1.2),
                          ),
                          Text(
                            formattedDate,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: blueColor,
                                height: 1.2),
                          )
                        ]),
                        decoration: BoxDecoration(
                            border: Border(
                                right: BorderSide(
                                    color: Colors.black26, width: 1.0))),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.29,
                        child: Column(children: <Widget>[
                          Text(
                            "avg. savings",
                            style: TextStyle(
                                fontWeight: FontWeight.w200, height: 1.2),
                          ),
                          Text(
                            offerItem['offerInfo']['maxAvgSavings'],
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: blueColor,
                                height: 1.2),
                          )
                        ]),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
