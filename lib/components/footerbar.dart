import 'package:etc/helper/globals.dart';
import 'package:etc/models/models.dart';
import 'package:flutter/material.dart';
class FooterBar extends StatelessWidget {
  final AppTab activeTab;
  final Function(AppTab) onTabSelected;

  FooterBar({
    Key key,
    @required this.activeTab,
    @required this.onTabSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Color(0xFFf4f4f4),
      key: Key("footer_tabs"),
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      currentIndex: AppTab.values.indexOf(activeTab),
      onTap: (index) => onTabSelected(AppTab.values[index]),
      items: AppTab.values.map((tab) {
        var index = AppTab.values.indexOf(tab);
        print(index);
        return BottomNavigationBarItem(
          icon: activeTab == tab? Image.asset(footerActiveIcons[index], width:27.0, height:27.0) :Image.asset(footerIcons[index], width:27.0, height:27.0),
          title: Text(footerLabels[index])
          );
      }).toList(),
    );
  }
}