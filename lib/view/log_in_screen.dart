
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:mac_address/mac_address.dart';
import 'package:ssl_comerce/main.dart';
import '../service/db_service.dart';
import 'component/app_style.dart';
import 'dart:developer' as developer;

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);
  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  TextEditingController numberController = TextEditingController();
  TextEditingController memberIdController = TextEditingController();
  final GlobalKey<FormState> formkey= GlobalKey<FormState>();

  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();
    //initPlatformState();
    //getMac();
    //print(GetMacAddress.macAddress);
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }
  // getMac()async{
  //   final mac=await GetMacAddress.macAddress;
  //   print(mac+"mac Address");
  // }
  // Future<void> initPlatformState() async {
  //   String? platformVersion;
  //   try {
  //     platformVersion = await GetMac.macAddress;
  //   } on PlatformException {
  //     platformVersion = 'Failed to get Device MAC Address.';
  //   }
  //   print("MAC-: " + platformVersion);
  //   if (!mounted) return;
  //   setState(() {
  //     platformID = platformVersion!;
  //   });
  // }


  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
      print("${_connectionStatus}");
      if(_connectionStatus.toString()=="ConnectivityResult.none"){
        isInternet=false;
        Fluttertoast.showToast(
          msg: "Please Check Your Internet Connection",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.orangeAccent,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }else{
        isInternet=true;
        // Fluttertoast.showToast(
        //   msg: "Internet Connected",
        //   toastLength: Toast.LENGTH_LONG,
        //   gravity: ToastGravity.TOP,
        //   timeInSecForIosWeb: 3,
        //   backgroundColor: Colors.orangeAccent,
        //   textColor: Colors.white,
        //   fontSize: 16.0,
        // );
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Stack(
                children: [
                  Image.asset("assets/icon/dtba-logo.png",height: 120,),
                  // Positioned(child:SizedBox(
                  //   height: 120,
                  //   width: 120,
                  //   child: CircularProgressIndicator(
                  //     strokeWidth:10,
                  //     valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
                  //   ),
                  // )
                  // )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                "Welcome to DTBA",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              child:
              TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    filled: true,
                    hintStyle: TextStyle(color: Colors.grey[800]),
                    label: Text("Member ID"),
                    //hintText: "En",
                    fillColor: Colors.white70),
                validator: (value){
                  if(value!.isEmpty ||RegExp(r'ˆ[0-9]+$').hasMatch(value)||value.length<4){
                    return "Enter Correct MemberId";
                  }else{
                    return  null;
                  }
                },
                keyboardType: TextInputType.text,
                controller: memberIdController,
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              child:
              TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),

                    filled: true,
                    hintStyle: TextStyle(color: Colors.grey[800]),
                    //hintText: "Enter your phone number",
                    label: Text("Phone Number"),
                    fillColor: Colors.white70),
                validator: (value){
                  // if(value!.isEmpty ||RegExp(r'ˆ[0-9]+$').hasMatch(value)||value.length<11){
                  //   return "Enter correct number";
                  // }else{
                  //   return  null;
                  // }
                },
                keyboardType: TextInputType.number,
                controller: numberController,
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: primaryColor,//Colors.purple,
                  onPrimary: primaryColor,//Color(0xffE37D4E),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                onPressed: () async{
                  if(formkey.currentState!.validate()){
                    if(isInternet==true){
                      await DBService().getMemberLogIn(memberIdController.text,context);
                    }else{
                      Fluttertoast.showToast(
                        msg: "Please Check Your Internet Connection",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.SNACKBAR,
                        timeInSecForIosWeb: 3,
                        backgroundColor: Colors.orangeAccent,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    }
                  }
                },
                child: Container(
                  //margin: EdgeInsets.symmetric(horizontal: 100),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "LOGIN",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
