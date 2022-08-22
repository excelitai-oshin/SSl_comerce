import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'as convert;

import '../model/reciptlist_model.dart';
class ReceiptList{
  Future<ReciptlistModel>getReceiptData()async{
    Map<String, dynamic>? result ;

    try{
      String url ="https://beta-dtba.btla.net/api/member/receipt/list?INSTANCE-NAME=sibldtba459807&INSTANCE-API-SECRETE=k8wscw04kwwok4gcwsk488o4sog8o00gsgwsog0k&membership_number=A00014";
   http.Response response =await http.get(Uri.parse(url));
   if(response.statusCode==200){
     result=convert.jsonDecode(response.body);
     print(response.body);

     return ReciptlistModel.fromJson(result!);
   }
    }catch(e){
      print("error ${e.toString()}");
    } return ReciptlistModel.fromJson(result!);

  }
}