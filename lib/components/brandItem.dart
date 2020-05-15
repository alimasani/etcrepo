import 'package:etc/helper/globals.dart';
import 'package:flutter/material.dart';

class BrandItem extends StatelessWidget {
  final dynamic brandItem;
  const BrandItem({Key key, this.brandItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left:5.0,right:5.0),
      width: MediaQuery.of(context).size.width*0.20,
      decoration: BoxDecoration(border: Border.all(color: lightGrayColor)),
      child: Image.network(brandItem["brandLogoURL"]),
    );
  }
}
