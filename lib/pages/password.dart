import 'package:etc/bloc/bloc.dart';
import 'package:etc/helper/globals.dart';
import 'package:etc/helper/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class Password extends StatefulWidget {

  Password({Key key}) : super(key: key);

  @override
  _PasswordState createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  
  final _passwordController = TextEditingController();
  bool _processing = false;
  dynamic voucher;
  String isFirstLogin = "false";
  String userName = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _doVerify(context) async {
    if(_passwordController.text=='' || _passwordController==null){
      Scaffold.of(context).showSnackBar(SnackBar(behavior:SnackBarBehavior.floating,content: Text("Enter Valid Password", textAlign: TextAlign.center,), backgroundColor: Colors.red,));
    }else {

      if(voucher!=null){
        // Verify password - redemption
        _processing = true;
        setState(() {});
      //Validate outlet Pin
      //dealID,outletPIN,redeemVoucherCountRef
      var data = {};
      data['userPassword']= _passwordController.text;
      
      try {
        var outletPin = await Services().validateUser(data:data);
        print(outletPin);
        
        var dataR = {};
        dataR['dealID']=voucher['dealID'];
        dataR['userPassword']=_passwordController.text;
        dataR['redeemVoucherCountRef']=voucherCountRef;

        try {
          var voucherRedeem = await Services().redeemVoucher(data:dataR);
          print(voucherRedeem);
          _processing = false;
          setState((){});
          Navigator.of(context).pushReplacementNamed('/voucherCode',arguments: {"vcode":voucherRedeem['code'],"voucher":voucher});
        }catch (e){
          print(e);
          _processing = false;
          setState((){});
        }

      }catch (e){
        print(e);
        _passwordController.text = "";
        _processing = false;
        Scaffold.of(context).showSnackBar(SnackBar(behavior:SnackBarBehavior.floating,content: Text("Invalid Password.", textAlign: TextAlign.center,), backgroundColor: Colors.red,));
        setState(() {});
      }

      }else {
        // Login
        _processing = true;
        setState(() {});
        try {
            final user = await Services().userLogin(username: userName, password: _passwordController.text);
            print(user);

            try {
              final saveToken = await Services().saveLocalStorage(key: "authToken", auth: user['desc']);
              print("--");
              print(await Services().getLocalStorage(key:'authToken'));
              print("--");
              final profile = await Services().getProfile();
              print(profile);
              currentUserProfile = profile;
              BlocProvider.of<AuthenticateBloc>(context).add(AppStarted());
              showFirstPopup = isFirstLogin;
              Navigator.of(context).pushNamedAndRemoveUntil("/home", ModalRoute.withName('/home'));
              
              setState(() {});

            }catch (e){
              print(e);
            }

        }catch (e){
          _passwordController.text = "";
          _processing = false;
          Scaffold.of(context).showSnackBar(SnackBar(behavior:SnackBarBehavior.floating,content: Text("Invalid Password.", textAlign: TextAlign.center,), backgroundColor: Colors.red,));
          setState(() {});
        }

      }

      
    }
  }

  _requestPass() async{
    var data = {};
    data['userIdentity'] = userName;
    data['otpTransferMode'] = "EMAIL";
    data['requestContext'] = requestContext;

    var resp = await Services().sendOTP(data:data);
    print(resp);
    Navigator.of(context).pushNamed("/forgotPass", arguments: {"userName":userName});
  }

  @override
  Widget build(BuildContext context) {

    final Map params = ModalRoute.of(context).settings.arguments as Map;
    voucher = params['voucher'];
    isFirstLogin = params['isFirstLogin'];
    userName = params['userName'];
    
    return Scaffold(
      appBar:AppBar(
        title:Text("Password"),
        centerTitle:true
      ),
      body: Builder(builder:(BuildContext context){
        return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: (){
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
                    children:<Widget>[
                      Text((voucher!=null)?"Verify It's You":"Enter your password",style:TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600, height: 1.3)),
                      if(voucher!=null) Text("Enter your password to complete redemption.",style:TextStyle(fontSize: 16.0, fontWeight: FontWeight.w300, height: 1.3)),
                    ]
                  ),),
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
                  child: InkWell(
                    onTap: () {
                      _requestPass();
                    },
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
                ),
                SizedBox(height: 25.0),
                Container(
                  margin: EdgeInsets.only(left:15.0, right:15.0),
                  child: FlatButton(
                      onPressed: (!_processing) ? () { _doVerify(context); } : null,
                      color: primaryColor,
                      disabledColor: Colors.grey,
                      disabledTextColor: Colors.black,
                      padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
                      child: (!_processing)?Text((voucher!=null)?"Verify":"Login",
                          style:
                              TextStyle(color: Colors.white, fontSize: 16.0)):Container(child: Text("Processing..."),)),
                ),
              ],
            ),
          ),);
      })
    );
  }
}