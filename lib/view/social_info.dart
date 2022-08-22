import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'component/app_style.dart';

class SocialInfoPage extends StatefulWidget {
  @override
  _SocialInfoPageState createState() => _SocialInfoPageState();
}

class _SocialInfoPageState extends State<SocialInfoPage> {
  bool istextfeildShow = false;
  TextEditingController fblinkcontroller = TextEditingController();
  TextEditingController twitterlinkcontroller = TextEditingController();
  TextEditingController linkIDlinkcontroller = TextEditingController();

  int lenght = 0;

  bool isFbLink = false;
  bool isTwitter = false;
  bool isLinkId = false;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(padding: EdgeInsets.all(10),
        child: Column(
          
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // isFbLink == true
                //     ?
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildSocialButton(
                        icon: FontAwesomeIcons.facebookSquare,
                        color: Color(0xFF0075FC),
                        onClicked: () {
                          if (fblinkcontroller.text.isEmpty)
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: const Text('Please Enter Facebook Link'),
                              duration: const Duration(seconds: 1),
                            ));

                          share(SocialMedia.facebook);
                        }),
                    isFbLink == true
                        ? Expanded(
                            flex: 3,
                            child: TextField(
                              onChanged: (value) {
                                // setState(() {

                                // });
                              },
                              controller: fblinkcontroller,
                              decoration:
                                  InputDecoration(hintText: 'Enter FB Link'),
                            ),
                          )
                        : Text(""),
                    SizedBox(
                      height: 35,
                      width: 100,
                      child: NeumorphicButton(
                        //  margin: EdgeInsets.only(top: 12),
                        onPressed: () {
                          setState(() {
                            isFbLink = !isFbLink;
                            lenght = fblinkcontroller.text.length;
                            // istextfeildShow = !istextfeildShow;
                          });
                        },
                        style: NeumorphicStyle(
                          color: secondaryColor,
                          shape: NeumorphicShape.flat,
                          boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(8)),
                          //border: NeumorphicBorder()
                        ),
                        padding: const EdgeInsets.all(10.0),
                        child: Center(
                          child: Text(
                            fblinkcontroller.text.isNotEmpty
                                ? isFbLink == false
                                    ? 'Edit'
                                    : 'submit'
                                : isFbLink == false
                                    ? 'Add'
                                    : 'submit',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildSocialButton(
                      icon: FontAwesomeIcons.twitter,
                      color: Color(0xFF1da1f2),
                      onClicked: () {
                        if (fblinkcontroller.text.isEmpty)
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: const Text('Please Enter Twitter  Link'),
                            duration: const Duration(seconds: 1),
                          ));
                        share(SocialMedia.twitter);
                      },
                    ),
                    isTwitter == true
                        ? Expanded(
                            flex: 3,
                            child: TextField(
                              onChanged: (value) {
                                // setState(() {

                                // });
                              },
                              controller: fblinkcontroller,
                              decoration: InputDecoration(
                                  hintText: 'Enter Twitter Link'),
                            ),
                          )
                        : Text(""),
                    SizedBox(
                        height: 35,
                        width: 100,
                        child: NeumorphicButton(
                          //  margin: EdgeInsets.only(top: 12),
                          onPressed: () {
                            setState(() {
                              isTwitter = !isTwitter;
                              lenght = twitterlinkcontroller.text.length;
                              // istextfeildShow = !istextfeildShow;
                            });
                          },
                          style: NeumorphicStyle(
                            color: secondaryColor,
                            shape: NeumorphicShape.flat,
                            boxShape: NeumorphicBoxShape.roundRect(
                                BorderRadius.circular(8)),
                            //border: NeumorphicBorder()
                          ),
                          padding: const EdgeInsets.all(10.0),
                          child: Center(
                            child: Text(
                              twitterlinkcontroller.text.isNotEmpty
                                  ? isTwitter == false
                                      ? 'Edit'
                                      : 'submit'
                                  : isTwitter == false
                                      ? 'Add'
                                      : 'submit',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildSocialButton(
                      icon: FontAwesomeIcons.linkedin,
                      color: Color(0xFF0072b1),
                      onClicked: () {
                        if (fblinkcontroller.text.isEmpty)
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: const Text('Please Enter Linkedin Link'),
                            duration: const Duration(seconds: 1),
                          ));
                        share(SocialMedia.linkedln);
                      },
                    ),
                    isLinkId == true
                        ? Expanded(
                            flex: 3,
                            child: TextField(
                              onChanged: (value) {
                                // setState(() {

                                // });
                              },
                              controller: fblinkcontroller,
                              decoration: InputDecoration(
                                  hintText: 'Enter  Linkedin Link'),
                            ),
                          )
                        : Text(""),
                    SizedBox(
                        height: 35,
                        width: 100,
                        child: NeumorphicButton(
                          //  margin: EdgeInsets.only(top: 12),
                          onPressed: () {
                            setState(() {
                              isLinkId = !isLinkId;
                              lenght = linkIDlinkcontroller.text.length;
                              // istextfeildShow = !istextfeildShow;
                            });
                          },
                          style: NeumorphicStyle(
                            color: secondaryColor,
                            shape: NeumorphicShape.flat,
                            boxShape: NeumorphicBoxShape.roundRect(
                                BorderRadius.circular(8)),
                            //border: NeumorphicBorder()
                          ),
                          padding: const EdgeInsets.all(10.0),
                          child: Center(
                            child: Text(
                              linkIDlinkcontroller.text.isNotEmpty
                                  ? isLinkId == false
                                      ? 'Edit'
                                      : 'submit'
                                  : isLinkId == false
                                      ? 'Add'
                                      : 'submit',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ))
                  ],
                )
              ],
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future share(SocialMedia platform) async {
    final urls = {
      SocialMedia.facebook: (fblinkcontroller.text),
      SocialMedia.twitter: (twitterlinkcontroller.text),
      SocialMedia.linkedln: (linkIDlinkcontroller.text)
    };
    final url = urls[platform]!;
    await launchUrl(Uri.parse(url));
  }
}

enum SocialMedia { facebook, twitter, linkedln }

Widget buildSocialButton(
        {required IconData icon,
        Color? color,
        required Function() onClicked}) =>
    InkWell(
      child: Container(
        width: 60,
        height: 60,
        child: Center(child: FaIcon(icon, color: color, size: 40)),
      ),
      onTap: onClicked,
    );
