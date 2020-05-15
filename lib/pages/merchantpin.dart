import 'package:etc/bloc/bloc.dart';
import 'package:etc/components/idcard.dart';
import 'package:etc/components/notauthorized.dart';
import 'package:etc/helper/data-process.dart';
import 'package:etc/helper/globals.dart';
import 'package:etc/helper/methods.dart';
import 'package:etc/helper/services.dart';
import 'package:etc/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
class MerchantPin extends StatefulWidget {
  MerchantPin({Key key}) : super(key: key);

  @override
  _MerchantPinState createState() => _MerchantPinState();
}

class _MerchantPinState extends State<MerchantPin> {

  String digit1="";
  String digit2="";
  String digit3="";
  String digit4="";
  int totalDigit = 0;
  dynamic voucher;
  bool _showLoader = false;

  @override
  void initState() {
    super.initState();
  }

  void _updatePin(key,context) async {
    
    if(key!="-"){
       if(this.digit1==""){
        this.digit1 = key;
        this.totalDigit=1;
      }else if(this.digit2==""){
        this.digit2 = key;
        this.totalDigit=2;
      }else if(this.digit3==""){
        this.digit3 = key;
        this.totalDigit=3;
      }else if(this.digit4==""){
        this.digit4 = key;
        this.totalDigit=4;
      }
    }else {
      if(this.digit4!=""){
        this.digit4="";
        this.totalDigit=3;
      }else if(this.digit3!=""){
        this.digit3="";
        this.totalDigit=2;
      }else if(this.digit2!=""){
        this.digit2="";
        this.totalDigit=1;
      }else if(this.digit1!=""){
        this.digit1="";
        this.totalDigit=0;
      }
    }
    setState(() {
      
    });
    print(this.digit1 + " // " + this.digit2 + " // " + this.digit3 + " // " + this.digit4);
    if(this.digit1!='' && this.digit2!='' && this.digit3!='' && this.digit4!=''){
      _showLoader = true;
      setState((){

      });
      //Validate outlet Pin
      //dealID,outletPIN,redeemVoucherCountRef
      var data = {};
      data['dealID']=voucher['dealID'];
      data['outletPIN']= this.digit1+""+this.digit2+""+this.digit3+""+this.digit4;
      data['redeemVoucherCountRef'] = voucherCountRef;
      
      try {
        var outletPin = await Services().validateOutletPin(data:data);
        print(outletPin);
        
        var dataR = {};
        dataR['dealID']=voucher['dealID'];
        dataR['outletPIN']=this.digit1+""+this.digit2+""+this.digit3+""+this.digit4;
        dataR['redeemVoucherCountRef']=voucherCountRef;

        try {
          var voucherRedeem = await Services().redeemVoucher(data:dataR);
          print(voucherRedeem);
          _showLoader = false;
          setState((){});
          Navigator.of(context).pushReplacementNamed('/voucherCode',arguments: {"vcode":voucherRedeem['code'],"voucher":voucher});
        }catch (e){
          print(e);
          _showLoader = false;
          setState((){});
        }

      }catch (e){
        print(e);
        this.digit1="";
        this.digit2="";
        this.digit3="";
        this.digit4="";
        _showLoader = false;
        Scaffold.of(context).showSnackBar(SnackBar(content: Text("Invalid Merchant PIN", textAlign: TextAlign.center,), backgroundColor: Colors.red,));
        setState(() {});
      }

    }
  }

