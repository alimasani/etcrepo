import 'package:cached_network_image/cached_network_image.dart';
import 'package:etc/helper/globals.dart';
import 'package:etc/models/models.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final dynamic catItem;
  const CategoryItem({Key key, this.catItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
          elevation: 0.0,
          margin: EdgeInsets.all(0.0),
          color: Colors.white,
          child: Padding(
            padding:EdgeInsets.fromLTRB(0.0,0.0,0.0,0.0),
                    child: Center(
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CachedNetworkImage(imageUrl:catItem['categoryImageURL'], width: 37.0),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(catItem['category'], textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14.0,
                          )),
                  ]),
            ),
          )),
    );
  }
}
