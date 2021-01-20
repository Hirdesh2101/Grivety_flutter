import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;

class NewsAdd extends StatefulWidget {
  @override
  _NewsAddState createState() => _NewsAddState();
}

class _NewsAddState extends State<NewsAdd> {
  TextEditingController _textEditingController = TextEditingController();

  TextEditingController _textEditingController2 = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    _textEditingController2.dispose();
    super.dispose();
  }

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

  void _uploadFile(File img, String t1, String t2) async {
    try {
      Key s = UniqueKey();
      String temp = s.toString();
      await firebase_storage.FirebaseStorage.instance
          .ref('news/$temp')
          .putFile(img);
      String downloadURL = await firebase_storage.FirebaseStorage.instance
          .ref('news/$temp')
          .getDownloadURL();
      url = downloadURL;
      if (downloadURL != null) {
        await FirebaseFirestore.instance
            .collection('News')
            .add({"Image": downloadURL, "Title": t1, "Data": t2});
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
              child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _image == null
                  ? Text('No image selected.')
                  : Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Image.file(
                        _image,
                        width: MediaQuery.of(context).size.width * 0.75,
                        height: MediaQuery.of(context).size.height * 0.20,
                      ),
                    ),
              FlatButton(
                onPressed: _isUploading ? null : getImage,
                child: Icon(
                  Icons.add_a_photo,
                  size: 35,
                ),
              ),
              if (_isUploading) Center(child: CircularProgressIndicator()),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  enabled: _isUploading ? false : true,
                  decoration: InputDecoration(
                      hintText: "Enter Title",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                  controller: _textEditingController,
                  maxLines: null,
                  minLines: null,
                  autocorrect: false,
                  textCapitalization: TextCapitalization.sentences,
                  //expands:true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  enabled: _isUploading ? false : true,
                  decoration: InputDecoration(
                      hintText: "Enter Data",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                  controller: _textEditingController2,
                  maxLines: null,
                  minLines: null,
                  autocorrect: false,
                  textCapitalization: TextCapitalization.sentences,
                  //expands:true,
                ),
              ),
              RaisedButton(
                onPressed: _isUploading
                    ? null
                    : () {
                        if (_image != null &&
                            _textEditingController.text != '' &&
                            _textEditingController2.text != '') {
                          setState(() {
                            _isUploading = true;
                          });
                          _uploadFile(_image, _textEditingController.text,
                              _textEditingController2.text);
                        } else {
                          Fluttertoast.showToast(
                              msg: "Fields can't be empty",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              fontSize: 16.0);
                        }
                      },
                child: Text('Add'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
