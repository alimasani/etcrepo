import 'package:etc/helper/globals.dart';
import 'package:etc/helper/methods.dart';
import 'package:flutter/material.dart';
class TransItem extends StatelessWidget {
  final dynamic transItem;
  const TransItem({Key key, this.transItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:EdgeInsets.fromLTRB(10.0,5.0,10.0,10.0),
      padding:EdgeInsets.all(0.0),
      decoration: BoxDecoration(
        // border:Border.all(color:Colors.black12),
        color:Colors.white,
        // borderRadius: BorderRadius.circular(5.0),
        boxShadow: [BoxShadow(
      color: Colors.black26,
      blurRadius: 3.0,
    ),]
      ),
      child: Row(
        children: <Widget>[
        // Container(
        //   padding: EdgeInsets.all(10.0),
        //   decoration: BoxDecoration(
        //     color:blueColor,
        //   ),
        //   child:Center(
        //     child: Column(children: <Widget>[
        //       Text(HelperMethods().formatDateTime(format:"dd MMM",dateTime:transItem['transactionDateTime']),style: TextStyle(color:Colors.white, fontSize: 16.0, fontWeight: FontWeight.w600, height: 1.2),),
        //       Text(HelperMethods().formatDateTime(format:"yyyy",dateTime:transItem['transactionDateTime']),style: TextStyle(color:Colors.white, fontSize: 14.0, fontWeight: FontWeight.w300, height: 1.2),)
        //     ],),
        //   )
        // ),
        Container(
          width: MediaQuery.of(context).size.width*0.95,
          padding: EdgeInsets.all(0.0),
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
            
            Container(
              padding: const EdgeInsets.only(left:10.0,right:10.0,top:7.0,bottom:7.0),
              color: blueColor,
              child: Text(transItem['voucher']['discountType'] + " " + transItem['voucher']['voucherName'], style:TextStyle(color: Colors.white, fontWeight: FontWeight.w600, height: 1.3, fontSize: 16.0,), overflow: TextOverflow.ellipsis, textAlign: TextAlign.left,),
            ),
            Padding(
              padding: const EdgeInsets.only(left:10.0,right:10.0,top:10.0),
              child: Row(
                children: <Widget>[
                  Icon(Icons.place,size: 14.0, color: Colors.black26,),
                  Expanded(child: Text(transItem['outlet']['outletName'], style:TextStyle(color: darkGrayColor, fontWeight: FontWeight.w400, height: 1.3, fontSize: 14.0,), textAlign: TextAlign.left,),)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:10.0,right:10.0,top:7.0),
              child: Row(
                children: <Widget>[
                  Icon(Icons.watch_later,size: 13.0, color: Colors.black26,),
                  Expanded(child: Text(" "+HelperMethods().formatDateTime(format:"dd MMM yyyy HH:mm",dateTime:transItem['transactionDateTime']), style:TextStyle(color: darkGrayColor, fontWeight: FontWeight.w400, height: 1.3, fontSize: 14.0,), textAlign: TextAlign.left,),)
                ],
              ),
            ),
            Divider(color: Colors.black12,),
            Padding(
              padding: const EdgeInsets.only(left:10.0,right:10.0,top:5.0),
              child:RichText(text: TextSpan(text: "Transaction ID: ",style: TextStyle(color: darkGrayColor, fontWeight: FontWeight.w400), children: [TextSpan(text:transItem['transactionReference'],style: TextStyle(fontWeight: FontWeight.w600))]),)
            ),
            Padding(
              padding: const EdgeInsets.only(left:10.0,right:10.0,top:5.0,bottom:10.0),
              child:RichText(text: TextSpan(text: "Discount Code: ", style: TextStyle(color: darkGrayColor, fontWeight: FontWeight.w400), children: [TextSpan(text:transItem['discountCode'],style: TextStyle(fontWeight: FontWeight.w600, color: primaryColor,))]),)
            ),
            
          ],)
        )
      ],),
    );
  }
}