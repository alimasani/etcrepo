import 'package:cached_network_image/cached_network_image.dart';
import 'package:etc/bloc/bloc.dart';
import 'package:etc/components/insiderinfo.dart';
import 'package:etc/components/linedivider.dart';
import 'package:etc/components/loader.dart';
import 'package:etc/components/voucheritem.dart';
import 'package:etc/helper/globals.dart';
import 'package:etc/helper/methods.dart';
import 'package:etc/helper/services.dart';
import 'package:etc/pages/webview.dart';
import 'package:etc/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:getflutter/getflutter.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class OfferDetails extends StatefulWidget {
  final String offerId;
  final String outletId;
  final String outletName;
  OfferDetails({Key key, this.offerId, this.outletId, this.outletName}) : super(key: key);

  @override
  _OfferDetailsState createState() => _OfferDetailsState();
}

class _OfferDetailsState extends State<OfferDetails> {

  var isBookmarked = "false";
  var bookmarkUpdated = "false";

  @override
  void initState() {
    super.initState();
    isBookmarked = "false";
  }
@override
  void dispose() {
    isBookmarked = "false";
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<OfferdetailsBloc>(context)
      ..add(GetOfferDetails(
          outletId: widget.outletId,
          offerId: widget.offerId, userProfile:currentUserProfile));
  }

  void _toggleBookmark(outletID,offerID, context) async {

    var data = {};
    data['outletID'] = outletID;
    data['offerID'] = offerID;

    var bookmark = await Services().toggleBokmark(data:data);

    print(bookmark['desc']);
    bookmarkUpdated = "true";

    Scaffold.of(context).showSnackBar(SnackBar(behavior:SnackBarBehavior.floating,content: Text(bookmark['desc'], textAlign: TextAlign.center,),));

    if(bookmark['desc']=='Bookmark Added Successfully'){
      
      setState(() {
        isBookmarked = "true";
        currentOfferDetails['isBookmarked'] = "true";
      });
      
    }else {
      
      setState(() {
        isBookmarked = "false";
        currentOfferDetails['isBookmarked'] = "false";
      });
    }

  }

