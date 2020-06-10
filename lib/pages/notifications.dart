import 'package:etc/bloc/authenticate/authenticate_bloc.dart';
import 'package:etc/bloc/bloc.dart';
import 'package:etc/components/loader.dart';
import 'package:etc/components/norecords.dart';
import 'package:etc/components/notauthorized.dart';
import 'package:etc/helper/globals.dart';
import 'package:etc/helper/methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class Notifications extends StatefulWidget {
  Notifications({Key key}) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {

  void didChangeDependencies() {
    super.didChangeDependencies();
    
    BlocProvider.of<NotificationBloc>(context)
      ..add(GetNotifications());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticateBloc,AuthenticateState>(
      builder: (context,state){
        return (state is! AuthenticateSuccess)? NotAuthorized():
        Container(
          child:BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
          if (state is NotificationSuccess) {
            final notList = state.notifications;
            print(notList);
            return ListView.builder(
                itemCount: notList.length,
                itemBuilder: (context, index) {
                      return Card(
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          child:Row(
                            children: <Widget>[
                              Expanded(
                                                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                  Text(notList[index]['title'], style: TextStyle(fontSize: 16.0, fontWeight: (notList[index]['notificationHasBeenViewed']=="false")?FontWeight.w600:FontWeight.normal, height: 1.2),),
                                  SizedBox(height:3.0),
                                  Text(notList[index]['message'], style: TextStyle(fontSize: 14.0,height: 1.2, fontWeight: FontWeight.w300),),
                                ],),
                              ),
                              Text(HelperMethods().dateDifference(startDate:notList[index]['createdOn'],currentDate:notList[index]['requestDateTime']),style: TextStyle(color: grayColor, fontWeight: FontWeight.w200),)
                            ],
                          )
                        ),);
                    });
          } else if(state is NotificationError){
              return NoRecords(icon:"",title:"Oops!",message:"No notifications for you yet. You will have one soon.");
          } else {
              return CustomLoader();
          }
        },
      ),
          );
      },);
  }
}