import 'package:flutter/material.dart';

// App
const appMode = "staging";  //local, staging, prod, 
const appVersion = "1.0";

// API
List<Map<String, String>> baseURL = [{
    "mode":"local",
    "url":"https://test.voucherskout.com/resource/",
},{
  "mode":"staging",
  "url":"https://test.voucherskout.com/resource/",
},
    {
      "mode":"prod",
      "url":"https://services.voucherskout.com/resource/"
}];

const signatureVersion = "5";
const apiV1 = "v1/";
const openWeb = "openWebApi/";
const openWebCmn = "openWebApi/whitelabel/cmn/";
const authWeb = "whitelabel/expatsteachersclub/";
const requestContext = "MOBILE";

// Colors
const primaryColor = Color(0xFF2ab08b);
const blueColor = Color(0xFF40328a);
const grayColor = Color(0xFF707070);
const lightGrayColor = Color(0xFFf4f4f4);
const darkGrayColor = Color(0xFF545458);

// Footer
const footerLabels = ["Events","Offers","Map","Home","Favourites","Notifications","Profile"];
const footerIcons = ["assets/img/icon-calendar.png","assets/img/icon-list.png","assets/img/icon-map.png","assets/img/icon-home.png","assets/img/icon-heart.png","assets/img/icon-notification.png","assets/img/icon-user.png"];
const footerActiveIcons = ["assets/img/icon-calendar-active.png","assets/img/icon-list-active.png","assets/img/icon-map-active.png","assets/img/icon-home-active.png","assets/img/icon-heart-active.png","assets/img/icon-notification-active.png","assets/img/icon-user-active.png"];

//Generic
const rowsPerPage = "20";
const googleDocURL = "http://drive.google.com/viewerng/viewer?embedded=true&url=";
const faqURL = "https://voucherskout.s3.eu-central-1.amazonaws.com/images/production/miscellaneous/202002241730_SamsungPay_VoucherSkout_FAQ.pdf";
const termsURL = "https://voucherskout.s3.eu-central-1.amazonaws.com/images/production/miscellaneous/202002241730_SamsungPay_VoucherSkout_T%26C.pdf";
const privacyURL = "https://voucherskout.s3.eu-central-1.amazonaws.com/images/production/miscellaneous/202002241730_SamsungPay_VoucherSkout_PrivacyPolicy.pdf";


dynamic currentFilterParams = {};
dynamic currentUserProfile = {};
dynamic currentOfferDetails = {};
dynamic gCategories;
dynamic gFilters;
String voucherCountRef = "1-V";
String showFirstPopup = "false";
dynamic gCountries = {};
dynamic gSubscriptionPlans = {};