  _launchDirections(lat, long) {
    // Position position = await Geolocator().getCurrentPosition();
    //     print(position);
    //     userloc['latitude'] = position.latitude.toString();
    //     userloc['longitude'] = position.longitude.toString();

    var url = "http://maps.google.com?daddr=" +
        lat +
        "," +
        long +
        "&directionsmode=driving";
    launch(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.outletName),
          backgroundColor: primaryColor,
          centerTitle: true,
        ),
        body: BlocBuilder<OfferdetailsBloc, OfferdetailsState>(
            builder: (context, state) {
          if (state is OfferdetailsSuccess) {
            var offerInfo = state.offerdetails;
            var addArray = [offerInfo['outlet']['locality']['location']['locationName'],offerInfo['outlet']['locality']['cluster'],offerInfo['outlet']['locality']['subCluster'],offerInfo['outlet']['locality']['city']['cityName']];
            addArray.removeWhere((v) =>  v==null || v.toLowerCase() == 'null' || v=='' || v.toLowerCase()=='none');
            var address = addArray.join(", ");
            if(bookmarkUpdated=="false") isBookmarked = offerInfo['offerInfo']['isBookmarked'];
            var phone = HelperMethods().searchArray(
                offerInfo['outlet']['communications'],
                "communicationType",
                "Office Phone")['value'];
            var email = HelperMethods().searchArray(
                offerInfo['outlet']['communications'],
                "communicationType",
                "Office Email")['value'];
            var website = HelperMethods().searchArray(
                offerInfo['outlet']['communications'],
                "communicationType",
                "Office Website")['value'];
            return SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // Images Slider
                Container(
                    child: GFCarousel(
                  items: offerInfo['outlet']['displayImages']
                      .map<Widget>((itm) => CachedNetworkImage(imageUrl:itm['imageURL']))
                      .toList(),
                  aspectRatio: 16 / 8,
                  viewportFraction: 1.0,
                  autoPlay: true,
                  reverse: false,
                  pagination: false,
                  passiveIndicator: lightGrayColor,
                  activeIndicator: grayColor,
                  enableInfiniteScroll: true,
                )),
                // nav bar
                BlocBuilder<AuthenticateBloc,AuthenticateState>(builder: (context,state){
                  return Container(
                  height: 50.0,
                  padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                  color: grayColor,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        if (offerInfo['offerInfo']['priceGuideURL'] != null) InkWell(
                              child: Image.asset(
                                "assets/img/icon-menu.png",
                                height: 30.0,
                              ),
                              onTap: () {
                                print(googleDocURL +
                                                offerInfo['offerInfo']
                                                    ['priceGuideURL']);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => OpenWebView(
                                            title: offerInfo['outlet']
                                                ['outletName'],
                                            url: googleDocURL +
                                                offerInfo['offerInfo']
                                                    ['priceGuideURL'])));
                              }),
                        InkWell(
                            child: Image.asset("assets/img/icon-info.png",
                                height: 30.0),
                            onTap: () {
                              showGeneralDialog(
                                  barrierDismissible: false,
                                  barrierColor: Colors.black87,
                                  transitionDuration:
                                      const Duration(milliseconds: 200),
                                  context: context,
                                  pageBuilder: (BuildContext context,
                                      Animation animation,
                                      Animation secondAnimation) {
                                    return Material(
                                      color: Colors.transparent,
                                      child: Container(
                                          margin: EdgeInsets.fromLTRB(
                                              10.0, 0.0, 10.0, 0.0),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                          color: Colors.transparent,
                                          child: Container(
                                            padding: EdgeInsets.fromLTRB(
                                                10.0, 40.0, 0.0, 15.0),
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: <Widget>[
                                                  Expanded(
                                                    child: Column(children: <
                                                        Widget>[
                                                      Text("Insider Knowledge",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 20.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600)),
                                                      SizedBox(
                                                        height: 10.0,
                                                      ),
                                                      Divider(
                                                        color: Colors.white,
                                                        thickness: 1.0,
                                                      ),
                                                      SingleChildScrollView(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .stretch,
                                                          children: _identifierItem(
                                                              offerInfo[
                                                                      'outlet'][
                                                                  'identifiers']),
                                                        ),
                                                      ),
                                                    ]),
                                                  ),
                                                  FlatButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Container(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                0.0,
                                                                12.0,
                                                                0.0,
                                                                12.0),
                                                        child: Text(
                                                          "Done".toUpperCase(),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 16.0,
                                                              height: 1.2,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        )),
                                                    color: primaryColor,
                                                  ),
                                                  SizedBox(height: 10.0),
                                                ]),
                                          )),
                                    );
                                  });
                            }),
                        InkWell(
                            child: Image.asset("assets/img/icon-phone.png",
                                height: 30.0),
                            onTap: () {
                              launch('tel:' + phone);
                            }),
                        InkWell(
                            child: Image.asset("assets/img/icon-email.png",
                                height: 30.0),
                            onTap: () {
                              launch("mailto:" + email);
                            }),
                        InkWell(child: Image.asset((isBookmarked=="false")?"assets/img/icon-star.png":"assets/img/icon-star-active.png", height: 30.0),
                            onTap:(){
                              if(state is! AuthenticateSuccess){
                                Scaffold.of(context).showSnackBar(SnackBar(behavior:SnackBarBehavior.floating,content: Text("Login to favourite this offer.", textAlign: TextAlign.center,),backgroundColor: Colors.red,));
                              }else {
                                _toggleBookmark(offerInfo['outlet']['outletID'],offerInfo['offerInfo']['offerID'],context);
                              }
                            }
                        ),
                        InkWell(
                          child: Image.asset("assets/img/icon-share.png",
                              height: 30.0),
                          onTap: () {
                            Share.share(offerInfo['outlet']['outletName']);
                          },
                        )
                      ]),
                );
                },),
                //Vouchers
                Container(
                  padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: _buildVoucherItem(
                        offerInfo['vouchers'],
                        offerInfo['offerInfo']['validUntil'],
                        offerInfo['offerInfo']['isUserEntitledOffer']),
                    // children:offerInfo['vouchers'].map<Widget>((itm)=>
                    //     Voucheritem(voucherItem: itm,validUntil: offerInfo['offerInfo']['validUntil'])
                    //     // _buildVoucherItem(itm,offerInfo['offerInfo']['validUntil'])

                    // ).toList()
                  ),
                ),

                //Outlet Description
                LineDivider(),
                Container(
                  child: Text(
                    "Outlet Description",
                    style: headingText,
                    textAlign: TextAlign.left,
                  ),
                  margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                    margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                    child: Text(
                      offerInfo['offerInfo']['brand']['brandDescription'],
                      style: contentText,
                      textAlign: TextAlign.justify,
                    )),
                LineDivider(),
                Container(
                  child: Text(
                    "Why we love it",
                    style: headingText,
                    textAlign: TextAlign.left,
                  ),
                  margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                    margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                    child: Text(
                      offerInfo['outlet']['whyWeLoveItTitle'],
                      style: contentTextPurple,
                    )),
                SizedBox(
                  height: 5.0,
                ),
                Container(
                    margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                    child: Text(offerInfo['outlet']['whyWeLoveItMessage'],
                        style: contentText, textAlign: TextAlign.justify)),

                // Map & Address

                Container(
                  padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                  child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(offerInfo['outlet']['outletName'],
                          textAlign: TextAlign.center,
                              style: TextStyle(
                                shadows: [
                                  Shadow(
                                      blurRadius: 10.0,
                                      color: Colors.black,
                                      offset: Offset(2.0, 2.0)),
                                ],
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,
                                height: 1.2,
                              )),
                          Text(
                              address,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  shadows: [
                                    Shadow(
                                        blurRadius: 10.0,
                                        color: Colors.black,
                                        offset: Offset(2.0, 2.0)),
                                  ],
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  height: 1.2)),
                          // (offerInfo['outlet']['locality']['location']['cluster']!='null')?Text(offerInfo['outlet']['locality']['location']['cluster']):Text(""),
                          Text(
                              double.parse(offerInfo['outlet']['locality']
                                          ['distance'])
                                      .toStringAsFixed(2) +
                                  " " +
                                  offerInfo['outlet']['locality']
                                      ['distanceUOM'],
                              style: TextStyle(
                                  shadows: [
                                    Shadow(
                                        blurRadius: 10.0,
                                        color: Colors.black,
                                        offset: Offset(2.0, 2.0)),
                                  ],
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  height: 1.5)),
                        ]),
                  ),
                  margin: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 10.0),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/img/bgMap.png"),
                          fit: BoxFit.cover)),
                ),
                Container(
                    child: Row(
                  children: <Widget>[
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          _launchDirections(
                              offerInfo['outlet']['locality']['location']
                                  ['geoLocation']['latitude'],
                              offerInfo['outlet']['locality']['location']
                                  ['geoLocation']['longitude']);
                        },
                        child: Column(
                          children: <Widget>[
                            Image.asset('assets/img/icon-direction.png',
                                height: 25.0),
                            SizedBox(height: 5.0),
                            Text("Get Directions")
                          ],
                        ),
                      ),
                    ),
                    VerticalDivider(color: grayColor, width: 1.1),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          launch(website);
                        },
                        child: Column(
                          children: <Widget>[
                            Image.asset(
                              'assets/img/icon-web.png',
                              height: 25.0,
                            ),
                            SizedBox(height: 5.0),
                            Text("Visit Website")
                          ],
                        ),
                      ),
                    )
                  ],
                )),
                LineDivider(),
                Container(
                  child: Text(
                    "Opening Hours",
                    style: headingText,
                    textAlign: TextAlign.left,
                  ),
                  margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: offerInfo['outlet']['workingHours']
                          ['formattedWorkingHrs']
                      .map<Widget>((itm) => Container(
                        padding:EdgeInsets.fromLTRB(10.0,10.0,10.0,0.0),
                        child: Row(
                              children: <Widget>[
                                Container(
                                  margin:EdgeInsets.only(right:10.0),
                                  width: 45.0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(
                                      itm['weekday'],
                                      style: (itm['isToday']=='true')?contentTextWhite:contentText,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: primaryColor),
                                    color: (itm['isToday'] == 'true')
                                        ? primaryColor
                                        : Colors.white,
                                  ),
                                ),
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    child: Text(
                                      itm['time'],
                                      style: contentText,
                                    ))
                              ],
                            ),
                      ))
                      .toList(),
                ),
                SizedBox(
                  height: 50.0,
                ),
              ],
            ));
          } else {
            return CustomLoader();
          }
        }));
  }
}

