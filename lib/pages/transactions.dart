import 'package:etc/bloc/bloc.dart';
import 'package:etc/components/loader.dart';
import 'package:etc/components/norecords.dart';
import 'package:etc/components/notauthorized.dart';
import 'package:etc/components/transitem.dart';
import 'package:etc/helper/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class Transactions extends StatefulWidget {
  Transactions({Key key}) : super(key: key);

  @override
  _TransactionsState createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {

  bool _loading = false;
  List<dynamic> _transList = [];

  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void didChangeDependencies() async {
    super.didChangeDependencies();
    _loading = true;
    setState(() {});
    try{
      var resp =  await Services().getTransHistory();
      _transList = resp['redemptions'];
      print(_transList);
      _loading = false;
      setState(() {});
    }catch(e){
      _transList = [];
      _loading = false;
      setState(() {});
    }
    
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text("Transactions History"),
        centerTitle:true
      ),
      body:BlocBuilder<AuthenticateBloc, AuthenticateState>(
      builder: (context, state) {
        if (state is! AuthenticateSuccess) {
          return NotAuthorized();
        } else {
          return Container(
            padding: EdgeInsets.only(top:10.0),
            child: (_loading==true)?CustomLoader():Container(
              child: (_transList.length>0)?
                ListView.builder(
                      itemCount: _transList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                              // Navigator.of(context).pushNamed('/transactionDetails',arguments:{"transItem":_transList[index]});
                          },
                          child: Container(
                            child: TransItem(transItem:_transList[index]),
                          ),
                        );
                      })
              :NoRecords(icon:"",title:"Oops!",message:"It seems you haven't redeem any deal yet.")
              ,)
          );
        }
      },
    )
    );
  }
}