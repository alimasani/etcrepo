import 'package:etc/bloc/authenticate/authenticate_bloc.dart';
import 'package:etc/bloc/profile/profile_bloc.dart';
import 'package:etc/bloc/users/users_bloc.dart';
import 'package:etc/helper/services.dart';
import 'package:etc/simple_bloc_delegate.dart';
import 'package:flutter/material.dart';
import 'package:etc/theme/theme.dart';
import 'package:etc/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:etc/helper/globals.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(

    MultiBlocProvider(providers: [
      BlocProvider<AuthenticateBloc>(
      create:(context){
        return AuthenticateBloc(Services())..add(AppStarted());
      },
      ),
      BlocProvider<UsersBloc>(create: (context) {
        return UsersBloc(authenticateBloc: AuthenticateBloc(Services()), services: Services());
      },),
      BlocProvider<ProfileBloc>(create: (context) {
        return ProfileBloc(Services());
      },)
    ], child: EtcApp(),)

    
  );
}

class EtcApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return BlocBuilder<AuthenticateBloc,AuthenticateState>(builder: (context,state){
      return MaterialApp(
        title: 'ETC',
        debugShowCheckedModeBanner: (appMode=="prod")?false:true,
        theme: appTheme(),
        initialRoute: '/',
        routes: routes,
      );
    },);
  }
}