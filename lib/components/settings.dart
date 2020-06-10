import 'package:etc/bloc/bloc.dart';
import 'package:etc/components/loader.dart';
import 'package:etc/components/notauthorized.dart';
import 'package:etc/components/topiclist.dart';
import 'package:etc/helper/globals.dart';
import 'package:etc/helper/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class Settings extends StatefulWidget {
  Settings({Key key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  
  List<dynamic> categories=[];
  List<dynamic> topics=[];
  bool _loading = false;
  bool _processing = false; 

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text("Settings"),
        centerTitle:true,
      ),
      body:BlocBuilder<AuthenticateBloc,AuthenticateState>(
        builder: (context,state){
          if (state is AuthenticateSuccess) { 
            return InkWell(
                              onTap: () {
                                  Navigator.of(context).pushNamed('/topics');
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border:Border(bottom: BorderSide(color:Colors.black12)),
                                  color:Colors.transparent,
                                ),
                                padding: EdgeInsets.all(15.0),
                                child: Row(children: <Widget>[
                                  Expanded(child:Text("Topics Subscription", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color:darkGrayColor ),)),
                                  Icon(Icons.chevron_right, color: Colors.black54,),
                                ],),
                              ),
                            );
          }else {
            return NotAuthorized();
          }
      },)
    );
  }
}