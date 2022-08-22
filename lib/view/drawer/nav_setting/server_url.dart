import 'package:flutter/material.dart';

import '../../component/app_style.dart';

class Server_Url extends StatefulWidget {
  const Server_Url({Key? key}) : super(key: key);

  @override
  State<Server_Url> createState() => _Server_UrlState();
}

class _Server_UrlState extends State<Server_Url> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:secondaryColor,
        elevation: 1,
        title: Text("Server Url"),centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}

