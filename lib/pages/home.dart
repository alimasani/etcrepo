import 'package:etc/components/footerbar.dart';
import 'package:etc/helper/globals.dart';
import 'package:etc/models/models.dart';
import 'package:etc/pages/events.dart';
import 'package:etc/pages/favourites.dart';
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

  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   BlocProvider.of<FeaturedOffersBloc>(context)..add(GetFeaturedOffers());
  // }

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
              elevation: (activeTab==AppTab.home || activeTab == AppTab.profile)?0.0:4.0, 
              iconTheme: IconThemeData(color: (activeTab==AppTab.home)?darkGrayColor:Colors.white),
              ),
              
          body: BlocBuilder<AuthenticateBloc,AuthenticateState>(
            builder: (context,state){
              var tmpProfile;
              if(state is AuthenticateSuccess){
                tmpProfile = state.profile;
              }else {
                tmpProfile = null;
              }
              return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: (){
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              child: _activeChild(activeTab,tmpProfile),

              //(activeTab==AppTab.home)? TabHome():Offers()
            );

            },),
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

Widget _activeChild(activeTab,profile){
  if(activeTab==AppTab.home){
    return TabHome(userProfile:profile);
  }else if(activeTab==AppTab.list_offer){
    return Offers(data: null,);
  }else if(activeTab==AppTab.profile){
    return Profile();
  }else if(activeTab==AppTab.favourites){
    return Favourites();
  }else if(activeTab==AppTab.notifications){
    return Notifications();
  }else if(activeTab==AppTab.events){
    return Events();
  }
}