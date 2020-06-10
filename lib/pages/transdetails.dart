import 'package:etc/helper/globals.dart';
import 'package:etc/helper/methods.dart';
import 'package:flutter/material.dart';

class TransDetails extends StatelessWidget {
  const TransDetails({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    dynamic transItem;
    final Map params = ModalRoute.of(context).settings.arguments as Map;
    transItem = params['transItem'];

    return Scaffold(
      appBar: AppBar(title: Text("Transaction Details"), centerTitle: true),
      body: Container(
          padding: EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Table(
              columnWidths: {1: FractionColumnWidth(0.6)},
              border: TableBorder.all(color:lightGrayColor),
              children: [
                TableRow(
                  children: [
                  Container(
                    padding: EdgeInsets.only(left:7.0,top:7.0,right:5.0,bottom:7.0),
                    child:Text("Reference Number:", style: TextStyle(height: 1.2, fontWeight: FontWeight.w600),)),
                  Container(
                    padding: EdgeInsets.only(left:7.0,top:7.0,right:5.0,bottom:7.0),
                    child:Text(transItem['transactionReference'], style: TextStyle(height: 1.2, fontWeight: FontWeight.w400),)),
                ]),
                TableRow(
                  children: [
                  Container(
                    padding: EdgeInsets.only(left:7.0,top:7.0,right:5.0,bottom:7.0),
                    child:Text("Discount Code:", style: TextStyle(height: 1.2, fontWeight: FontWeight.w600),)),
                  Container(
                    padding: EdgeInsets.only(left:7.0,top:7.0,right:5.0,bottom:7.0),
                    child:Text(transItem['discountCode'], style: TextStyle(height: 1.2, fontWeight: FontWeight.w400),)),
                ]),
                TableRow(
                  children: [
                  Container(
                    padding: EdgeInsets.only(left:7.0,top:7.0,right:5.0,bottom:7.0),
                    child:Text("Date and Time:", style: TextStyle(height: 1.2, fontWeight: FontWeight.w600),)),
                  Container(
                    padding: EdgeInsets.only(left:7.0,top:7.0,right:5.0,bottom:7.0),
                    child:Text(HelperMethods().formatDateTime(format:"dd MMM yyyy HH:mm",dateTime:transItem['transactionDateTime']), style: TextStyle(height: 1.2, fontWeight: FontWeight.w400),)),
                ]),
                TableRow(
                  children: [
                  Container(
                    padding: EdgeInsets.only(left:7.0,top:7.0,right:5.0,bottom:7.0),
                    child:Text("Offer:", style: TextStyle(height: 1.2, fontWeight: FontWeight.w600),)),
                  Container(
                    padding: EdgeInsets.only(left:7.0,top:7.0,right:5.0,bottom:7.0),
                    child:Text(transItem['voucher']['discountType'] + " " + transItem['voucher']['voucherName'], style: TextStyle(height: 1.2, fontWeight: FontWeight.w400),)),
                ]),
                TableRow(
                  children: [
                  Container(
                    padding: EdgeInsets.only(left:7.0,top:7.0,right:5.0,bottom:7.0),
                    child:Text("Location:", style: TextStyle(height: 1.2, fontWeight: FontWeight.w600),)),
                  Container(
                    padding: EdgeInsets.only(left:7.0,top:7.0,right:5.0,bottom:7.0),
                    child:Text(transItem['outlet']['outletName'], style: TextStyle(height: 1.2, fontWeight: FontWeight.w400),)),
                ])
              ],
            ),
          )),
    );
  }
}
