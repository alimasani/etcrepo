import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:etc/bloc/authenticate/authenticate_bloc.dart';
import 'package:etc/bloc/bloc.dart';
import 'package:etc/helper/globals.dart';
import 'package:etc/helper/services.dart';
import 'package:etc/pages/webview.dart';
import 'package:flutter/material.dart';
import 'package:etc/theme/style.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:launch_review/launch_review.dart';


class SideMenu extends StatefulWidget {
  SideMenu({Key key}) : super(key: key);

  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  List<Color> _gradients = [primaryColor, primaryColor]; //blueColor
  
  _doLogout() async {
      
      final user = await Services().logoutUser();
      final removeToken = await Services().deleteLocalStorage(key:"authToken");
      
      BlocProvider.of<AuthenticateBloc>(context).add(
        LoggedOut()
      );
      setState(() {});
  }
  _gotoLogin(){
    Navigator.pushNamed(context, '/login');                        
  }

  _openStore(android,ios){
    if(Platform.isIOS){
       launch("itms://itunes.apple.com/app/"+ios);
    }

    if(Platform.isAndroid){
      launch("market://developer?id="+android);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticateBloc, AuthenticateState>(
      builder: (context, state) {
        
        if(state is AuthenticateSuccess){
          final profile = state.profile;
        }else {
          final profile = {};
        }
        return Container(
          child: Drawer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                    
                DrawerHeader(
                  margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 2.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 80.0,
                          height: 80.0,
                          child: (state is AuthenticateSuccess)? CachedNetworkImage(imageUrl:state.profile['userProfile']['linkReferences'][0]['link'], fit: BoxFit.cover,) :Icon(
                            Icons.add,
                            color: grayColor,
                            size: 35.0,
                          ),
                          decoration: BoxDecoration(
                            color: lightGrayColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(height: 15.0),
                        Text((state is AuthenticateSuccess)? "Marhaba " + state.profile['userProfile']['firstName'] :"Marhaba",
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.0))
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: primaryColor,
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            onTap:(){
                              Navigator.of(context).pushNamed("/settings");
                            },
                            title: Text('Settings', style: sideMenuText),
                          ),
                          ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => OpenWebView(
                                          title: "FAQ's",
                                          url: googleDocURL + faqURL)));
                            },
                            title: Text('FAQ\'s', style: sideMenuText),
                          ),
                          ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => OpenWebView(
                                          title: "Terms of Use",
                                          url: googleDocURL + termsURL)));
                            },
                            title:
                                Text('Terms & Conditions', style: sideMenuText),
                          ),
                          ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => OpenWebView(
                                          title: "Privacy Policy",
                                          url: googleDocURL + privacyURL)));
                            },
                            title: Text('Privacy Policy', style: sideMenuText),
                          ),
                          // ListTile(
                          //   title: Text('How it Works', style: sideMenuText),
                          // ),
                          ListTile(
                            onTap: (){
                              // _openStore("com.etc.godesto","1446470008");
                              LaunchReview.launch(androidAppId: "com.etc.godesto", iOSAppId: "1446470008", writeReview: true);
                            },
                            title: Text('Rate Us', style: sideMenuText),
                          ),
                          ListTile(
                            onTap: (){
                              (state is! AuthenticateSuccess)? _gotoLogin():_doLogout();
                            },
                            title: (state is! AuthenticateSuccess)?Text('Sign In', style: sideMenuText):Text('Sign Out', style: sideMenuText),
                          ),
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: _gradients,
                            begin: Alignment.topCenter,
                            stops: [0.55, 1],
                            end: Alignment.bottomCenter)),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
