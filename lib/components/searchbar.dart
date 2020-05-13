import 'package:etc/helper/globals.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  SearchBar({Key key}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
                padding: EdgeInsets.only(left: 45, right: 45),
                child: TextFormField(
                    textInputAction: TextInputAction.search,
                    autocorrect: false,
                    onChanged: (value) {},
                    // controller: editingController,
                    decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(10),
                        hintText: "Search for merchants, locations",
                        hintStyle: TextStyle(color: grayColor),
                        prefixIcon: Icon(
                          Icons.search,
                          size: 25.0,
                        ),
                        fillColor: Colors.white,
                        filled: false,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide(
                                color: Color(0xFFEFEFEF), width: 2.5)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide(
                                color: Color(0xFFEFEFEF), width: 2.5)))));
  }
}