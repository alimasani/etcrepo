import 'package:etc/helper/globals.dart';
import 'package:etc/helper/services.dart';
import 'package:flutter/material.dart';
class ChangePass extends StatefulWidget {
  ChangePass({Key key}) : super(key: key);

  @override
  _ChangePassState createState() => _ChangePassState();
}

class _ChangePassState extends State<ChangePass> {

  final _passController = TextEditingController();
  final _newpassController = TextEditingController();
  final _cpassController = TextEditingController();
  bool processing = false;
  String userName = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _updatePass(context) async{
    processing = true;
    setState((){});
    if(_passController.text=='' || _passController.text==null){
      Scaffold.of(context).showSnackBar(SnackBar(behavior:SnackBarBehavior.floating, content: Text("Please enter your current password.", textAlign: TextAlign.center,), backgroundColor: Colors.red,));   
      return false;
    }
    
    if(_newpassController.text=='' || _newpassController.text==null){
      Scaffold.of(context).showSnackBar(SnackBar(behavior:SnackBarBehavior.floating, content: Text("Please enter new password.", textAlign: TextAlign.center,), backgroundColor: Colors.red,));   
      return false;
    }
    
    if(_newpassController.text!=_cpassController.text){
      Scaffold.of(context).showSnackBar(SnackBar(behavior:SnackBarBehavior.floating, content: Text("New password and confirm password should be same.", textAlign: TextAlign.center,), backgroundColor: Colors.red,));   
      return false;
    }

    var data = {};
        data['requestContext'] = requestContext;
        data['requestType'] = "RESET";
        data['userName'] = userName;
        data['newPassword'] = _newpassController.text;
        data['oldPassword'] = _passController.text;
        try {
          var resp = await Services().updatePassword(data);
          print(resp);
          processing = false;
          setState(() {});
          _passController.text="";
          _newpassController.text="";
          _cpassController.text="";
          Scaffold.of(context).showSnackBar(SnackBar(
            behavior:SnackBarBehavior.floating,
            content: Text(
              "Passwordd updated successfully.",
              textAlign: TextAlign.center,
            ),
            backgroundColor: Colors.green,
          ));

          // Navigator.of(context).popUntil(ModalRoute.withName('/personalInfo'));

        } catch (e) {
          print(e);
          Scaffold.of(context).showSnackBar(SnackBar(
            behavior:SnackBarBehavior.floating,
            content: Text(
              e.toString(),
              textAlign: TextAlign.center,
            ),
            backgroundColor: Colors.red,
          ));
          processing = false;
          setState(() {});
        }
  }

  @override
  Widget build(BuildContext context) {

    final Map params = ModalRoute.of(context).settings.arguments as Map;
    userName = params['userName'];

    return Scaffold(
      appBar:AppBar(
        title:Text("Change Password"),
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
                              
                              TextFormField(
                                  controller: _passController,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.text,
                                  autocorrect: false,
                                  obscureText: true,
                                  onChanged: (value) {},
                                  decoration: InputDecoration(
                                      isDense: true,
                                      contentPadding: EdgeInsets.all(12),
                                      hintText: "Current Password",
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
                                              SizedBox(height:15.0),
                              TextFormField(
                                  controller: _newpassController,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.emailAddress,
                                  autocorrect: false,
                                  obscureText: true,
                                  onChanged: (value) {},
                                  // controller: editingController,
                                  decoration: InputDecoration(
                                      isDense: true,
                                      contentPadding: EdgeInsets.all(12),
                                      hintText: "New Password",
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
                                              SizedBox(height:15.0),
                              TextFormField(
                                  controller: _cpassController,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.emailAddress,
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
                                color: blueColor,
                                disabledColor: Colors.grey,
                                disabledTextColor: Colors.black,
                                onPressed: (processing == false)
                                    ? () {
                                        _updatePass(context);
                                      }
                                    : null,
                                child: Container(
                                    padding:
                                        EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 12.0),
                                    child: Text(
                                      (processing==true)?"Processing":"Update".toUpperCase(),
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