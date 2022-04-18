


import '../models/stage.dart';
import 'api_helper.dart';
import 'package:dio/dio.dart';

Future<dynamic> postContactUsApi(String name,String email, String subject, String message) async {

var data={"name":name,
"email":email,
"subject":subject,
"message":message};
  // TODO: implement lang from storage
  Response? response= await ApiHelper().postAsyncNormal("send-message",data );
  if(response?.statusCode==200) {

    return  response?.data["data"]["message"];

//    return City.fromMap(response?.data["data"]);
  }
  else{
    return response;
  }
}