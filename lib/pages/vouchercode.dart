import 'package:etc/bloc/bloc.dart';
import 'package:etc/helper/globals.dart';
import 'package:etc/helper/services.dart';
import 'package:etc/pages/offerdetails.dart';
import 'package:etc/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VoucherCode extends StatefulWidget {
  VoucherCode({Key key}) : super(key: key);

  @override
  _VoucherCodeState createState() => _VoucherCodeState();
}

class _VoucherCodeState extends State<VoucherCode> {

  dynamic voucher;

  _gotoOfferDetails(ctx){

    Navigator.of(ctx).pushReplacement(MaterialPageRoute(
                                    builder: (_) => BlocProvider(
                                      create: (context) =>
                                          OfferdetailsBloc(Services()),
                                      child: OfferDetails(offerId: voucher['offerID'],outletId: voucher['outletID'],outletName: voucher['outletName']),
                                    ),
                                    //(_)=>OfferDetails(oItem: itm,)
                                  ));

  }

  @override
  Widget build(BuildContext context) {
    final Map params = ModalRoute.of(context).settings.arguments as Map;
    final vcode = params['vcode'];
    voucher = params['voucher'];

    return Scaffold(
        appBar: AppBar(title: Text("Voucher Redeemption"), elevation: 0.0),
        body: Builder(builder: (BuildContext context){
          return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 20.0, bottom: 40.0),
            child: Column(children: <Widget>[
              Icon(
                Icons.check,
                color: Colors.white,
                size: 60.0,
              ),
              SizedBox(
                height: 40.0,
              ),
              Text(
                "Success!",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.w600),
              )
            ]),
            decoration: BoxDecoration(color: primaryColor),
          ),
          Expanded(
              child: Container(
              
              padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*.10,30.0,MediaQuery.of(context).size.width*.10,30.0),
              child: Center(
                child: Container(
                  height: 225.0,
                  padding:EdgeInsets.fromLTRB(20.0,50.0,20.0,50.0),
                  child: Column(
                    children:<Widget>[
                      Text(vcode, style:TextStyle(color: blueColor, fontSize:18.0, fontWeight:FontWeight.w600),),
                      SizedBox(height: 15.0,),
                      InkWell(
                        onTap: (){
                          Clipboard.setData(ClipboardData(text:vcode));
                          Scaffold.of(context).showSnackBar(SnackBar(content: Text("Voucher code copied to clipboard.", textAlign: TextAlign.center,),));
                        },
                                              child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                          Icon(Icons.content_copy, color: Colors.black26, size: 20.0,),
                          Text("  Copy Code", style: TextStyle(color: Colors.black26, fontSize: 16.0),)
                        ],),
                      ),
                      SizedBox(height: 30.0,),
                      Text("Please show this code to merchant to complete your redeemption.", style:TextStyle(color: grayColor, fontSize:15.0, height: 1.2), textAlign: TextAlign.center,),
                    ]
                  ),
                  decoration: BoxDecoration(
                    border:Border.all(color:Colors.black26,width: 2),
                    borderRadius: BorderRadius.circular(5.0)
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin:EdgeInsets.all(20.0),
            child: FlatButton(
                      onPressed: () {
                          _gotoOfferDetails(context);
                      },
                      child: Container(
                          padding:EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 12.0),
                          child: Text(
                            "DONE".toUpperCase(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                height: 1.2,
                                fontWeight: FontWeight.w600),
                          )),
                      color: blueColor,
                    ),)
            ],
          ),
        );
        })
        );
  }
}
