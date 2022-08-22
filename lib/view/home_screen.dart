import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:developer' as developer;
import 'package:provider/provider.dart';
import 'package:ssl_comerce/main.dart';
import 'package:ssl_comerce/view/about_page.dart';
import 'package:ssl_comerce/view/log_in_screen.dart';
import 'package:ssl_comerce/view/notification.dart';
import 'package:ssl_comerce/view/profile_Screen.dart';
import '../member_receiptDetails.dart';
import '../provider/internet_connectivity_status.dart';
import '../provider/theme_provider.dart';

import 'package:screenshot/screenshot.dart';
import 'package:social_share/social_share.dart';

import '../service/local_storage.dart';
import 'component/app_style.dart';
import 'drawer/nav_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ThemeProvider themeProvider = ThemeProvider();

  void getCurrentTheme() async {
    themeProvider.darkTheme = await themeProvider.preference.getTheme();
  }

  // @override
  // void initState() {
  //   getCurrentTheme();
  //   super.initState();
  // }

  int currentIndex = -1;
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  @override
  void initState() {
    getCurrentTheme();
    super.initState();
    //initPlatformState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose(){
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
    final internetConnectivityStatus =
        Provider.of<InternetConnectivityStatus>(context, listen: false);
    setState(() {
      _connectionStatus = result;
      print("${_connectionStatus}");
      if (_connectionStatus.toString() == "ConnectivityResult.none") {
        //isInternet=false;
        Fluttertoast.showToast(
          msg: "Please Check Your Internet Connection",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.orangeAccent,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        internetConnectivityStatus.setStatus(false);
      } else {
        internetConnectivityStatus.setStatus(true);
        // isInternet=true;
        // setState(() {
        // });
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

  bool switchValue = false;
  //String _platformVersion = 'Unknown';

  // Future<void> initPlatformState() async {
  //   String? platformVersion;
  //
  //   if (!mounted) return;
  //
  //   setState(() {
  //     _platformVersion = platformVersion!;
  //   });
  // }

  ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      //tileColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text("Home Page"),
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
      ),
      drawer: NavigationDrawer(),
      body: Screenshot(
        controller: screenshotController,
        child: Container(
          //color: Colors.white,
          alignment: Alignment.center,
          child: Column(
            children: [
              Text(
                platformID,
                style: TextStyle(color: secondaryColor),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[

                  IconButton(
                    onPressed: () async {
                      SocialShare.shareTwitter(
                        "This is Social Share twitter example",
                        hashtags: ["hello", "world", "foo", "bar"],
                        url: "https://google.com/#/hello",
                        trailingText: "\nhello",
                      ).then((data) {
                        print(data);
                      });
                    },
                    icon: Icon(
                      FontAwesomeIcons.facebook,
                      color: secondaryColor,
                    ), //Text("Share on twitter"),
                  ),
                  IconButton(
                    onPressed: () async {
                      SocialShare.shareTwitter(
                        "This is Social Share twitter example",
                        hashtags: ["hello", "world", "foo", "bar"],
                        url: "https://google.com/#/hello",
                        trailingText: "\nhello",
                      ).then((data) {
                        print(data);
                      });
                    },
                    icon: Icon(
                      FontAwesomeIcons.twitter,
                      color: secondaryColor,
                    ), //Text("Share on twitter"),
                  ),
                  IconButton(
                    onPressed: () async {
                      SocialShare.shareSms(
                        "This is Social Share Sms example",
                        url: "\nhttps://google.com/",
                        trailingText: "\nhello",
                      ).then((data) {
                        print(data);
                      });
                    },
                    icon: Icon(
                      FontAwesomeIcons.sms,
                      color: secondaryColor,
                    ), //Text("Share on Sms"),
                  ),
                  IconButton(
                    onPressed: () async {
                      await screenshotController.capture().then((image) async {
                        SocialShare.shareOptions("Hello world").then((data) {
                          print(data);
                        });
                      });
                    },
                    icon: Icon(
                      FontAwesomeIcons.share,
                      color: secondaryColor,
                    ), //Text("Share Options"),
                  ),
                  IconButton(
                    onPressed: () async {
                      SocialShare.shareWhatsapp(
                        "Hello World \n https://google.com",
                      ).then((data) {
                        print(data);
                      });
                    },
                    icon: Icon(
                      FontAwesomeIcons.whatsapp,
                      color: secondaryColor,
                    ), //Text("Share on Whatsapp"),
                  ),
                  IconButton(
                    onPressed: () async {
                      SocialShare.shareTelegram(
                        "Hello World \n https://google.com",
                      ).then((data) {
                        print(data);
                      });
                    },
                    icon: Icon(
                      FontAwesomeIcons.telegram,
                      color: secondaryColor,
                    ), //Text("Share on Telegram"),
                  ),
                  // RaisedButton(
                  //   onPressed: () async {
                  //     SocialShare.checkInstalledAppsForShare().then((data) {
                  //       print(data.toString());
                  //     });
                  //   },
                  //   child: Text("Get all Apps"),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
      // Container(
      //   height: double.infinity,
      //   width: double.infinity,
      //   child: Center(child: Text("Welcome ${memberName}")),
      // ),
      // body: FutureBuilder(
      //   future: DBService().getMemberProfile(),
      //   builder: (context, snapshot) {
      //     if (snapshot.hasData) {
      //       return Padding(
      //         padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 8),
      //         child: ListView.builder(
      //           itemCount: 20,
      //           itemBuilder: (context, index) {
      //             MemberProfile memberProfile = snapshot.data as MemberProfile;
      //             return GestureDetector(
      //               onTap: (){
      //                 Navigator.push(context, MaterialPageRoute(builder: (_)=>ReceiptListOfAMemberScreen()));
      //               },
      //               child: Container(
      //                 height: 120,
      //                 decoration: BoxDecoration(
      //                     color: tileColor,
      //                     border: Border.all(color: Colors.white)
      //                 ),
      //                 child: ListTile(
      //                   leading: Image.network("https://beta-dtba.btla.net/photo/${memberProfile.data!.membershipNumber}"),
      //                   title: Text("${memberProfile.data!.memberName}"),
      //                   subtitle: Column(
      //                     crossAxisAlignment: CrossAxisAlignment.start,
      //                     children: [
      //                       Text("Membership Number : "+"${memberProfile.data!.membershipNumber}"),
      //                       Text("Mobile Number : "+"${memberProfile.data!.mobileNumber}"),
      //                       Text("Residential Address : "+"${memberProfile.data!.residentialAddress}"),
      //                     ],
      //                   ),
      //                 ),
      //               ),
      //             );
      //           },
      //         ),
      //       );
      //     } else {
      //       return Center(child: CircularProgressIndicator());
      //     }
      //   },
      // ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: currentIndex == -1 ? primaryColor : secondaryColor,
      //   onPressed: () {
      //     setState(() {
      //       currentIndex = -1;
      //     });
      //   },
      //   child: const Icon(FontAwesomeIcons.home),
      // ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
    //       );
    //     }
    //   ),
    // );
  }
}
