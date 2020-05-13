import 'dart:async';

import 'package:etc/helper/api.dart';
import 'package:etc/helper/data-process.dart';
import 'package:etc/helper/globals.dart';
import 'package:etc/models/categories.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Services {
  // Check System Health
  Future<List<dynamic>> checkSystemHealth(dynamic data) async {
    final url = openWebCmn + 'systemHealth';
    Map<String, String> headers = {};
    if (data != '' && data != null) {
      headers['requestParams'] = DataProcess().encode("base64", data);
    }
    headers['tokenRequiresRefresh']="false";
    final response = await ApiBaseHelper().api(method:"GET",url:url,body:null, headers:headers);
    return response;
  }

  // Get Redemption Processes
  Future<List<dynamic>> getRedeptionProcesses(dynamic data) async {
    final url = openWebCmn + 'redemptionProcesses';
    Map<String, String> headers = {};
    if (data != '' && data != null) {
      headers['requestParams'] = DataProcess().encode("base64", data);
    }
    headers['tokenRequiresRefresh']="false";
    final response = await ApiBaseHelper().api(method:"GET",url:url,body:null, headers:headers);
    return response;
  }

  // Get Filters
  Future<List<dynamic>> getFilters(dynamic data) async {
    final url = openWebCmn + 'filters';
    Map<String, String> headers = {};
    if (data != '' && data != null) {
      headers['requestParams'] = DataProcess().encode("base64", data);
    }
    headers['tokenRequiresRefresh']="false";
    final response = await ApiBaseHelper().api(method:"GET",url:url,body:null, headers:headers);
    return response;
  }
  
  // Get Countries
  Future<List<dynamic>> getCountries(dynamic data) async {
    final url = openWebCmn + 'countries';
    Map<String, String> headers = {};
    if (data != '' && data != null) {
      headers['requestParams'] = DataProcess().encode("base64", data);
    }
    final response = await ApiBaseHelper().api(method:"GET",url:url,body:null, headers:headers);
    return response;
  }

  // Get cities
  Future<List<dynamic>> getCities(dynamic data) async {
    final url = openWeb + authWeb + apiV1 + 'cities';
    Map<String, String> headers = {};
    if (data != '' && data != null) {
      headers['requestParams'] = DataProcess().encode("base64", data);
    }
    headers['tokenRequiresRefresh']="false";
    final response = await ApiBaseHelper().api(method:"GET",url:url,body:null, headers:headers);
    return response;
  }
  
  // Get categories
  Future<List<dynamic>> getCategories(dynamic data) async {
    final url = openWeb + authWeb + apiV1 + 'categories';
    Map<String, String> headers = {};
    if (data != '' && data != null) {
      headers['requestParams'] = DataProcess().encode("base64", data);
    }
    headers['tokenRequiresRefresh']="false";
    final response = await ApiBaseHelper().api(method:"GET",url:url,body:null, headers:headers);
    return response;
  }

  // Get brands
  Future<List<dynamic>> getBrands(dynamic data) async {
    final url = openWeb + authWeb + apiV1 + 'brands';
    Map<String, String> headers = {};
    if (data != '' && data != null) {
      headers['requestParams'] = DataProcess().encode("base64", data);
    }
    headers['tokenRequiresRefresh']="false";
    final response = await ApiBaseHelper().api(method:"GET",url:url,body:null, headers:headers);
    return response;
  }

  // Get Offers
  Future<List<dynamic>> getOffers(
      {dynamic data, String start = "1", String offset = rowsPerPage}) async {
    /*Request Parms: {
            mapMBR{minLat, minLong, maxLat, maxLong}, 
            brandIDs[string], 
            categoryIDs[string], 
            cityIDs[string],
            searchKeyword,
            filters[{key,value}],
            viewNewOffers,
            viewFeaturedOffers,
            userID,
            userName,
            userLocation{latitude,longitude},
            viewUserBookmarkedOffers,
            viewUserEntitledOffers
        }
        type: list, search
        */

    final url = openWeb + authWeb + apiV1 + 'offers';
    var startOffset = "";
    if (start != '0') {
      startOffset = "?start=" + start + "&offset=" + offset;
    }
    Map<String, String> headers = {};
    if (data != '' && data != null) {
      headers['requestParams'] = DataProcess().encode("base64", data);
    }
    if(data['userID']!='' && data['userID']!=null){
      headers['tokenRequiresRefresh']="true";
    }else {
      headers['tokenRequiresRefresh']="false";
    }
    
    final response = await ApiBaseHelper().api(method:"GET",url:url+startOffset,body:null, headers:headers);
    return response;
  }

  // Get Offer Details
  Future<dynamic> getOfferDetails(dynamic data) async {
    /*
        Request Parms: {
            dataRequestTypes,
            offerID,
            outletID,
            userID,
            userName,
            userLocation:{latitude,longitude}
        }*/

    final url = openWeb + authWeb + apiV1 + 'offer';
    Map<String, String> headers = {};
    if (data != '' && data != null) {
      headers['requestParams'] = DataProcess().encode("base64", data);
    }
    if(data['userID']!='' && data['userID']!=null){
      headers['tokenRequiresRefresh']="true";
    }else {
      headers['tokenRequiresRefresh']="false";
    }
    final response = await ApiBaseHelper().api(method:"GET",url:url,body:null, headers:headers);
    return response;
  }

  // Get events
  Future<List<dynamic>> getEvents(
      {dynamic data, String start = "1", String offset = rowsPerPage}) async {
    /*Request Parms: {
            startDateTime,
            endDateTime
        }*/

    final url = openWeb + authWeb + apiV1 + 'events';
    var startOffset = "";
    if (start != '0') {
      startOffset = "?start=" + start + "&offset=" + offset;
    }
    Map<String, String> headers = {};
    if (data != '' && data != null) {
      headers['requestParams'] = DataProcess().encode("base64", data);
    }
    headers['tokenRequiresRefresh']="false";
    final response = await ApiBaseHelper().api(method:"GET",url:url+startOffset,body:null, headers:headers);
    return response;
  }
  
  // send otp
  Future<List<dynamic>> senOTP({dynamic data}) async {
    /*Request Parms: {
            userIdentity,
            otpTransferMode,
            requetContext
        }*/

    final url = openWeb + authWeb + apiV1 + 'sendOTP';
    
    Map<String, String> headers = {};
    if (data != '' && data != null) {
      headers['requestParams'] = DataProcess().encode("base64", data);
    }
    headers['tokenRequiresRefresh']="false";
    final response = await ApiBaseHelper().api(method:"POST",url:url,body:null, headers:headers);
    return response;
  }
  
  // validate otp
  Future<List<dynamic>> validateOTP({dynamic data}) async {
    /*Request Parms: {
            userIdentity,
            oneTimePassword,
            requetContext
        }*/

    final url = openWeb + authWeb + apiV1 + 'validateOTP';
    
    Map<String, String> headers = {};
    if (data != '' && data != null) {
      headers['requestParams'] = DataProcess().encode("base64", data);
    }
    headers['tokenRequiresRefresh']="false";
    final response = await ApiBaseHelper().api(method:"POST",url:url,body:null, headers:headers);
    return response;
  }
  
  // user login
  Future<dynamic> userLogin({String username, String password}) async {
    /*Request Parms: {
            requestType,
            requestContext,
        }*/

    final url = openWeb + authWeb + apiV1 + 'manageSessionToken';
    
    Map<String, String> headers = {};
    var data = {};
    data['requestType']="TOKEN";
    data['requestContext']="MOBILE";
    if (data != '' && data != null) {
      headers['requestParams'] = DataProcess().encode("base64", data);
    }
    
    headers['authorization']=DataProcess().encode("base64",password+":"+username+":NONE:NONE:NONE");
    print(headers['authorization']);
    headers['tokenRequiresRefresh']="false";
    try{
      final response = await ApiBaseHelper().api(method:"GET",url:url,body:null, headers:headers);
      return response;
    }catch(e){
      throw e;
    }
  }
  
  // Refresh token
  Future<List<dynamic>> refreshToken() async {
    /*
    authorization:
    Request Parms: {
            requestType,
            requestContext,
        }*/

    final url = openWeb + authWeb + apiV1 + 'manageSessionToken';
    var data = {};
    data['requestType']='REFRESH_TOKEN';
    data['requestContext']=requestContext;
    Map<String, String> headers = {};
    if (data != '' && data != null) {
      headers['requestParams'] = DataProcess().encode("base64", data);
    }
    headers['tokenRequiresRefresh']="true";
    final response = await ApiBaseHelper().api(method:"GET",url:url,body:null, headers:headers);
    return response;
  }
  
  // Logout
  Future<dynamic> logoutUser() async {
    /*
    authorization:
    Request Parms: {
            requestType,
            requestContext,
        }*/

    final url = openWeb + authWeb + apiV1 + 'manageSessionToken';
    var data = {};
    data['requestType']='LOGOUT';
    data['requestContext']=requestContext;
    Map<String, String> headers = {};
    if (data != '' && data != null) {
      headers['requestParams'] = DataProcess().encode("base64", data);
    }
    headers['tokenRequiresRefresh']="true";
    try{
      final response = await ApiBaseHelper().api(method:"GET",url:url,body:null, headers:headers);
      return response;
    }catch(e){
      throw e;
    }
  }
  
  // get user profile
  Future<dynamic> getProfile() async {
    /*authorization: */

    final url = authWeb + apiV1 + 'userStatistics';
    
    Map<String, String> headers = {};
    headers['tokenRequiresRefresh']="true";
    try{
      final response = await ApiBaseHelper().api(method:"GET",url:url,body:null, headers:headers);
      return response;
    }catch(e){
      throw e;
    }
  }
  
  // get user profile
  Future<dynamic> getNotifications() async {
    /*authorization: */

    final url = authWeb + apiV1 + 'notifications';
    
    Map<String, String> headers = {};
    headers['tokenRequiresRefresh']="true";
    try{
      final response = await ApiBaseHelper().api(method:"GET",url:url,body:null, headers:headers);
      return response;
    }catch(e){
      throw e;
    }
  }
  

  // register device
  Future<List<dynamic>> registerDevice({dynamic data}) async {
    /*
    authorization:
    Request Parms: {
            deviceType,
            deviceID,
        }*/

    final url = openWeb + authWeb + apiV1 + 'registerDevice';
    
    Map<String, String> headers = {};
    if (data != '' && data != null) {
      headers['requestParams'] = DataProcess().encode("base64", data);
    }
    headers['tokenRequiresRefresh']="true";
    final response = await ApiBaseHelper().api(method:"POST",url:url,body:null, headers:headers);
    return response;
  }
  
  // toggle Bookmark
  Future<dynamic> toggleBokmark({dynamic data}) async {
    /*
    authorization:
    Request Parms: {
            offerID,
            outletID,
        }*/

    final url =  authWeb + apiV1 + 'toggleBookmark';
    
    Map<String, String> headers = {};
    if (data != '' && data != null) {
      headers['requestParams'] = DataProcess().encode("base64", data);
    }
    headers['tokenRequiresRefresh']="true";
    final response = await ApiBaseHelper().api(method:"POST",url:url,body:null, headers:headers);
    return response;
  }
  
  // validate deal
  Future<List<dynamic>> validateDeal({dynamic data}) async {
    /*
    authorization:
    Request Parms: {
            dealID,
            redeemVoucherCountRef,
        }*/

    final url = openWeb + authWeb + apiV1 + 'validateDeal';
    
    Map<String, String> headers = {};
    if (data != '' && data != null) {
      headers['requestParams'] = DataProcess().encode("base64", data);
    }
    headers['tokenRequiresRefresh']="true";
    final response = await ApiBaseHelper().api(method:"GET",url:url,body:null, headers:headers);
    return response;
  }
  
  // validate user
  Future<List<dynamic>> validateUser({dynamic data}) async {
    /*
    authorization:
    Request Parms: {
            userPassword,
        }*/

    final url = openWeb + authWeb + apiV1 + 'validateUser';
    
    Map<String, String> headers = {};
    if (data != '' && data != null) {
      headers['requestParams'] = DataProcess().encode("base64", data);
    }
    headers['tokenRequiresRefresh']="true";
    final response = await ApiBaseHelper().api(method:"GET",url:url,body:null, headers:headers);
    return response;
  }
  
  Future<void> saveLocalStorage({String key, String auth}) async{
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, auth);
    return true;
  }
  
  Future<void> deleteLocalStorage({String key}) async{
    var prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
    return true;
  }
  
  Future<dynamic> getLocalStorage({String key}) async{
    var prefs = await SharedPreferences.getInstance();
    String auth = prefs.getString(key)??null;
    return auth;
  }

}
