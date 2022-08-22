
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ssl_comerce/view/home_screen.dart';
import 'package:ssl_comerce/view/log_in_screen.dart';
import 'package:ssl_comerce/view/profile_Screen.dart';

import '../main.dart';
import '../member_receiptDetails.dart';
import '../service/local_storage.dart';
import 'component/app_style.dart';
import 'notification.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  int currentIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
              //  Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(_)=>HomeScreen()));
            }),
        title: Text(
          "About",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      actionsAlignment: MainAxisAlignment.spaceBetween,
                      title: Center(
                          child: SizedBox(
                              height: 100,
                              width: 100,
                              child: Image.asset("assets/logout.png"))),
                      content: Text("Are you sure you want to Log Out"),
                      actions: [
                        TextButton(
                          child: Text("No"),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        TextButton(
                          child: Text(
                            "Yes",
                            style: TextStyle(color: Colors.red),
                          ),
                          onPressed: () async {
                            await LocalStorageStore().userDeleteToken();
                            memberId = null;
                            receiptNumber = null;
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LogInScreen()),
                                (route) => false);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              icon: Icon(Icons.exit_to_app))
        ],
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
            child: Text(
          "About",
        )),
      ),
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
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => HomeScreen()),
                                  (route) => false);
                              //Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
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
}
