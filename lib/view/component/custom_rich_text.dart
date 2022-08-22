import 'package:flutter/material.dart';

class CustomRichText extends StatelessWidget {
  CustomRichText({Key? key,this.title,this.data,this.color}) : super(key: key);
  String? title;
  String? data;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      focusColor:color,
      tileColor: color,
      leading: Text(title!),
      trailing: Text(data!),
    );
  }

}
