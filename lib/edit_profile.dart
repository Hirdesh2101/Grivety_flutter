import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;

class EditProfile extends StatefulWidget {
  static const routeName = '/edit_profile';
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File _image;
  final _picker = ImagePicker();
  bool _isUploading = false;
  String url;
  TextEditingController _textEditingController = TextEditingController();
  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  Future getImage() async {
    final pickedFile = await _picker.getImage(
        source: ImageSource.gallery,
        imageQuality: 25,
        maxHeight: 400,
        maxWidth: 400);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        Fluttertoast.showToast(
            msg: "No Image Selected",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
      }
    });
  }

  var user = FirebaseAuth.instance.currentUser.uid;
  Future<void> _uploadFile(File img) async {
    try {
      setState(() {
        _isUploading = true;
      });
      if (img != null) {
        //   var temp = await img.length();
        //var result;
        /*print(temp);
      Directory tempDir = await getTemporaryDirectory();
      while (temp >= 15000) {
        result = await FlutterImageCompress.compressAndGetFile(
          img.absolute.path,
          tempDir.path,
          quality: 40,
          format: CompressFormat.jpeg
        );
        temp = result.lengthSync();
        print(img.lengthSync());
        img = result;
        print(img.lengthSync());
      }*/
        await firebase_storage.FirebaseStorage.instance
            .ref('profiles/$user')
            .putFile(img);
        String downloadURL = await firebase_storage.FirebaseStorage.instance
            .ref('profiles/$user')
            .getDownloadURL();
        url = downloadURL;
        if (downloadURL != null) {
          await FirebaseFirestore.instance
              .collection('Users')
              .doc(user)
              .update({"Image": downloadURL});
        }
        if (_textEditingController.text != '') {
          await FirebaseFirestore.instance
              .collection('Users')
              .doc(user)
              .update({'Description': _textEditingController.text});
        }
        Fluttertoast.showToast(
            msg: "Profile Updated Success. Please Close the tab",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
        print('aays');
        setState(() {
          _isUploading = false;
        });
      }
    } on firebase_core.FirebaseException catch (e) {
      print(e);
      Fluttertoast.showToast(
          msg: "Error.. Please Try again",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
    }
  }

  _updateDis() async {
    setState(() {
      _isUploading = true;
    });
    if (_textEditingController.text != '') {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(user)
          .update({'Description': _textEditingController.text});
    }
    Fluttertoast.showToast(
        msg: "Profile Updated Success. Please Close the tab",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        fontSize: 16.0);
    print('aays');
    setState(() {
      _isUploading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser.uid;
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Stack(
        children: [
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Users')
                  .doc(user)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Container(
                  margin: MediaQuery.of(context).padding,
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _image == null
                          ? (snapshot.data.data()['Image'] == 'Male' ||
                                  snapshot.data.data()['Image'] == 'Female')
                              ? snapshot.data.data()['Image'] == 'Male'
                                  ? CircleAvatar(
                                      radius: 85,
                                      backgroundImage:
                                          AssetImage("assests/male.jpg"))
                                  : CircleAvatar(
                                      radius: 85,
                                      backgroundImage:
                                          AssetImage("assests/female.jpg"))
                              : CircleAvatar(
                                  radius: 85,
                                  backgroundImage: NetworkImage(
                                    snapshot.data.data()['Image'],
                                  ),
                                )
                          : CircleAvatar(
                              radius: 85,
                              backgroundImage: FileImage(_image),
                            ),
                      FlatButton(
                        onPressed: _isUploading ? null : getImage,
                        child: Icon(
                          Icons.add_a_photo,
                          size: 35,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          enabled: _isUploading ? false : true,
                          decoration: InputDecoration(
                              hintText: "Enter your Discription",
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)))),
                          controller: _textEditingController,
                          maxLines: null,
                          minLines: null,
                          autocorrect: false,
                          textCapitalization: TextCapitalization.sentences,
                        ),
                      ),
                      RaisedButton(
                        child: Text('Update Profile'),
                        onPressed: _isUploading
                            ? null
                            : () {
                                _image != null
                                    ? _uploadFile(_image)
                                    : _updateDis();
                              },
                      ),
                      RaisedButton(
                        onPressed: _isUploading
                            ? null
                            : () {
                                Navigator.of(context).pop();
                              },
                        child: Text('Cancel'),
                      ),
                    ],
                  ),
                );
              }),
          if (_isUploading)
            Align(
              alignment: Alignment.center,
              child: Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }
}
