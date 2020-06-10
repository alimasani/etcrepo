import 'package:etc/helper/globals.dart';
import 'package:etc/helper/methods.dart';
import 'package:etc/helper/services.dart';
import 'package:flutter/material.dart';

class ForgotPass extends StatefulWidget {
  ForgotPass({Key key}) : super(key: key);

  @override
  _ForgotPassState createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  final _codeController = TextEditingController();
  bool _processing = false;
  String userName = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _doVerify(context) async {
    _processing = true;
    setState(() {});
    if (_codeController.text == '' || _codeController.text == null) {
      Scaffold.of(context).showSnackBar(SnackBar(
        behavior:SnackBarBehavior.floating,
        content: Text(
          "Please enter valid verification code.",
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.red,
      ));
      _processing = false;
      setState(() {});
    } else {
      var data = {};
      data['userIdentity'] = userName;
      data['oneTimePassword'] = _codeController.text;
      data['requestContext'] = requestContext;
      try {
        var resp = await Services().validateOTP(data: data);
        print(resp);
        _processing = false;
        setState(() {});
        Navigator.of(context).pushNamed("/setPassword",arguments:{"userName":userName,"otp":_codeController.text});
      } catch (e) {
        Scaffold.of(context).showSnackBar(SnackBar(
          behavior:SnackBarBehavior.floating,
          content: Text(
            "Invalid verification code.",
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.red,
        ));
        _processing = false;
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map params = ModalRoute.of(context).settings.arguments as Map;
    userName = params['userName'];

    return Scaffold(
        appBar: AppBar(
          title: Text("Verify OTP"),
          elevation: 1.0,
          centerTitle: true,
        ),
        body: Builder(
          builder: (BuildContext context) {
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
                        padding:
                            EdgeInsets.only(left: 15, right: 15, bottom: 35.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Text("No Worries",
                                  style: TextStyle(
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.w600,
                                      height: 1.3)),
                              Text(
                                  "Happens all the time. We just sent a verification code to",
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w300,
                                      height: 1.3)),
                              Text(HelperMethods().maskEmail(userName),
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600,
                                      height: 1.3,
                                      color: blueColor)),
                            ]),
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: TextFormField(
                              controller: _codeController,
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.number,
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
                                          color: grayColor, width: 1.5))))),
                      SizedBox(height: 25.0),
                      Container(
                        margin: EdgeInsets.only(left: 15.0, right: 15.0),
                        child: FlatButton(
                            onPressed: (_processing == false)
                                ? () {
                                    _doVerify(context);
                                  }
                                : null,
                            color: primaryColor,
                            disabledColor: Colors.grey,
                            disabledTextColor: Colors.black,
                            padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
                            child: (_processing == false)
                                ? Text("Verify",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16.0))
                                : Container(
                                    child: Text("Processing..."),
                                  )),
                      ),
                    ],
                  ),
                ));
          },
        ));
  }
}
