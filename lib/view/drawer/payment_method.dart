import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../component/app_style.dart';

class Payment_Method extends StatelessWidget {
  const Payment_Method({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back),onPressed: (){
          Navigator.of(context).pop();
          //  Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(_)=>HomeScreen()));
        }),
        title: Text("Payment_Method",style: TextStyle(color: Colors.white),),
        centerTitle: true,
        actions: [
          Icon(Icons.edit),
          SizedBox(
            width: 20,
          )
        ],
        backgroundColor: primaryColor,
        elevation: 0,
      ),body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Center(child: Text("Payment_Method",)),

    ),
    );
  }
}
