import 'package:flutter/material.dart';
import 'package:open_whatsapp/open_whatsapp.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var mobileNo ="0556455899";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(

        padding: const EdgeInsets.all(18.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                color: Colors.green,
                  shape: StadiumBorder(),
                  onPressed: (){
                  FlutterOpenWhatsapp.sendSingleMessage(mobileNo, 'Hi How Are You');
                  },
              child: Text("Whatsapp"),),
              MaterialButton(
                color: Colors.blue,
                shape: StadiumBorder(),
                onPressed: (){},
                child: Text("Facebook"),)
            ],
          ),
        ),
      ),
    );
  }
}

