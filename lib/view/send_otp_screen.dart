import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ssl_comerce/view/payments_receipt_list_screen.dart';
import '../service/local_storage.dart';
import 'component/app_style.dart';

class SendOtpScreen extends StatefulWidget {
  SendOtpScreen({Key? key, required this.mobile, required this.token})
      : super(key: key);

  String mobile;
  String token;

  @override
  _SendOtpScreenState createState() => _SendOtpScreenState();
}

class _SendOtpScreenState extends State<SendOtpScreen> {
  final String postUrl="https://bppshops.com/api/loginWithOtp";
  TextEditingController numberController =TextEditingController();

  void saveOtpUserToken({String? token}) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString('token', token!);
    print(_prefs.getString("token"));
  }




  Future<Response> getPost() async {
    var res = await post(Uri.parse(postUrl), body: {
      'mobile': widget.mobile.toString(),
      'otp': numberController.text.toString(),

    });


    if(res.statusCode==201){
      return res;
    }
    else{
      throw "Error :${res.statusCode}";
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        leading: SizedBox(),
        title: Text(
          "OTP",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          Text(
            "We've sent a 4-digit one time PIN in your phone",
            style: TextStyle(
              color: Colors.black,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "${widget.mobile}",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Container(
            margin: EdgeInsets.only(left: 40, right: 15),
            child: Row(
              children: [
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: numberController,
                    minLines: 1,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Please enter 4-digit one time pin',
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15, top: 20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: primaryColor,//Colors.purple,
                onPrimary: Color(0xffE37D4E),
                elevation: 3,
                minimumSize: Size(100, 40),
              ),
              onPressed: () async {
                LocalStorageStore().saveOtpUserToken(token: "logedIn");
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PaymentReceiptListScreen()),
                        (route) => false);
                //Response response= await getPost();

                // if (response.statusCode == 201) {
                //   final json=jsonDecode(response.body);
                //   print(json["token"]);
                //   saveOtpUserToken(
                //     token: json["token"],
                //   );
                //   print("Okey..........");
                //
                //   Navigator.pushAndRemoveUntil(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) => HomeScreen()),
                //           (route) => false);
                // }
              },
              child: Center(
                child: Container(
                //  margin: EdgeInsets.symmetric(horizontal: 130),
                  child: Text(
                    "Enter",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "This site is protected by reCAPTCHA and the Google",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              SizedBox(
                width: 2,
              ),
              Text(
                "Privacy",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Policy",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 12,
                ),
              ),
              SizedBox(
                width: 2,
              ),
              Text(
                "and",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              SizedBox(
                width: 2,
              ),
              Text(
                "Terms of Service",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 12,
                ),
              ),
              SizedBox(
                width: 2,
              ),
              Text(
                "apply",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

