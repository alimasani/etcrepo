import 'dart:io';
import 'package:dio/dio.dart';
import 'package:etc/helper/data-process.dart';
import 'package:etc/helper/globals.dart';
import 'package:etc/helper/methods.dart';
import 'package:etc/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:etc/helper/app_exaptions.dart';
import 'dart:convert';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class ApiBaseHelper {
  // final String _baseUrl = baseURL[baseURL.indexOf()]['url'];

  String _baseUrl= HelperMethods().searchArray(baseURL, "mode", appMode)['url'];
  
  Future<dynamic> api({String method, String url, body, Map<String, dynamic> headers}) async {
    print('Api Get, url $_baseUrl$url');
    var responseJson;

    Dio dio = Dio();
    
    if(headers['tokenRequiresRefresh']=="true"){

        var prefs = await SharedPreferences.getInstance();
        var token = prefs.getString('authToken');
        if(token!=null && token!=''){
          var data = {};
          data['requestType']='REFRESH_TOKEN';
          data['requestContext']=requestContext;
          
          Map<String, dynamic> newHeaders = {};
          newHeaders['authorization']=token;
          newHeaders['requestParams']= DataProcess().encode("base64", data);
          Response tokenResp;
          try{
            tokenResp = await dio.get(_baseUrl + openWeb + authWeb + apiV1 + 'manageSessionToken', options:Options(headers:newHeaders));
          }catch (e){
            throw e;
          }
          

          final decodedResp = json.decode(DataProcess().decode("base64", tokenResp.data['data']));
          
          await prefs.setString("authToken",decodedResp['desc']);
          headers['authorization'] = decodedResp['desc'];

        }else {
          headers['authorization'] = '';
        }
        

    }
    headers.remove("tokenRequiresRefresh");
    print(headers);
    try {
      headers['Accept']="application/json";
      var response;
      if(method=='POST'){
         response = await dio.post(_baseUrl + url, data:body, options:Options(headers: headers, method: 'POST'));
      }else{
         response = await dio.get(_baseUrl + url, options:Options(headers: headers));
      }
      
      responseJson = _returnResponse(response);
    } on DioError catch (e) {
        print(e.response);
        _returnResponse(e.response);
    }
    print('api get recieved!');
    return responseJson;
  }

}

 _returnResponse(response) {

  switch (response.statusCode) {
    case 200:
      // var tmp = json.decode(response['data']);
      
      var responseJson = json.decode(DataProcess().decode("base64", response.data['data']));
      return responseJson;
    case 400:
      // var tmp = json.decode(response.body.toString());
      var responseJson = json.decode(DataProcess().decode("base64", response.data['data']));
      throw BadRequestException(responseJson[0]['desc']);
    case 401:
    case 403:
      throw UnauthorisedException(response.body.toString());
    case 404:
      throw NotFoundException(response.body.toString());
    case 500:
    default:
      throw FetchDataException(
          'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
  }
}