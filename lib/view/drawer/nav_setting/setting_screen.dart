import 'dart:ffi';


import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ssl_comerce/view/drawer/nav_setting/server_url.dart';
import '../../component/app_style.dart';



import 'bank_accountinfo.dart';
import 'bkash.dart';
import 'cc_info.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
// static final List<String> items =<String>[
//   'Server url',
//   'Server url1',
//   'Server url2',
// ];
// String value =items.first;
  String dropdownvalue = 'Server Url 1';

  var items = [
    'Server Url 1',
    'Server Url 2',
    'Server Url 3',

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back),onPressed: (){
          Navigator.of(context).pop();
          //  Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(_)=>HomeScreen()));
        }),
        title: Text("Setting",style: TextStyle(color: Colors.white),),
        centerTitle: true,
        // actions: [
        //   Icon(Icons.edit),
        //   SizedBox(
        //     width: 20,
        //   )
        // ],
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: ListView(
          children: [
            Text(
              "Settings",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Icon(
                  Icons.settings,
                  color: Color(0xFF007786),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Financial settings",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Divider(
              height: 15,
              thickness: 2,
            ),
            SizedBox(
              height: 10,
            ),
            buildAccountOptionRow(context, "Bank Account Info"),
            buildAccountOptionRow(context, "CC info"),
            buildAccountOptionRow(context, "Bkash info"),

            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Icon(
                  Icons.settings,
                  color: Color(0xFF007786),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Server settings",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Divider(
              height: 15,
              thickness: 2,
            ),
            SizedBox(
              height: 10,
            ),
Column(
  children: [
    DropdownButton(
      isExpanded: true,

      // Initial Value
      value: dropdownvalue,

      // Down Arrow Icon
      icon: const Icon(Icons.keyboard_arrow_down),

      // Array list of items
      items: items.map((String items) {
        return DropdownMenuItem(
          value: items,
          child: Text(items),
        );
      }).toList(),
      // After selecting the desired option,it will
      // change button value to selected value
      onChanged: (String? newValue) {
        setState(() {
          dropdownvalue = newValue!;
        });
      },
    ),
  ],
)
            
            // ExpansionTile(
            //     title: Text("serhj",style: TextStyle(),
            //     ),
            //   children: [
            //     ListTile(
            //       title:  Text("jhmjm"),
            //       onTap: (){
            //
            //       },
            //     ),
            //     ListTile(
            //       title:  Text("jhmjm"),
            //       onTap: (){
            //
            //       },
            //     ),
            //     ListTile(
            //       title:  Text("jhmjm"),
            //       onTap: (){
            //
            //       },
            //     )
            //
            //
            //
            //   ],
            //   onExpansionChanged: (isExpanded){
            //       print("Expanded: $isExpanded");
            //   },
            // )
            //
            //   DropdownButton<String>(
            //     hint: Text("Select Name"),
            //     dropdownColor: Colors.grey,
            //     value: value,
            // isExpanded: true,
            // elevation: 5,
            //     icon: Icon(Icons.arrow_drop_down),
            //     onChanged: (value) {
            //       setState(() {
            //         this.value =value!;
            //
            //       });
            //     },
            //     items: items.map((item) {
            //       return DropdownMenuItem<String>(
            //         value: item,
            //         child: Text(
            //           item,style: TextStyle(fontWeight: FontWeight.bold,
            //         fontSize: 20),),
            //
            //       );
            //     }).toList(),
            //   ),


         //    buildNotificationOptionRow(context, "Server Url"),

]
      )
    ), );
  }




  GestureDetector buildAccountOptionRow(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {

        if(title=="Bank Account Info"){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>BankInfo()));
        }
        if(title=="CC info"){

          Navigator.push(context, MaterialPageRoute(builder: (context)=>CC_Info()));
        }
        if(title=="Bkash info"){

          Navigator.push(context, MaterialPageRoute(builder: (context)=>BkashInfo()));
        }


      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
  GestureDetector buildNotificationOptionRow(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {

        if(title=="Server Url"){

          Navigator.push(context, MaterialPageRoute(builder: (context)=>Server_Url()));
        }

      },
      // child: Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //   children: [
      //     Text(
      //       title,
      //       style: TextStyle(
      //         fontSize: 18,
      //         fontWeight: FontWeight.w500,
      //         color: Colors.grey[600],
      //       ),
      //     ),
          // Icon(
          //   Icons.arrow_forward_ios,
          //   color: Colors.grey,
          // ),


        //],
     // ),
    );
  }

}