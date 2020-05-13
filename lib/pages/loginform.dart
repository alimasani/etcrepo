import 'package:etc/bloc/users/users_bloc.dart';
import 'package:etc/bloc/users/users_event.dart';
import 'package:etc/bloc/users/users_state.dart';
import 'package:etc/helper/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class LoginForm extends StatefulWidget {
  LoginForm({Key key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    _doLogin(){
      BlocProvider.of<UsersBloc>(context).add(
        LoginUser(username:_usernameController.text,password:_passwordController.text)
      );
    }

    return BlocListener<UsersBloc,UsersState>(
      listener: (context,state){
        if (state is UsersError){
          Scaffold.of(context).showSnackBar(SnackBar(content: Text("Invalid Username and/or password", textAlign: TextAlign.center,),backgroundColor: Colors.red,));
        }else if(state is UsersSuccess){
            Navigator.pushNamed(context, '/home');
          }
      },
      child: BlocBuilder<UsersBloc,UsersState>(
        builder: (context,state){
          
          return Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
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
                            hintText: "Email",
                            hintStyle: TextStyle(color: grayColor),
                            fillColor: Colors.white,
                            filled: false,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                    color: Color(0xFFced4d9), width: 1.0)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                    color: grayColor, width: 1.5))))),
                SizedBox(height: 15.0),
                Padding(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: TextFormField(
                        controller: _passwordController,
                        textInputAction: TextInputAction.done,
                        autocorrect: false,
                        obscureText: true,
                        onChanged: (value) {},
                        // controller: editingController,
                        decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.all(12),
                            hintText: "Password",
                            hintStyle: TextStyle(color: grayColor),
                            fillColor: Colors.white,
                            filled: false,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                    color: Color(0xFFced4d9), width: 1.0)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                    color: grayColor, width: 1.5))))),
                SizedBox(height: 15.0),
                Padding(
                  padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  child: RichText(
                    textAlign: TextAlign.left,
                    text: TextSpan(
                        text: 'Forgot Password? ',
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                              text: 'Reset',
                              style: TextStyle(color: primaryColor)),
                          TextSpan(text: " here")
                        ]),
                  ),
                ),
                SizedBox(height: 25.0),
                Container(
                  margin: EdgeInsets.only(left:90.0, right:90.0),
                  child: RaisedButton(
                      onPressed: (state is! UsersLoading) ? _doLogin : null,
                      color: primaryColor,
                      padding: EdgeInsets.only(left: 35.0, right: 35.0),
                      child: (state is! UsersLoading)?Text("Login",
                          style:
                              TextStyle(color: Colors.white, fontSize: 16.0)):Container(child: Text("Processing..."),)),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}