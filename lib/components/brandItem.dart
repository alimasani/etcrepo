import 'package:cached_network_image/cached_network_image.dart';
import 'package:etc/helper/globals.dart';
import 'package:flutter/material.dart';

class BrandItem extends StatelessWidget {
  final dynamic brandItem;
  const BrandItem({Key key, this.brandItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left:3.0,right:3.0,),
      width: MediaQuery.of(context).size.width*0.22,
      height: 70.0,
      decoration: BoxDecoration(border: Border.all(color: lightGrayColor)),
      child: CachedNetworkImage(imageUrl:brandItem["brandLogoURL"]),
    );
  }
}
