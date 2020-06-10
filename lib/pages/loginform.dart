import 'package:etc/bloc/users/users_bloc.dart';
import 'package:etc/bloc/users/users_event.dart';
import 'package:etc/bloc/users/users_state.dart';
import 'package:etc/helper/globals.dart';
import 'package:etc/helper/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatefulWidget {
  LoginForm({Key key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  bool _processing = false;

  @override
  Widget build(BuildContext context) {
    _doLogin() async {
      // BlocProvider.of<UsersBloc>(context).add(
      //   LoginUser(username:_usernameController.text,password:_passwordController.text)
      // );

      _processing = true;
      setState(() {});
      try {
        final resp = await Services()
            .isFirstTimeLogin(username: _usernameController.text);
        _processing = false;
        setState(() {});
        print(resp);

        if (resp['desc'] == "true") {
          showGeneralDialog(
              barrierDismissible: false,
              barrierColor: Colors.black87,
              transitionDuration: const Duration(milliseconds: 200),
              context: context,
              pageBuilder: (BuildContext context, Animation animation,
                  Animation secondAnimation) {
                return Material(
                  color: Colors.transparent,
                  child: Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: 150.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                        Expanded(
                            child: Center(
                                child: Text(
                          "Hello "+ resp['code'] +"! It's great to have you here. Since this is your first time login, we have sent the login credentials to your registered email address " +
                              _usernameController.text,
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.w400),
                          textAlign: TextAlign.center,
                        ))),
                        Container(
                          margin: EdgeInsets.only(left:50.0, right:50.0),
                          child: FlatButton(
                              color: primaryColor,
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.of(context).pushNamed('/password',
                                    arguments: {
                                      "voucher": null,
                                      "isFirstLogin": resp['desc'],
                                      "userName":_usernameController.text
                                    });
                              },
                              child: Container(
                                
                                  padding:
                                      EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                                  child: Text(
                                    "OK".toUpperCase(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.0,
                                        height: 1.2,
                                        fontWeight: FontWeight.w600),
                                  ))),
                        ),
                      ]),
                    ),
                  ),
                );
              });
        }else {
          Navigator.of(context).pushNamed('/password',
                                    arguments: {
                                      "voucher": null,
                                      "isFirstLogin": resp['desc'],
                                      "userName":_usernameController.text
                                    });
        }
      } catch (e) {
        print(e);
        Scaffold.of(context).showSnackBar(SnackBar(
          behavior:SnackBarBehavior.floating,
          content: Text(
            "User is not registered or is in deregistered status.",
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.red,
        ));
        _processing = false;
        setState(() {});
      }
    }

    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
                  padding: EdgeInsets.only(left: 15, right: 15, bottom: 35.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children:<Widget>[
                      Text("Enter Your Username",style:TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600, height: 1.3)),
                      
                    ]
                  ),),
          Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: TextFormField(
                  controller: _usernameController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  onChanged: (value) {},
                  // controller: editingController,
                  decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.all(12),
                      hintText: "Username",
                      hintStyle: TextStyle(color: grayColor),
                      fillColor: Colors.white,
                      filled: false,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide:
                              BorderSide(color: Color(0xFFced4d9), width: 1.0)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide:
                              BorderSide(color: grayColor, width: 1.5))))),
          SizedBox(height: 25.0),
          Container(
            margin: EdgeInsets.only(left: 15.0, right: 15.0),
            child: FlatButton(
                onPressed: (_processing == false) ? _doLogin : null,
                color: primaryColor,
                disabledColor: Colors.grey,
                disabledTextColor: Colors.black,
                padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
                child: (_processing == false)
                    ? Text("Next",
                        style: TextStyle(color: Colors.white, fontSize: 16.0))
                    : Container(
                        child: Text("Processing..."),
                      )),
          ),
        ],
      ),
    );
  }
}
