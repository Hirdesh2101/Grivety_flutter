import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;

class AddImage extends StatefulWidget {
  static const routeName = '/addpicture';
  @override
  _AddImageState createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  File _image;
  final picker = ImagePicker();
  String url;

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        Fluttertoast.showToast(
            msg: "Please Select Gender",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
      }
    });
  }
  var user = FirebaseAuth.instance.currentUser.uid;
  /*Future<void> _uploadFile(File img) async {
  try {
    await firebase_storage.FirebaseStorage.instance
        .ref('profiles/$user.jpg')
        .putFile(img);
    String downloadURL = await firebase_storage.FirebaseStorage.instance
      .ref('profiles/$user.jpg')
      .getDownloadURL();    
      url = downloadURL;
  } on firebase_core.FirebaseException catch (e) {
    // e.g, e.code == 'canceled'
  }
}*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: MediaQuery.of(context).padding,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image == null
                ? Text('No image selected.')
                : CircleAvatar(
                    radius: 85,
                    backgroundImage: FileImage(_image),
                  ),
            FlatButton(
              onPressed: getImage,
              child: Icon(
                Icons.add_a_photo,
                size: 35,
              ),
            ),
            _image != null
                ? FlatButton(
                    child: Text('Add'),
                    onPressed: () {
                       // _uploadFile(_image);
                     // if(url!=null) print(url);
                    },
                  )
                : Container(),
            FlatButton(
              child: Text('Skip'),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        ),
      ),
    );
  }
}
