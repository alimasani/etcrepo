import 'package:etc/helper/globals.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget shimmerBrandItem(context) {
  return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      enabled: true,
      child: Container(
      margin: EdgeInsets.all(3.5),
      width: MediaQuery.of(context).size.width*0.22,
      height: 80.0,
      decoration: BoxDecoration(color: lightGrayColor),
      child: null,
    ));
}

