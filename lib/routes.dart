import 'package:etc/bloc/bloc.dart';
import 'package:etc/components/settings.dart';
import 'package:etc/pages/topics.dart';
import 'package:etc/helper/globals.dart';
import 'package:etc/helper/services.dart';
import 'package:etc/pages/changeemail.dart';
import 'package:etc/pages/changepass.dart';
import 'package:etc/pages/forgotpass.dart';
import 'package:etc/pages/home.dart';
import 'package:etc/pages/login.dart';
import 'package:etc/pages/merchantpin.dart';
import 'package:etc/pages/offers.dart';
import 'package:etc/pages/otp.dart';
import 'package:etc/pages/password.dart';
import 'package:etc/pages/personalinfo.dart';
import 'package:etc/pages/setpassword.dart';
import 'package:etc/pages/splash.dart';
import 'package:etc/pages/transactions.dart';
import 'package:etc/pages/transdetails.dart';
import 'package:etc/pages/vouchercode.dart';
import 'package:etc/pages/welcome.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/":(BuildContext context) => Splash(),
  "/welcome":(BuildContext context) => Welcome(),
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
  "/password": (BuildContext context) => Password(),
  "/transactions": (BuildContext context) => Transactions(),
  "/transactionDetails": (BuildContext context) => TransDetails(),
  "/settings": (BuildContext context) => Settings(),
  "/topics": (BuildContext context) => Topics(),
  "/forgotPass": (BuildContext context) => ForgotPass(),
  "/setPassword": (BuildContext context) => SetPassword(),
  "/personalInfo": (BuildContext context) => PersonalInfo(),
  "/changeEmail": (BuildContext context) => ChangeEmail(),
  "/otp": (BuildContext context) => OTP(),
  "/changePass": (BuildContext context) => ChangePass(),

};