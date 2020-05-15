import 'package:etc/helper/globals.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget shimmerCatItem(context) {
  return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      enabled: true,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
            child: SizedBox(height: 60.0, width: 60.0,),
            decoration: BoxDecoration(
              color:grayColor,
            ),
          ),
          Container(child: null,
            height: 15.0,
            margin: EdgeInsets.only(left:20.0,right:20.0),
            decoration: BoxDecoration(
              color:darkGrayColor,
            ),
          )
        ],
      ));
}
