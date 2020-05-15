import 'package:etc/helper/globals.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget shimmerOfferItem(context) {
  return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      enabled: true,
      child: Container(
        margin: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
        child: SizedBox(height: 170.0,),
        decoration: BoxDecoration(
          color:grayColor,
          borderRadius: BorderRadius.circular(10.0)
        ),
      ));
}
