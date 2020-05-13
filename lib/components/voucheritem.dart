import 'package:etc/components/voucherpopup.dart';
import 'package:etc/helper/globals.dart';
import 'package:etc/helper/methods.dart';
import 'package:etc/theme/style.dart';
import 'package:flutter/material.dart';

class Voucheritem extends StatelessWidget {
  final dynamic voucherItem;
  final String validUntil;
  final String isUserEntitledOffer;
  const Voucheritem({Key key, this.voucherItem, this.validUntil, this.isUserEntitledOffer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formattedDate = HelperMethods()
        .formatDateTime(format: "dd MMM yyyy", dateTime: validUntil);

    return InkWell(
      onTap: () {
        showGeneralDialog(
            barrierDismissible: false,
            barrierColor: Colors.black87,
            transitionDuration: const Duration(milliseconds: 200),
            context: context,
            pageBuilder: (BuildContext context, Animation animation,
                Animation secondAnimation) {
              return Material(
                  color: Colors.transparent,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding:
                                    EdgeInsets.fromLTRB(10.0, 40.0, 0.0, 15.0),
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                ),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      Container(
                                        alignment: Alignment.centerRight,
                                        child: InkWell(
                                            onTap: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Icon(
                                              Icons.close,
                                              color: Colors.white,
                                            )),
                                      ),
                                      Text(
                                        "Estimated Saving".toUpperCase(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.0,
                                            height: 1.3),
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        voucherItem['avgSavings'] + " *",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 26.0,
                                            height: 1.3,
                                            fontWeight: FontWeight.w600),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(height: 5.0),
                                      Divider(
                                        color: Colors.white,
                                      ),
                                      SizedBox(height: 5.0),
                                      Text(
                                        voucherItem['discountType'] +
                                            " " +
                                            voucherItem['voucherName'],
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0,
                                            height: 1.3,
                                            fontWeight: FontWeight.w600),
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        voucherItem['brandName'] +
                                            ", " +
                                            voucherItem['cluster'],
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.0,
                                            height: 1.3,
                                            fontWeight: FontWeight.w300),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                    ]),
                              ),
                              Container(
                                decoration:
                                    BoxDecoration(color: lightGrayColor),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.29,
                                      padding: EdgeInsets.all(10.0),
                                      child: Column(children: <Widget>[
                                        Image.asset(
                                            'assets/img/icon-user-gray.png',
                                            width: 20.0),
                                        Text(
                                          "Valid for",
                                          style: TextStyle(
                                              color: grayColor,
                                              height: 1.4,
                                              fontSize: 13.0),
                                          textAlign: TextAlign.center,
                                        ),
                                        Text(
                                          voucherItem['voucherValidities']
                                              ['validFor'],
                                          style: TextStyle(
                                              color: blueColor,
                                              height: 1.2,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w400),
                                          textAlign: TextAlign.center,
                                        )
                                      ]),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              right: BorderSide(
                                                  color: Colors.black26,
                                                  width: 1.0))),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.29,
                                      padding: EdgeInsets.all(10.0),
                                      child: Column(children: <Widget>[
                                        Image.asset(
                                            'assets/img/icon-timer-gray.png',
                                            width: 20.0),
                                        Text(
                                          "Valid till",
                                          style: TextStyle(
                                              color: grayColor,
                                              height: 1.4,
                                              fontSize: 13.0),
                                          textAlign: TextAlign.center,
                                        ),
                                        Text(
                                          formattedDate,
                                          style: TextStyle(
                                              color: blueColor,
                                              height: 1.2,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w400),
                                          textAlign: TextAlign.center,
                                        )
                                      ]),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              right: BorderSide(
                                                  color: Colors.black26,
                                                  width: 1.0))),
                                    ),
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.29,
                                        padding: EdgeInsets.all(10.0),
                                        child: Column(children: <Widget>[
                                          Image.asset(
                                              'assets/img/icon-chart-gray.png',
                                              width: 20.0),
                                          Text(
                                            "Redemption limit",
                                            style: TextStyle(
                                                color: grayColor,
                                                height: 1.4,
                                                fontSize: 13.0),
                                            textAlign: TextAlign.center,
                                          ),
                                          Text(
                                            voucherItem['voucherValidities']
                                                ['groupRedemptionLimit'],
                                            style: TextStyle(
                                                color: blueColor,
                                                height: 1.2,
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w400),
                                            textAlign: TextAlign.center,
                                          )
                                        ]))
                                  ],
                                ),
                              ),
                              Expanded(
                                                              child: Container(
                                  padding: EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(color: Colors.white),
                                  child: SingleChildScrollView(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      Text("Valid on:",
                                          style: TextStyle(
                                              color: darkGrayColor,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16.0)),
                                      SizedBox(height: 7.0),
                                      Row(children: <Widget>[
                                        Container(child: Text("S", style: TextStyle(color: Colors.white),), margin: EdgeInsets.only(right:5.0), padding:EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 3.0), color: (voucherItem['voucherValidities']['validWeekdays'].contains("Sun"))?primaryColor:Colors.red,),
                                        Container(child: Text("M", style: TextStyle(color: Colors.white),), margin: EdgeInsets.only(right:5.0), padding:EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 3.0), color: (voucherItem['voucherValidities']['validWeekdays'].contains("Mon"))?primaryColor:Colors.red,),
                                        Container(child: Text("T", style: TextStyle(color: Colors.white),), margin: EdgeInsets.only(right:5.0), padding:EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 3.0), color: (voucherItem['voucherValidities']['validWeekdays'].contains("Tue"))?primaryColor:Colors.red,),
                                        Container(child: Text("W", style: TextStyle(color: Colors.white),), margin: EdgeInsets.only(right:5.0), padding:EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 3.0), color: (voucherItem['voucherValidities']['validWeekdays'].contains("Wed"))?primaryColor:Colors.red,),
                                        Container(child: Text("T", style: TextStyle(color: Colors.white),), margin: EdgeInsets.only(right:5.0), padding:EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 3.0), color: (voucherItem['voucherValidities']['validWeekdays'].contains("Thu"))?primaryColor:Colors.red,),
                                        Container(child: Text("F", style: TextStyle(color: Colors.white),), margin: EdgeInsets.only(right:5.0), padding:EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 3.0), color: (voucherItem['voucherValidities']['validWeekdays'].contains("Fri"))?primaryColor:Colors.red,),
                                        Container(child: Text("S", style: TextStyle(color: Colors.white),), margin: EdgeInsets.only(right:5.0), padding:EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 3.0), color: (voucherItem['voucherValidities']['validWeekdays'].contains("Sat"))?primaryColor:Colors.red,),
                                        Container(child: Text("Public Holidays", style: TextStyle(color: Colors.white),), margin: EdgeInsets.only(right:5.0), padding:EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 3.0), color: (voucherItem['voucherValidities']['validOnPublicHolidays']=="true")?primaryColor:Colors.red,),
                                        
                                      ],),
                                      SizedBox(height: 7.0),
                                      Divider(
                                        color: grayColor,
                                      ),
                                      SizedBox(height: 7.0),
                                      Text("What's included:",
                                          style: TextStyle(
                                              color: darkGrayColor,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16.0)),
                                      SizedBox(height: 7.0),
                                      Text(voucherItem['inclusions'],
                                          style: TextStyle(
                                              color: darkGrayColor,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14.0)),
                                      SizedBox(height: 7.0),
                                      Divider(
                                        color: grayColor,
                                      ),
                                      SizedBox(height: 7.0),
                                      Text("What's not included:",
                                          style: TextStyle(
                                              color: darkGrayColor,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16.0)),
                                      SizedBox(height: 7.0),
                                      Text(voucherItem['exclusions'],
                                          style: TextStyle(
                                              color: darkGrayColor,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15.0)),
                                      SizedBox(height: 7.0),
                                      Divider(
                                        color: grayColor,
                                      ),
                                      SizedBox(height: 7.0),
                                      Text("The fine print:",
                                          style: TextStyle(
                                              color: darkGrayColor,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16.0)),
                                      SizedBox(height: 7.0),
                                      finePrintText(voucherItem['voucherTandCs']),
                                      SizedBox(height: 7.0),
                                      Divider(
                                        color: grayColor,
                                      ),
                                      SizedBox(height: 7.0),
                                      Text(
                                          "* " +
                                              voucherItem[
                                                  'avgSavingsDescription'],
                                          style: TextStyle(
                                              color: darkGrayColor,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15.0)),
                                    ],
                                  )),
                                ),
                              ),
                              SizedBox(height:5.0),
                            ],
                          ),
                        ),
                        FlatButton(
                          onPressed: () {},
                          child: Container(
                              padding:EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 12.0),
                              child: Text(
                                "Redeem Now".toUpperCase(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    height: 1.2,
                                    fontWeight: FontWeight.w600),
                              )),
                          color: blueColor,
                        ),
                        SizedBox(height:10.0),
                      ],
                    ),
                  ));
            });
      },
      child: Container(
        height: 70.0,
        margin: EdgeInsets.fromLTRB(0, 5.0, 0, 5.0),
        child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0)),
            elevation: 0.0,
            margin: EdgeInsets.all(0.0),
            color: Colors.white,
            child: Row(
              children: <Widget>[
                Container(
                  height: 70.0,
                  width: 60.0,
                  padding: EdgeInsets.all(0.0),
                  child: Center(
                    child: Text(
                      voucherItem['discountType'],
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          height: 1.2,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  decoration: BoxDecoration(color: blueColor),
                ),
                Expanded(
                  child: Container(
                    height: 70.0,
                    padding: EdgeInsets.fromLTRB(7.0, 4.0, 5.0, 2.0),
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(color: lightGrayColor),
                    child: Stack(
                                          children:<Widget>[
                                            Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Text(
                              voucherItem['voucherName'],
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.w600,
                                  height: 1.3),
                            ),
                            Text(
                              voucherItem['voucherValidities']
                                      ['validForDescription'] +
                                  " until " +
                                  formattedDate,
                              style: TextStyle(
                                fontSize: 13.0,
                                height: 1.4,
                              ),
                            ),
                            Text(
                              voucherItem['voucherValidities']
                                  ['groupRedemptionLimitDescription'],
                              style: TextStyle(
                                fontSize: 13.0,
                                height: 1.4,
                              ),
                            ),
                            
                          ]),
                          Align(
                            alignment: Alignment(1,0.90),
                            child: Container(
                              padding:EdgeInsets.fromLTRB(4.0, 2.0,4.0, 2.0),
                              decoration: BoxDecoration(
                                color:blueColor
                              ),
                              child: Text("Reedem", style: TextStyle(color:Colors.white, fontSize: 12.0, fontWeight: FontWeight.w300),),) ,)                ] 
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}

Widget finePrintText(List<dynamic> strings) {
  return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: strings
          .map((item) => Text("• " + item['tcText'],
              style: TextStyle(
                  color: darkGrayColor,
                  height: 1.2,
                  fontWeight: FontWeight.w400,
                  fontSize: 13.0)))
          .toList());
}
