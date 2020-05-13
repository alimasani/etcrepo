import 'package:etc/helper/globals.dart';
import 'package:flutter/material.dart';

class BrandItem extends StatelessWidget {
  final dynamic brandItem;
  const BrandItem({Key key, this.brandItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(3.0),
      width: 92.0,
      decoration: BoxDecoration(border: Border.all(color: lightGrayColor)),
      child: Image.network(brandItem["brandLogoURL"]),
    );
  }
}
