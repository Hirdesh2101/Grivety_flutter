import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;

class SliderAdd extends StatefulWidget {
  @override
  _SliderAddState createState() => _SliderAddState();
}

class _SliderAddState extends State<SliderAdd> {
  File _image;

  final picker = ImagePicker();

  bool _isUploading = false;

  String url;

  Future getImage() async {
    final pickedFile =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 25);

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

  Future<void> _uploadFile(File img) async {
    try {
      setState(() {
        _isUploading = true;
      });
      Key s = UniqueKey();
      String temp = s.toString();
      await firebase_storage.FirebaseStorage.instance
          .ref('slider/$temp')
          .putFile(img);
      String downloadURL = await firebase_storage.FirebaseStorage.instance
          .ref('slider/$temp')
          .getDownloadURL();
      url = downloadURL;
      if (downloadURL != null) {
        await FirebaseFirestore.instance
            .collection('Slider')
            .add({"Image": downloadURL});
      }
      Fluttertoast.showToast(
          msg: "Successfully Added",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
      setState(() {
        _isUploading = false;
      });
    } on firebase_core.FirebaseException catch (e) {
      print(e);
      Fluttertoast.showToast(
          msg: "Error.. Please Try again",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: MediaQuery.of(context).padding,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
              child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image == null
                ? Text('No image selected.')
                : Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Image.file(_image),
                  ),
            FlatButton(
              onPressed: _isUploading ? null : getImage,
              child: Icon(
                Icons.add_a_photo,
                size: 35,
              ),
            ),
            _image != null
                ? FlatButton(
                    child: Text('Add to slider'),
                    onPressed: _isUploading
                        ? null
                        : () {
                            _uploadFile(_image);
                          },
                  )
                : Container(),
            _isUploading
                ? Center(child: CircularProgressIndicator())
                : Container(),
          ],
        ),
      ),
    );
  }
}