_buildVoucherItem(itm, validity, entitled) {
  // var count = int.parse(itm['instanceCount']);
  List<Widget> list = List<Widget>();
  for (var item in itm) {
    var count = int.parse(item['instanceCount']);
    for (var i = 0; i < count; i++) {
      list.add(Voucheritem(
          voucherItem: item,
          validUntil: validity,
          isUserEntitledOffer: entitled));
    }
  }

  return list;
}

_identifierItem(itm) {
  List<Widget> list = List<Widget>();

  var txtItms =
      HelperMethods().searchArrayList(itm, 'identifierValueType', 'Text');

  for (var i in txtItms) {
    list.add(Container(
        padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(color: Colors.white, width: 0.5))),
        child: RichText(
          text: TextSpan(
              text: i['identifierLabel'] + ": ",
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600),
              children: <TextSpan>[
                TextSpan(
                    text: i['identifierValue'],
                    style: TextStyle(fontWeight: FontWeight.normal))
              ]),
          textAlign: TextAlign.left,
        )));
  }

  var txtBln =
      HelperMethods().searchArrayList(itm, 'identifierValueType', 'boolean');

  for (var i in txtBln) {
    list.add(Container(
        padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(color: Colors.white, width: 0.5))),
        child: Row(
          children: <Widget>[
            CachedNetworkImage(imageUrl:i['lightIconUrl'], width: 24.0),
            SizedBox(
              width: 15.0,
            ),
            Text(
              i['identifierLabel'],
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 15.0),
            )
          ],
        )));
  }
  return list;
}
