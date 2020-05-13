import 'package:etc/bloc/authenticate/authenticate_bloc.dart';
import 'package:etc/bloc/bloc.dart';
import 'package:etc/components/idcard.dart';
import 'package:etc/components/linedivider.dart';
import 'package:etc/components/loader.dart';
import 'package:etc/components/notauthorized.dart';
import 'package:etc/helper/globals.dart';
import 'package:etc/helper/methods.dart';
import 'package:etc/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getflutter/getflutter.dart';


class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<AuthenticateBloc>(context)..add(AppStarted());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticateBloc, AuthenticateState>(
        builder: (context, state) {
       if (state is AuthenticateSuccess) {
        final profile = state.profile;

                  final subscribedFrom = HelperMethods().formatDateTime(format:"dd MMM yyyy HH:mm",dateTime:profile['subscription']['subscriptionStartDateTime']);
                  final expiresOn = HelperMethods().formatDateTime(format:"dd MMM yyyy HH:mm",dateTime:profile['subscription']['subscriptionEndDateTime']);

                  return SingleChildScrollView(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 30.0),
                        child: IDCard(profile:profile),
                        color: primaryColor,
                      ),
                      Container(
                          padding: EdgeInsets.all(15.0),
                          color: lightGrayColor,
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.30,
                                padding: EdgeInsets.only(left: 5.0, right: 5.0),
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      "Redemptions",
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          color: grayColor,
                                          height: 1.2),
                                    ),
                                    Text(
                                      profile['redemptionCount'],
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w600,
                                          color: blueColor,
                                          height: 1.5),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.30,
                                padding: EdgeInsets.only(left: 5.0, right: 5.0),
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      "Avg. Savings",
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          color: grayColor,
                                          height: 1.2),
                                    ),
                                    Text(
                                      profile['userSavings'],
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w600,
                                          color: blueColor,
                                          height: 1.5),
                                    )
                                  ],
                                ),
                              )
                            ],
                          )),
                      Container(
                        child: Text(
                          "Subscription Details",
                          style: headingText,
                          textAlign: TextAlign.left,
                        ),
                        margin: EdgeInsets.all(10.0),
                      ),
                      Container(
                        margin: EdgeInsets.all(10.0),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Plan",
                                    style: TextStyle(color: grayColor)),
                                Text(
                                    profile['subscription']['subscriptionPlan']
                                        ['subscriptionPlanName'],
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600,
                                        color: blueColor,
                                        height: 1.5))
                              ],
                            ),
                            Divider(
                              color: grayColor,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Subscribed From",
                                    style: TextStyle(color: grayColor)),
                                Text(
                                    subscribedFrom,
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600,
                                        color: blueColor,
                                        height: 1.5))
                              ],
                            ),
                            Divider(
                              color: grayColor,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Expires On",
                                    style: TextStyle(color: grayColor)),
                                Text(
                                    expiresOn,
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600,
                                        color: blueColor,
                                        height: 1.5))
                              ],
                            ),
                            Divider(
                              color: grayColor,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Status",
                                    style: TextStyle(color: grayColor)),
                                Text(
                                    profile['subscription']
                                        ['subscriptionStatus'],
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600,
                                        color: blueColor,
                                        height: 1.5))
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10.0),
                        color: lightGrayColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                                width: MediaQuery.of(context).size.width * 0.27,
                                padding:
                                    EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 30.0),
                                color: Colors.white,
                                child: Column(children: <Widget>[
                                  Stack(
                                    children: <Widget>[
                                    
                                  Center(
                                    child: Icon(
                                      Icons.notifications,
                                      color: blueColor,
                                      size: 38.0,
                                    ),
                                  ),
                                    (int.parse(profile['unreadNotificationCount'])>0)?Align(
                                    child: Container(
                                      child: Center(child: Text(profile['unreadNotificationCount'], style: TextStyle(color:Colors.white, fontWeight:FontWeight.w600), textAlign: TextAlign.center,)),
                                      
                                      width:20.0,
                                      height:20.0,
                                      alignment: Alignment.topCenter,
                                      decoration: BoxDecoration(
                                        shape:BoxShape.circle,
                                        color:Colors.red,
                                      ),
                                    ),
                                    alignment: Alignment(0.3,1),
                                  ):Container(child:null),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text("Notifications")
                                ])),
                            Container(
                                width: MediaQuery.of(context).size.width * 0.27,
                                padding:
                                    EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 30.0),
                                color: Colors.white,
                                child: Column(children: <Widget>[
                                  Icon(
                                    Icons.account_balance_wallet,
                                    color: blueColor,
                                    size: 38.0,
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text("Transactions")
                                ])),
                            Container(
                                width: MediaQuery.of(context).size.width * 0.27,
                                padding:
                                    EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 30.0),
                                color: Colors.white,
                                child: Column(children: <Widget>[
                                  Icon(
                                    Icons.sentiment_very_satisfied,
                                    color: blueColor,
                                    size: 38.0,
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text("Personal Info")
                                ]))
                          ],
                        ),
                      )
                    ],
                  ));
      }else {
        return NotAuthorized();
      }
    });
  }
}
