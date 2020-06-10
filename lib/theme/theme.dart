import 'package:etc/helper/globals.dart';
import 'package:flutter/material.dart';

ThemeData appTheme() {
  return ThemeData(
    primaryColor: primaryColor,
    accentColor: darkGrayColor, //blueColor
    hintColor: Colors.white,
    dividerColor: lightGrayColor,
    buttonColor: darkGrayColor, //blueColor
    scaffoldBackgroundColor: Colors.white,
    canvasColor: Colors.white,
    dialogBackgroundColor:Colors.black87,
    fontFamily: 'Proxima Nova'
  );
}