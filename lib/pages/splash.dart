import 'package:etc/bloc/authenticate/authenticate_bloc.dart';
import 'package:etc/helper/globals.dart';
import 'package:etc/helper/methods.dart';
import 'package:etc/helper/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class Splash extends StatefulWidget {
  Splash({Key key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool _initLoaded = false;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    gCountries = await Services().getCountries(null);

    print("////////");
    print(gCountries);
    print("////////");
    
    var dt = {};
    dt['requestContext'] = requestContext;
    dt['viewActivePlans'] = "false";
    gSubscriptionPlans = await Services().getSubscriptionPlans(dt);

    print("++++++++");
    print(gSubscriptionPlans);
    print("++++++++");

    try {
      var filters = 
      await Services().getFilters(null);
      // print(filters);
      var tmp = filters.map((v){
        print(v);
        v['selected']=false;

        if(v['type']=='LOV'){
          var ji = v['lookups'].split(",");
          var lk = ji.map((s){
            var n = {
              "label":s,
              "selected":false
            };
            return n;
          }).toList();
          v['arrayLookups'] = lk;
        } 

        return v;
      }).toList();
      print(tmp);
      gFilters = tmp;
      setState(() {
        _initLoaded = true;
      });
    }catch (e){
      setState(() {
        _initLoaded = true;
      });
      print(e);
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:null,
      body:BlocConsumer<AuthenticateBloc,AuthenticateState>(
        listener: (context,state){
          if(state is AuthenticateSuccess){
            Navigator.of(context).pushReplacementNamed('/home');
          }
          if(state is AuthenticateError){
            Navigator.of(context).pushReplacementNamed('/welcome');
          }
        },
        builder: (context,state){
          if(state is! AuthenticateSuccess){
            return Container(
              child: Center(child: Image.asset('assets/img/logo.png', width: MediaQuery.of(context).size.width*0.6,),) ,);
          }else{
            return Container(child:null);
          }
      },)
    );
  }
}