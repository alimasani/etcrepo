import 'dart:async';

import 'package:etc/components/filterpopup.dart';
import 'package:etc/components/footerbar.dart';
import 'package:etc/components/loader.dart';
import 'package:etc/components/topiclist.dart';
import 'package:etc/helper/globals.dart';
import 'package:etc/helper/services.dart';
import 'package:etc/models/models.dart';
import 'package:etc/pages/events.dart';
import 'package:etc/pages/favourites.dart';
import 'package:etc/pages/map.dart';
import 'package:etc/pages/notifications.dart';
import 'package:etc/pages/offers.dart';
import 'package:etc/pages/profile.dart';
import 'package:etc/pages/tab_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:etc/bloc/bloc.dart';
import 'package:etc/components/drawer.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _loading = false;
  dynamic topics = [];
  
  StreamController _streamController = StreamController.broadcast();
  
  @override
  void initState() {
    super.initState();
    _checkTopics();
  }

  void didChangeDependencies() async {
    super.didChangeDependencies();
  }

  _checkTopics() async {
    if (showFirstPopup == "true") {
      showFirstPopup=="false";
      _loading = true;
      setState(() {});
      try {
        // categories = await Services().getCategories(null);
        topics = await Services().getSubscribedTopics();
        _showPopup(context);
        print(topics);
        _loading = false;
        setState(() {});
      } catch (e) {
        _loading = false;
        setState(() {});
      }
    }
  }

  _showPopup(BuildContext context) {
    showGeneralDialog(
        barrierDismissible: false,
        barrierColor: Color.fromARGB(240, 0, 0, 0),
        transitionDuration: const Duration(milliseconds: 200),
        context: context,
        pageBuilder: (BuildContext context, Animation animation,
            Animation secondAnimation) {
          return (_loading == false)
              ? Material(
                  color: Colors.transparent,
                  child: Container(
                    padding: EdgeInsets.only(left:17.0,right:17.0,top:50.0,bottom:20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Select Topics",
                          style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center
                          ,
                        ),
                      ),
                      Divider(color:Colors.white, thickness: 1.0,),
                      Expanded(
                          child: TopicList(topics: topics, theme: "light")),
                      FlatButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        child: Container(child: Text("Done", style: TextStyle(color: Colors.white, fontSize: 18.0),)),
                        color: primaryColor,
                      )
                    ]),
                  ),
                )
              : CustomLoader();
        });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FooterBloc, AppTab>(
      builder: (context, activeTab) {
        print(activeTab);
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: (activeTab == AppTab.home)
                ? Image.asset("assets/img/logo.png", width: 100.0)
                : Text(footerLabels[AppTab.values.indexOf(activeTab)]),
            backgroundColor:
                (activeTab == AppTab.home) ? Colors.white : primaryColor,
            elevation: (activeTab == AppTab.home || activeTab == AppTab.profile)
                ? 0.0
                : 4.0,
            iconTheme: IconThemeData(
                color:
                    (activeTab == AppTab.home) ? darkGrayColor : Colors.white),
            centerTitle: true,
            actions: <Widget>[
              if (activeTab ==  AppTab.list_offer || activeTab == AppTab.map_offer) IconButton(icon: Icon(Icons.filter_list), onPressed: (){
                showModalBottomSheet(
                  isScrollControlled: true,
                  enableDrag: false,
                                  context: context,
                                  builder: (builder) {
                                    return FilterPopup(applyFilter:(dynamic filter){
                                      print("====");
                                      print(filter);
                                      print("====");
                                      _streamController.add(filter);
                                    });
                                  });
              })
            ],
          ),
          body: BlocBuilder<AuthenticateBloc, AuthenticateState>(
            builder: (context, state) {
              var tmpProfile;
              if (state is AuthenticateSuccess) {
                tmpProfile = state.profile;
              } else {
                tmpProfile = null;
              }
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  FocusScope.of(context).requestFocus(new FocusNode());
                },
                child: _activeChild(activeTab, tmpProfile,_streamController.stream),

                //(activeTab==AppTab.home)? TabHome():Offers()
              );
            },
          ),
          drawer: SideMenu(),
          bottomNavigationBar: FooterBar(
            activeTab: activeTab,
            onTabSelected: (tab) =>
                BlocProvider.of<FooterBloc>(context).add(TabUpdated(tab)),
          ),
        );
      },
    );
  }
}

_activeChild(activeTab, profile,_streamController) {

  if (activeTab == AppTab.home) {
    return TabHome(userProfile: profile);
  } else if (activeTab == AppTab.list_offer) {
    return Offers(
      data: null,
      stream: _streamController,
    );
  } else if (activeTab == AppTab.profile) {
    return Profile();
  } else if (activeTab == AppTab.favourites) {
    return Favourites();
  } else if (activeTab == AppTab.notifications) {
    return Notifications();
  } else if (activeTab == AppTab.events) {
    return Events();
  }else if(activeTab == AppTab.map_offer){
    return LeafMap(stream:_streamController);
  }
}
