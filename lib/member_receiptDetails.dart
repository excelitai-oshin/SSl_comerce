import 'dart:io';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:ssl_comerce/service/profile_service.dart';
import 'package:ssl_comerce/view/about_page.dart';
import 'package:ssl_comerce/view/component/app_style.dart';
import 'package:ssl_comerce/view/detail_receipt_page.dart';
import 'package:ssl_comerce/view/drawer/nav_drawer.dart';
import 'package:ssl_comerce/view/notification.dart';
import 'package:ssl_comerce/view/profile_Screen.dart';
import '../service/local_storage.dart';
import 'model/member_profile_model.dart';

class receipt_details extends StatefulWidget {
  const receipt_details({Key? key}) : super(key: key);

  @override
  State<receipt_details> createState() => _receipt_detailsState();
}

class _receipt_detailsState extends State<receipt_details> {
  int currentIndex = -1;
  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor, //Colors.purple,
        centerTitle: true,
        title: Text(" Receipt Details"),
        // actions: [
        //   IconButton(
        //       onPressed: () async {
        //         if (Platform.isAndroid) {
        //           await LocalStorageStore().userDeleteToken();
        //           SystemNavigator.pop();
        //         } else if (Platform.isIOS) {
        //           await LocalStorageStore().userDeleteToken();
        //           exit(0);
        //         }
        //       },
        //       icon: Icon(Icons.exit_to_app))
        // ],
      ),
      drawer: NavigationDrawer(),
      body: FutureBuilder(
        future: ProfileService().getMember_Profile(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Member_Profile payment = snapshot.data as Member_Profile;
            // print(payment.data!.memberName.toString() + "hjguyg");
            return Padding(
              padding: const EdgeInsets.only(top: 30,left: 40),
              child:GestureDetector(
                onTap: (){
                  //Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(_)=>ReciptlistScreen()));
                },
                child: Container(
                  color: Color(0xFF007786),
                  height:150,
                  width: MediaQuery.of(context).size.width*0.8,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          "MembershipNumber: ${payment.data!.membershipNumber}",
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          "Name: ${payment.data!.memberName}",
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          "Address: ${payment.data!.residentialAddress}",
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          "MobileNumber: ${payment.data!.mobileNumber}",
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          "Gender: ${payment.data!.gender}",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],

                      // child: ListTile(
                      //   title: Text(
                      //     "${payment.data!.memberName}",
                      //     style: TextStyle(color: Colors.white),
                      //   ),
                      // ),
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: currentIndex == -1 ? primaryColor : secondaryColor,
        onPressed: () {
          setState(() {
            currentIndex = -1;
          });
        },
        child: const Icon(FontAwesomeIcons.home),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ...MainMenuModel.list.map(
                  (MainMenuModel data) {
                return data.isBlank
                    ? const SizedBox(
                  width: 10,
                )
                    : InkWell(
                  onTap: () {
                    setState(() {
                      currentIndex = data.index;
                      if (currentIndex == 0) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => receipt_details()));
                      }
                      if (currentIndex == 1) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Notification_Screen()));
                      }
                      if (currentIndex == 2) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfilePage()));
                      }
                      if (currentIndex == 3) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AboutPage()));
                      }
                    });
                    // ignore: avoid_print
                    print(data.index.toString());
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        //SizedBox(height: 10,),
                        Icon(
                          data.icon,
                          color: currentIndex == data.index
                              ? primaryColor
                              : secondaryColor,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          data.label!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                              color: currentIndex == data.index
                                  ? primaryColor
                                  : secondaryColor),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  customNavidation(
      {BuildContext? context,
        String? receiptId,
        String? date,
        String? memberId,
        String? memberName,
        String? month,
        String? startDate,
        String? finishDate,
        String? amount,
        String? action}) {
    Navigator.push(
        context!,
        MaterialPageRoute(
            builder: (context) => ReceiptDetailsPage(
              receiptId: receiptId,
              date: date,
              memberId: memberId,
              memberName: memberName,
              month: month,
              startDate: startDate,
              finishDate: finishDate,
              amount: amount,
              action: action,
            )));
  }

  Color _getDataRowColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Color(0xfffcf8e3);
  }

  _getBody() {
    switch (currentIndex) {
      case 0:
        return receipt_details();
      case 1:
        return Container();
      case 2:
        return ProfilePage();
      case 3:
        return AboutPage();
      default:
        return Container();
    }
  }
}

class MainMenuModel {
  late final int index;
  late final IconData? icon;
  late final String? label;
  late final bool isBlank;
  MainMenuModel(
      {required this.index, this.label, this.icon, this.isBlank = false});

  static List<MainMenuModel> list = [
    MainMenuModel(
      index: 0,
      label: 'Home',
      icon: FontAwesomeIcons.home,
    ),
    MainMenuModel(
      index: 1,
      label: 'Notification',
      icon: FontAwesomeIcons.bell,
    ),
    MainMenuModel(
      index: -1,
      isBlank: true,
    ),
    MainMenuModel(
      index: 2,
      label: 'Profile',
      icon: FontAwesomeIcons.userAlt,
    ),
    MainMenuModel(
      index: 3,
      label: 'About',
      icon: FontAwesomeIcons.indent,
    ),
  ];
}
