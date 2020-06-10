import 'package:cached_network_image/cached_network_image.dart';
import 'package:etc/helper/globals.dart';
import 'package:etc/helper/methods.dart';
import 'package:etc/helper/services.dart';
import 'package:flutter/material.dart';
class ChangeEmail extends StatefulWidget {
  ChangeEmail({Key key}) : super(key: key);

  @override
  _ChangeEmailState createState() => _ChangeEmailState();
}

class _ChangeEmailState extends State<ChangeEmail> {

  final _emailController = TextEditingController();
  bool activateBtn = false;
  bool processing = false;
  String type = "";
  String countryCode = "+971";
  String userName = "";
  List codesList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void didChangeDependencies() async {

    var tmp = [];
    for (var i=0; i<gCountries.length;i++){
      tmp.add({"code":gCountries[i]['iddCode'],"flag":gCountries[i]['flagImageURL']});
    }
    codesList = tmp;
    print(codesList);
  }

  _processEmail(context) async {
    
    
    if(type=='email' && _emailController.text  == userName){
      Scaffold.of(context).showSnackBar(SnackBar(behavior:SnackBarBehavior.floating, content: Text("Alternate email cannot be same as Username", textAlign: TextAlign.center,), backgroundColor: Colors.red,));
      return false;
    }

    var data = {};

    data['userIdentity'] = (type=='email')?_emailController.text:countryCode+_emailController.text;
    data['otpTransferMode'] = (type=='email')?"EMAIL":"SMS";
    data['requestContext'] = requestContext;

    print(data);

    activateBtn = false;
    setState(() {});
    try {
      var resp = await Services().sendOTP(data: data);
      activateBtn = true;
      setState(() {});
      Navigator.of(context).pushNamed("/otp",arguments:{"type":type,"userIdentity":(type=='email')?_emailController.text:countryCode+_emailController.text});
    } catch (e) {
      activateBtn = true;
      setState(() {});
      print(e);
      Scaffold.of(context).showSnackBar(SnackBar(behavior:SnackBarBehavior.floating, content: Text("Error occured while processing your request.", textAlign: TextAlign.center,), backgroundColor: Colors.red,));
    }
  }

  @override
  Widget build(BuildContext context) {

    final Map params = ModalRoute.of(context).settings.arguments as Map;
    type = params['type'];
    userName = params['userName'];

    return Scaffold(
      appBar:AppBar(
        title:Text((type=='email')?"Change Email":"Change Mobile Number"),
        centerTitle:true
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
                                      Text((type=='email')?"Enter Email Id":"Enter Mobile Number",
                                          style: TextStyle(
                                              fontSize: 22.0,
                                              fontWeight: FontWeight.w600,
                                              height: 1.3)),
                                    ]),
                              ),
                              (type=='email')?TextFormField(
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
                                              color: grayColor, width: 1.5)))):
                                              
                                              
                                              Row(children: <Widget>[
                                                DropdownButtonHideUnderline(
                                                  child: DropdownButton(
                                                    value: countryCode,
                                                    items: codesList.map((item) {
                                                      return DropdownMenuItem(
                                                      value: item['code'],
                                                      child: Container(
                                                        child: Row(children: <Widget>[
                                                          CachedNetworkImage(imageUrl: item['flag'], width: 20),
                                                          SizedBox(width:5.0),
                                                          Text(item['code'])
                                                        ],),));
                                                    }).toList(), 
                                                  onChanged: (v){
                                                    countryCode = v;
                                                    setState((){});
                                                  }),
                                                ),
                                                Expanded(child: TextFormField(
                                  controller: _emailController,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.emailAddress,
                                  autocorrect: false,
                                  onChanged: (value) {
                                      if(value.length>=8){
                                        activateBtn = true;
                                        setState(() {});
                                      }else {
                                        activateBtn = false;
                                        setState(() {});
                                      }
                                  },
                                  // controller: editingController,
                                  decoration: InputDecoration(
                                      isDense: true,
                                      contentPadding: EdgeInsets.all(12),
                                      hintText: "Mobile Number",
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
                                              color: grayColor, width: 1.5)))),)
                                              ],),
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
                      ),
        );
      },)
    );
  }
}