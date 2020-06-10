import 'package:etc/bloc/bloc.dart';
import 'package:etc/helper/globals.dart';
import 'package:etc/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FooterBar extends StatelessWidget {
  final AppTab activeTab;
  final Function(AppTab) onTabSelected;

  dynamic profile;

  FooterBar({
    Key key,
    @required this.activeTab,
    @required this.onTabSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticateBloc, AuthenticateState>(
      builder: (context, state) {
        if (state is AuthenticateSuccess) {
          profile = state.profile;
        } else {
          profile = null;
        }

        return BottomNavigationBar(
          backgroundColor: Color(0xFFf4f4f4),
          key: Key("footer_tabs"),
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: AppTab.values.indexOf(activeTab),
          onTap: (index) {
            if (AppTab.values[index] == AppTab.list_offer) {
              currentFilterParams = {};
            }
            onTabSelected(AppTab.values[index]);
          },
          items: AppTab.values.map((tab) {
            var index = AppTab.values.indexOf(tab);
            print(index);
            return BottomNavigationBarItem(
                icon: _footerIcon(activeTab, tab, index, profile),
                title: Text(footerLabels[index]));
          }).toList(),
        );
      },
    );
  }
}

Widget _footerIcon(activeTab, tab, index,profile) {
  if (tab == AppTab.notifications) {
    return Stack(children: <Widget>[
      activeTab == tab
          ? Image.asset(footerActiveIcons[index], width: 25.0, height: 25.0)
          : Image.asset(footerIcons[index], width: 25.0, height: 25.0),
      Positioned(
        // draw a red marble
        top: 0.0,
        right: 0.0,
        child:  Icon(Icons.brightness_1, size: 8.0, color: (profile!=null && int.parse(profile['unreadNotificationCount'])>0)?Colors.red:Colors.transparent),
      )
    ]);
  } else {
    return activeTab == tab
        ? Image.asset(footerActiveIcons[index], width: 25.0, height: 25.0)
        : Image.asset(footerIcons[index], width: 25.0, height: 25.0);
  }
}
