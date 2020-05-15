import 'package:etc/bloc/bloc.dart';
import 'package:etc/helper/globals.dart';
import 'package:etc/helper/services.dart';
import 'package:etc/pages/home.dart';
import 'package:etc/pages/login.dart';
import 'package:etc/pages/merchantpin.dart';
import 'package:etc/pages/offers.dart';
import 'package:etc/pages/vouchercode.dart';
import 'package:etc/pages/welcome.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/":(BuildContext context) => Welcome(),
  "/login":(BuildContext context) => Login(),
  "/home": (BuildContext context) => MultiBlocProvider(
    providers: [
      BlocProvider<FooterBloc>(
        create: (context) => FooterBloc(),
      ),
      BlocProvider(create: (context)=>CategoriesBloc(Services())..add(GetCategories())),
      BlocProvider(create: (context)=>FeaturedOffersBloc(Services())..add(GetFeaturedOffers(userProfile:currentUserProfile))),
      BlocProvider(create: (context)=>BrandsBloc(Services())..add(GetPopularBrands())),
      BlocProvider(create: (context)=>EventsBloc(Services())),
      BlocProvider(create: (context)=>OffersBloc(Services())),
      BlocProvider(create: (context)=>ProfileBloc(Services())),
      BlocProvider(create: (context)=>NotificationBloc(Services()))
    ],
    child: Home()),
  "/Offers": (BuildContext context) => Offers(),
  "/merchantPin": (BuildContext context) => MerchantPin(),
  "/voucherCode": (BuildContext context) => VoucherCode(),

};