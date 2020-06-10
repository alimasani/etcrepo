import 'package:etc/helper/globals.dart';
import 'package:etc/helper/services.dart';
import 'package:flutter/material.dart';

class SetPassword extends StatefulWidget {
  SetPassword({Key key}) : super(key: key);

  @override
  _SetPasswordState createState() => _SetPasswordState();
}

class _SetPasswordState extends State<SetPassword> {
  final _passwordController = TextEditingController();
  final _cpasswordController = TextEditingController();
  String userName;
  String otp;
  bool _processing = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _generatePassword(context) async {
    _processing = true;
    setState(() {});
    if (_passwordController.text != '' && _passwordController.text != null) {
      if (_passwordController.text != _cpasswordController.text) {
        _processing = false;
        setState(() {});
        Scaffold.of(context).showSnackBar(SnackBar(
          behavior:SnackBarBehavior.floating,
          content: Text(
            "Password and Confirm Password should be same.",
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.red,
        ));
      } else {
        var data = {};
        data['requestContext'] = requestContext;
        data['requestType'] = "FORGOT";
        data['userName'] = userName;
        data['newPassword'] = _passwordController.text;
        data['oneTimePassword'] = otp;
        try {
          var resp = await Services().updatePassword(data);
          _processing = false;
          setState(() {});
        } catch (e) {
          Scaffold.of(context).showSnackBar(SnackBar(
            behavior:SnackBarBehavior.floating,
            content: Text(
              "Error occured while updating password. Please try again later.",
              textAlign: TextAlign.center,
            ),
            backgroundColor: Colors.red,
          ));
          _processing = false;
          setState(() {});
        }
      }
    } else {
      _processing = false;
      setState(() {});
      Scaffold.of(context).showSnackBar(SnackBar(
        behavior:SnackBarBehavior.floating,
        content: Text(
          "Please enter valid password.",
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map params = ModalRoute.of(context).settings.arguments as Map;
    userName = params['userName'];
    otp = params['otp'];

    return Scaffold(
        appBar: AppBar(title: Text("Generate Password"), centerTitle: true),
        body: Builder(builder: (BuildContext context) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 15, right: 15, bottom: 35.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text("Set New Password",
                              style: TextStyle(
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.w600,
                                  height: 1.3)),
                        ]),
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: TextFormField(
                          controller: _passwordController,
                          textInputAction: TextInputAction.next,
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
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: TextFormField(
                          controller: _cpasswordController,
                          textInputAction: TextInputAction.done,
                          autocorrect: false,
                          obscureText: true,
                          onChanged: (value) {},
                          // controller: editingController,
                          decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.all(12),
                              hintText: "Confirm Password",
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
                  SizedBox(height: 25.0),
                  Container(
                    margin: EdgeInsets.only(left: 15.0, right: 15.0),
                    child: FlatButton(
                        onPressed: (!_processing)
                            ? () {
                                _generatePassword(context);
                              }
                            : null,
                        color: primaryColor,
                        disabledColor: Colors.grey,
                        disabledTextColor: Colors.black,
                        padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
                        child: (!_processing)
                            ? Text("Save",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16.0))
                            : Container(
                                child: Text("Processing..."),
                              )),
                  ),
                ],
              ),
            ),
          );
        }));
  }
}
