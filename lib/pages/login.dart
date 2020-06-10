import 'package:etc/bloc/bloc.dart';
import 'package:etc/bloc/users/users_bloc.dart';
import 'package:etc/helper/globals.dart';
import 'package:etc/helper/services.dart';
import 'package:etc/pages/loginform.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Login extends StatefulWidget {
  final String activeTab;
  Login({Key key, this.activeTab}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              title: Text("Login"),
              elevation: 1.0,
              centerTitle: true,
            ),
            body: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              child: BlocProvider(
                create: (context) {
                  return UsersBloc(
                      authenticateBloc:
                          BlocProvider.of<AuthenticateBloc>(context),
                      services: Services());
                },
                child: LoginForm(),
              ),
            )));
  }
}
