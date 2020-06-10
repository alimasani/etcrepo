import 'dart:convert';

class DataProcess {
  
  dynamic encode(String method, dynamic data) {
    if(method=="base64"){
      
      if(data is String){
        return base64Encode(utf8.encode(data));
      }else {
        return base64Encode(utf8.encode(json.encode(data)));
      }
      
    }else {
      return data;
    }
  }
  
  dynamic decode(String method, dynamic data) {
    if(method=="base64"){
      return utf8.decode(base64Decode(data.toString()));
    }else {
      return data;
    }
  }
  
}