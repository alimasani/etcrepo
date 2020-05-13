import 'package:etc/helper/globals.dart';
import 'package:flutter/material.dart';

ThemeData appTheme() {
  return ThemeData(
    primaryColor: primaryColor,
    accentColor: blueColor,
    hintColor: Colors.white,
    dividerColor: lightGrayColor,
    buttonColor: blueColor,
    scaffoldBackgroundColor: Colors.white,
    canvasColor: Colors.white,
    dialogBackgroundColor:Colors.black87,
    fontFamily: 'Proxima Nova'
  );
}