  @override
  Widget build(BuildContext context) {

    final Map params = ModalRoute.of(context).settings.arguments as Map;
    voucher = params['voucher'];
    
    return ModalProgressHUD(
      inAsyncCall: _showLoader,
        progressIndicator: CircularProgressIndicator(strokeWidth: 1.5,),
        color: Colors.black,
          child: Scaffold(
        appBar:AppBar(
          title: Text("Merchant Pin"),
          elevation: 0.0,
        ),
        body:BlocBuilder<AuthenticateBloc, AuthenticateState>(
        builder: (context, state) {
         if (state is AuthenticateSuccess) {
        final profile = state.profile;
                  return SingleChildScrollView(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 30.0),
                        child: IDCard(profile:profile),
                        color: primaryColor,
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 10.0),
                        child: Column(
                          children:<Widget>[
                            Text("Pass phone to merchant", style: TextStyle(color: darkGrayColor, fontSize: 18.0, fontWeight: FontWeight.w600),),
                            Text("Please allow the merchant to enter their code.", style: TextStyle(color: darkGrayColor, fontSize: 16.0, height: 1.4),),
                          ]
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.15, 20.0, MediaQuery.of(context).size.width*0.15, 20.0),
                        child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:<Widget>[
                          Container(
                            child:Center(child:(this.digit1!='')?Icon(Icons.stop):null), 
                            width:55.0,
                            height:55.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              border: Border.all(color:blueColor, width: 1.5)
                            ),
                          ),
                          Container(
                            child:Center(child:(this.digit2!='')?Icon(Icons.stop):null), 
                            width:55.0,
                            height:55.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              border: Border.all(color:blueColor, width: 1.5)
                            ),
                          ),
                          Container(
                            child:Center(child:(this.digit3!='')?Icon(Icons.stop):null), 
                            width:55.0,
                            height:55.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              border: Border.all(color:blueColor, width: 1.5)
                            ),
                          ),
                          Container(
                            child:Center(child:(this.digit4!='')?Icon(Icons.stop):null), 
                            width:55.0,
                            height:55.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              border: Border.all(color:blueColor, width: 1.5)
                            ),
                          )
                      ]),),
                      Container(
                        child: Column(
                          children:<Widget>[
                            Container(
                              child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.min,
                        children:<Widget>[
                          InkWell(
                            onTap: (){ _updatePin("1",context); },
                            child: numKey("1")),
                          InkWell(
                            onTap: (){ _updatePin("2",context); },
                            child: numKey("2")),
                          InkWell(
                            onTap: (){ _updatePin("3",context); },
                            child: numKey("3"))
                          
                      ]),),
                      Container(
                              child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.min,
                        children:<Widget>[
                          InkWell(
                            onTap: (){ _updatePin("4",context); },
                            child: numKey("4")),
                          InkWell(
                            onTap: (){ _updatePin("5",context); },
                            child: numKey("5")),
                          InkWell(
                            onTap: (){ _updatePin("6",context); },
                            child: numKey("6"))
                          
                      ]),),
                      Container(
                              child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.min,
                        children:<Widget>[
                          InkWell(
                            onTap: (){ _updatePin("7",context); },
                            child: numKey("7")),
                          InkWell(
                            onTap: (){ _updatePin("8",context); },
                            child: numKey("8")),
                          InkWell(
                            onTap: (){ _updatePin("9",context); },
                            child: numKey("9"))
                          
                      ]),),
                      Container(
                              child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.min,
                        children:<Widget>[
                          numKey(""),
                          InkWell(
                            onTap: (){ _updatePin("0",context); },
                            child: numKey("0")),
                          InkWell(
                            onTap: (){ _updatePin("-",context); },
                            child: numKey("-"))
                          
                      ]),)
                          ]
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10.0),
                        child: Center(child: Image.asset("assets/img/vslogo-dark.png", height:22.0),),)
                    ],
                  ));
        }else {
        return NotAuthorized();
        }
      }),
      ),
    );
  }
}

Widget numKey(String numb){
  if(numb==""){
    return Container(
      child:null, 
      width:55.0,
      height:55.0,
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0.0),
        
      ),
    );
  }else if(numb=="-"){
    return Container(
      child:Center(child:Image.asset("assets/img/backspace.png", width:30.0), ), 
      width:55.0,
      height:55.0,
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
      
      ),
    );
  }else {
    return Container(
      child:Center(child:Text(numb,style:TextStyle(fontSize: 22.0)), ), 
      width:55.0,
      height:55.0,
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(color:primaryColor, width: 1.5)
      ),
    );
  }
  
}