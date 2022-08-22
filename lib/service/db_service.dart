import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../main.dart';
import '../model/LogedInSessionModel.dart';
import '../model/bank_receipt/bank_receipt_model.dart';
import '../model/file_list.dart';
import '../model/member_profile.dart';
import '../model/receipt_list_model.dart';
import '../view/component/app_style.dart';
import '../view/home_screen.dart';
import 'local_storage.dart';
///
/// DBService class works for http request.
///
class DBService {
  ///
  ///getPaymentDetails() is a future function.
  ///it's return List of Data (List<Data>?)objects,
  Future<List<Data>?> getBankReceiptDetails() async {
    final response = await http.get(
        Uri(
          scheme: 'https',
          host: 'beta-dtba.btla.net',
          path: 'api/bank/receipt',
          queryParameters: {
            'receipt_number': '${receiptNumber}',//'180001',
          },
        ),
        headers: {
          'Content-type': 'application/json',
          'instance-api-secrete': "k8wscw04kwwok4gcwsk488o4sog8o00gsgwsog0k",
          'instance-name': 'sibldtba459807',
        });
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      PaymentModel paymentModel = PaymentModel.fromJson(json);
      return paymentModel.data;
    } else {
      throw Exception(
          'Failed to load ... status code:${response.statusCode}\n${response.body}'
      );
    }
  }

  Future<MemberProfile?> getMemberProfile(String membershipNumber) async {
    final response = await http.get(
        Uri(
          scheme: 'https',
          host: 'beta-dtba.btla.net',
          path: 'api/member/profile',
          queryParameters: {
            'membership_number': '${membershipNumber}',//'A00014',
          },
        ),
        headers: {
          'Content-type': 'application/json',
          'instance-api-secrete': "k8wscw04kwwok4gcwsk488o4sog8o00gsgwsog0k",
          'instance-name': 'sibldtba459807',
        });
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      MemberProfile memberProfile = MemberProfile.fromJson(json);
      return memberProfile;
    } else {
      throw Exception(
          'Failed to load ... status code:${response.statusCode}\n${response.body}');
    }
  }
  getMemberLogIn(String membershipNumber,BuildContext context) async {
    http.Response response = await http.get(
        Uri(
          scheme: 'https',
          host: 'beta-dtba.btla.net',
          path: 'api/member/profile',
          queryParameters: {
            'membership_number': '${membershipNumber}',//'A00014',
          },
        ),
        headers:{
          'Content-type': 'application/json',
          'instance-api-secrete': "k8wscw04kwwok4gcwsk488o4sog8o00gsgwsog0k",
          'instance-name': 'sibldtba459807',
        });
    print(response.statusCode);
    if (response.statusCode == 200) {
      memberId=membershipNumber;
      final json = jsonDecode(response.body);
      MemberProfile memberProfile = MemberProfile.fromJson(json);
      memberName=memberProfile.data!.memberName;
      //id=memberProfile.data!.;
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>HomeScreen()), (route) => false);
      //Navigator.of(context).push(MaterialPageRoute(builder: (_) => HomeScreen()));
      //return memberProfile;
    } else {
      Fluttertoast.showToast(
        msg: "Please Enter Valid Membership Number",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 3,
        backgroundColor: secondaryColor,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      // throw Exception(
      //     'Failed to load ... status code:${response.statusCode}\n${response.body}');
    }


  }

  Future getMemberReceiptList() async {
    List<DataList> receiptList=[];
    final response = await http.get(
        Uri(
          scheme: 'https',
          host: 'beta-dtba.btla.net',
          path: 'api/member/receipt/list',
          queryParameters: {
            'membership_number': '$memberId',
          },
        ),
        headers: {
          'Content-type': 'application/json',
          'instance-api-secrete': "k8wscw04kwwok4gcwsk488o4sog8o00gsgwsog0k",
          'instance-name': 'sibldtba459807',
        });
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      ReceiptListModel receiptListModel = ReceiptListModel.fromJson(json);
      receiptList=receiptListModel.data!;
      print(receiptList);
      // jsonDataGridSource = _JsonDataGridSource(receiptList);
      return receiptList;
    } else {
      throw Exception(
          'Failed to load ... status code:${response.statusCode}\n${response.body}');
    }
  }
  Future getFileList() async {
    List<Datum> fileList=[];
    final response = await http.get(
        Uri(
          scheme: 'https',
          host: 'beta-dtba.btla.net',
          path: 'api/member/profile/documents/4398',
          queryParameters: {
            'membership_number': '$memberId',
          },
        ),
        headers: {
          'Content-type': 'application/json',
          'instance-api-secrete': "k8wscw04kwwok4gcwsk488o4sog8o00gsgwsog0k",
          'instance-name': 'sibldtba459807',
        });
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      FileListModel receiptListModel = FileListModel.fromJson(json);
      fileList=receiptListModel.data!;
      print(fileList);
      // jsonDataGridSource = _JsonDataGridSource(receiptList);
      return fileList;
    } else {
      throw Exception(
          'Failed to load ... status code:${response.statusCode}\n${response.body}');
    }
  }

  /// for register api end point
  /// https://bppshops.excelitaiportfolio.com/api/register
  ///
  /// for login api end point
  /// https://bppshops.excelitaiportfolio.com/api/login
  ///
  /// check session api end point https://bppshops.excelitaiportfolio.com/api/user/profile/update
  ///
  ///
  ///
  ///



  ///
  ///
  /// user session checking methode
  ///
  Future<bool> isSession(String token)async{
    if(token=="null"){
      return false;
    }else{
      final response = await http.get(
        Uri.parse('https://bppshops.excelitaiportfolio.com/api/user/profile/update'),
        headers: {
          'Accept': 'application/json',
          'Authorization':
          "Bearer ${token}", //47|ZSoxBWu2Nar7x6B4c7xIqxr4fmKmrjGNMHtwZ1lI"
        },
      );
      if(response.statusCode==200){
        return true;
      }else{
        return false;
        // throw Exception(
        //     'status code:${response.statusCode}\n${response.body}');
      }
    }

  }


  ///
  ///
  /// User login request method
  ///
  ///

  logInRequest(BuildContext context, String memberId, String phoneNo) async {
    print(">>>>>>>>" + memberId + phoneNo + "<<<<<<<");

    final response = await http.post(
      Uri.parse('https://bppshops.excelitaiportfolio.com/api/login'),
      // headers: {
      //   'Content-Type': 'application/json',
      // },
      body: {
        "Member_id": "${memberId}",
        "phone": "${phoneNo}",
      },
    );
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 201) {
      final json = jsonDecode(response.body);
      LogedInSessionModel logedInSessionModel =
          LogedInSessionModel.fromJson(json);
      LocalStorageStore().saveOtpUserToken(token: logedInSessionModel.token);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => HomeScreen()));
      // Navigator.pushAndRemoveUntil(
      //     context,
      //     MaterialPageRoute(builder: (context) => HomeScreen()),
      //     (route) => false);
      //return logedInSessionModel;
    } else if (response.statusCode == 401) {
      Fluttertoast.showToast(
        msg: "Phone number is not registered",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 3,
        backgroundColor: secondaryColor,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      // Scaffold.of(context).showSnackBar(
      //     new SnackBar(content: new Text("Phone number is not registered")));
      //return LogedInSessionModel();
    } else {
      throw Exception(
          'Failed to load ... status code:${response.statusCode}\n${response.body}');
    }
  }
}
