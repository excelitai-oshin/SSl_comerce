import 'dart:async';

import 'package:flutter/material.dart';

import 'component/app_style.dart';
import 'log_in_screen.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();
    Timer(Duration(seconds: 5),(){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(_)=>LogInScreen()));
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      body: Center(
        child: Stack(
        //  mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/icon/dtba-logo.png",height: 120,),
            Positioned(child:SizedBox(
              height: 120,
              width: 120,
              child: CircularProgressIndicator(
               strokeWidth:10,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
              ),
            ))


          ],

        ),
      ),
    );
  }
}
