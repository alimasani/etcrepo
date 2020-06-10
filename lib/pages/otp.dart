import 'package:etc/bloc/bloc.dart';
import 'package:etc/helper/globals.dart';
import 'package:etc/helper/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class OTP extends StatefulWidget {
  OTP({Key key}) : super(key: key);

  @override
  _OTPState createState() => _OTPState();
}

class _OTPState extends State<OTP> {

  final _codeController = TextEditingController();
  String type="";
  String userIdentity = "";
  bool processVerification = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  
  _verifyCode(context) async {

    if(_codeController.text!='' && _codeController.text!=null){
        var data = {};

        data['userIdentity'] = userIdentity;
        data['oneTimePassword'] = _codeController.text;
        data['requestContext'] = requestContext;

        processVerification = true;
        setState(() {});
        try {
          var resp = await Services().validateOTP(data: data);
          print(resp);
          try{

            var data1 = {};
            data1['emailMobile']=userIdentity;
            data1['oneTimePassword']=_codeController.text;
            
            try{
              var upresp = await Services().changeEmailMobile(data:data1);
              processVerification = false;
              setState(() {});
              BlocProvider.of<AuthenticateBloc>(context).add(
                AppStarted()
              );
              Navigator.of(context).popUntil(ModalRoute.withName('/personalInfo'));
            }catch(e){
              print(e);
              processVerification = false;
              setState(() {});
              Scaffold.of(context).showSnackBar(SnackBar(behavior:SnackBarBehavior.floating, content: Text("Error occured updating your profile. Please try again later.", textAlign: TextAlign.center,), backgroundColor: Colors.red,));
            }
            
            
          }catch(e){
            print(e);
            processVerification = false;
            setState(() {});
          }
          processVerification = false;
          setState(() {});
        } catch (e) {
          processVerification = false;
          setState(() {});
          print(e);
          Scaffold.of(context).showSnackBar(SnackBar(behavior:SnackBarBehavior.floating, content: Text("Invalid verification code.", textAlign: TextAlign.center,), backgroundColor: Colors.red,));
        }
    }else {
        Scaffold.of(context).showSnackBar(SnackBar(behavior:SnackBarBehavior.floating, content: Text("Please enter valid verification code.", textAlign: TextAlign.center,), backgroundColor: Colors.red,));
    }
  }

  @override
  Widget build(BuildContext context) {

    final Map params = ModalRoute.of(context).settings.arguments as Map;
    type = params['type'];
    userIdentity = params['userIdentity'];

    return Scaffold(
      appBar:AppBar(
        title:Text("OTP"),
        centerTitle:true,
      ),
      body:Builder(builder: (BuildContext context){
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
                  child: Container(
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
              ),
        );
      },)
    );
  }
}