import 'package:etc/helper/globals.dart';
import 'package:etc/helper/methods.dart';
import 'package:etc/helper/services.dart';
import 'package:flutter/material.dart';

class EmailForm extends StatefulWidget {
  final String type;
  final ctx;
  EmailForm({Key key, this.type, this.ctx}) : super(key: key);

  @override
  _EmailFormState createState() => _EmailFormState();
}

class _EmailFormState extends State<EmailForm> {
  final _emailController = TextEditingController();
  final _codeController = TextEditingController();
  bool activateBtn = false;
  bool showVerification = false;
  bool processVerification = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _processEmail(context) async {
    var data = {};

    data['userIdentity'] = _emailController.text;
    data['otpTransferMode'] = "EMAIL";
    data['requestContext'] = requestContext;

    activateBtn = false;
    setState(() {});
    try {
      var resp = await Services().sendOTP(data: data);
      activateBtn = true;
      showVerification = true;
      setState(() {});
    } catch (e) {
      activateBtn = true;
      setState(() {});
    }
  }
  
  _verifyCode(context) async {

    if(_codeController.text!='' && _codeController.text!=null){
        var data = {};

        data['userIdentity'] = _emailController.text;
        data['oneTimePassword'] = _codeController.text;
        data['requestContext'] = requestContext;

        processVerification = true;
        setState(() {});
        try {
          var resp = await Services().validateOTP(data: data);
          print(resp);
          processVerification = false;
          setState(() {});
        } catch (e) {
          processVerification = false;
          setState(() {});
        }
    }else {
        Scaffold.of(context).showSnackBar(SnackBar(behavior:SnackBarBehavior.floating, content: Text("Please enter valid verification code.", textAlign: TextAlign.center,), backgroundColor: Colors.red,));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.0,
      child: Scaffold(
        appBar:null,
        body:Builder(builder: (BuildContext context){
          return Container(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <
                  Widget>[
            Container(
              padding: EdgeInsets.only(
                  left: 12.0, right: 12.0, top: 12.0, bottom: 12.0),
              decoration: BoxDecoration(color: Colors.black87),
              child: Text(
                (widget.type == "email")
                    ? "Change Alternate Email ID"
                    : "Change Mobile Number",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600),
              ),
            ),
            (showVerification==false)?Container(
              child: (widget.type == "email")
                  ? Container(
                      padding: EdgeInsets.only(
                          left: 16.0, right: 16.0, top: 20.0, bottom: 30.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(bottom: 15.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Text("Enter Email Id",
                                        style: TextStyle(
                                            fontSize: 22.0,
                                            fontWeight: FontWeight.w600,
                                            height: 1.3)),
                                  ]),
                            ),
                            TextFormField(
                                controller: _emailController,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.emailAddress,
                                autocorrect: false,
                                onChanged: (value) {
                                  if (HelperMethods().isValidEmail(value)) {
                                    activateBtn = true;
                                    setState(() {});
                                  } else {
                                    activateBtn = false;
                                    setState(() {});
                                  }
                                },
                                // controller: editingController,
                                decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.all(12),
                                    hintText: "Email Address",
                                    hintStyle: TextStyle(color: grayColor),
                                    fillColor: Colors.white,
                                    filled: false,
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5.0),
                                        borderSide: BorderSide(
                                            color: Color(0xFFced4d9),
                                            width: 1.0)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5.0),
                                        borderSide: BorderSide(
                                            color: grayColor, width: 1.5)))),
                            SizedBox(
                              height: 20.0,
                            ),
                            FlatButton(
                              color: primaryColor,
                              disabledColor: Colors.grey,
                              disabledTextColor: Colors.black,
                              onPressed: (activateBtn == true)
                                  ? () {
                                      _processEmail(context);
                                    }
                                  : null,
                              child: Container(
                                  padding:
                                      EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 12.0),
                                  child: Text(
                                    "Next".toUpperCase(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.0,
                                        height: 1.2,
                                        fontWeight: FontWeight.w600),
                                  )),
                            ),
                          ]),
                    )
                  : null,
            ):Container(
              padding: EdgeInsets.only(
                          left: 16.0, right: 16.0, top: 20.0, bottom: 30.0),
              child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(bottom: 15.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Text("Enter Verification Code",
                                        style: TextStyle(
                                            fontSize: 22.0,
                                            fontWeight: FontWeight.w600,
                                            height: 1.3)),
                                  ]),
                            ),
                            TextFormField(
                                controller: _codeController,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.emailAddress,
                                autocorrect: false,
                                onChanged: (value) {},
                                // controller: editingController,
                                decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.all(12),
                                    hintText: "Verification Code",
                                    hintStyle: TextStyle(color: grayColor),
                                    fillColor: Colors.white,
                                    filled: false,
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5.0),
                                        borderSide: BorderSide(
                                            color: Color(0xFFced4d9),
                                            width: 1.0)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5.0),
                                        borderSide: BorderSide(
                                            color: grayColor, width: 1.5)))),
                            SizedBox(
                              height: 20.0,
                            ),
                            FlatButton(
                              color: primaryColor,
                              disabledColor: Colors.grey,
                              disabledTextColor: Colors.black,
                              onPressed: (processVerification == false)
                                  ? () {
                                      _verifyCode(context);
                                    }
                                  : null,
                              child: Container(
                                  padding:
                                      EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 12.0),
                                  child: Text(
                                    (processVerification==true)?"Processing":"Verify".toUpperCase(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.0,
                                        height: 1.2,
                                        fontWeight: FontWeight.w600),
                                  )),
                            ),
                          ]),
            )
          ]));
        },)
      ),
    );
  }
}
