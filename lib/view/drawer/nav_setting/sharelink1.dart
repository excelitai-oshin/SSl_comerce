import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';
class ShareLink extends StatefulWidget {
  const ShareLink({Key? key}) : super(key: key);

  @override
  State<ShareLink> createState() => _ShareLinkState();
}

class _ShareLinkState extends State<ShareLink> {
  File? file;
  List<String> images = [];
  ImagePicker image = ImagePicker();
  final TextEditingController emailController = new TextEditingController();

  getImage() async {
    var img = await image.pickImage(source: ImageSource.gallery);
    setState(() {
      file = File(img!.path);
      images.add(img.path);
    });
  }
  void share(BuildContext context) async {
    if (file != null) {
      await Share.shareFiles(
        images,
        text: emailController.text,
      );
    } else {
      await Share.share(
        emailController.text,
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text(
          'ShareLink',
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              file == null
                  ? IconButton(
                onPressed: () {
                  getImage();
                },
                icon: Icon(
                  Icons.share,
                ),
              )
                  : Image.file(
                file!,
                fit: BoxFit.fill,
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Text /Link /Image',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              MaterialButton(
                onPressed: () {
                  share(context);
                },
                color: Color(0xFF007786),
                child: Text(
                  'Share ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}

