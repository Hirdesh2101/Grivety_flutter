import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grivety/quest_pass.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class Communityadd extends StatefulWidget {
  static const routeName = '/community_add';
  @override
  _CommunityaddState createState() => _CommunityaddState();
}

class _CommunityaddState extends State<Communityadd> {
  File _image;
  File _video;
  final _picker = ImagePicker();
  //bool _isUploading = false;
  String url;
  TextEditingController _textEditingController = TextEditingController();
  bool _isUploading = false;
  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  Future _addImg() async {
    final pickedFile = await _picker.getImage(
        source: ImageSource.gallery,
        imageQuality: 90,
        maxHeight: 600,
        maxWidth: 600);

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

  Future _addVid() async {
    final pickedFile = await _picker.getVideo(
      source: ImageSource.gallery,
    );

    setState(() {
      if (pickedFile != null) {
        _video = File(pickedFile.path);
      } else {
        Fluttertoast.showToast(
            msg: "No Video Selected",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final IsAdmin args = ModalRoute.of(context).settings.arguments;
    _addQues() async {
      if (_textEditingController.text.trim() != '') {
        setState(() {
          _isUploading = true;
        });
        if(_image!=null && _video!=null){
          Fluttertoast.showToast(
            msg: "Add either An Image or A Video",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
        }else if(_image!=null && _video==null){
          Key s = UniqueKey();
      String temp = s.toString();
      await firebase_storage.FirebaseStorage.instance
          .ref('community/$temp')
          .putFile(_image);
      String downloadURL = await firebase_storage.FirebaseStorage.instance
          .ref('community/$temp')
          .getDownloadURL();
      url = downloadURL;
        }else if (_video!=null && _image ==null){
          Key s = UniqueKey();
      String temp = s.toString();
      await firebase_storage.FirebaseStorage.instance
          .ref('community/$temp')
          .putFile(_video);
      String downloadURL = await firebase_storage.FirebaseStorage.instance
          .ref('community/$temp')
          .getDownloadURL();
      url = downloadURL;
        }
        final user = FirebaseAuth.instance.currentUser;
        await FirebaseFirestore.instance
            .collection('Community')
            .doc(DateTime.now().toString())
            .set({
          'uid': user.uid,
          'Question': _textEditingController.text.trim(),
          'Comments': [],
          'Image': _image!=null && url!=null ?url:'',
          'Video': _video!=null && url!=null ?url:'',
          'Likes': [],
          'TimeStamp': DateTime.now().toString(),
        });
        _textEditingController.clear();
        setState(() {
          _isUploading = false;
          _image = null;
          _video = null;
        });
        Navigator.of(context).pop();
      } else {
        Fluttertoast.showToast(
            msg: "Enter a valid Question",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "New Question",
          style: TextStyle(color: Colors.grey),
        ),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.close,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    color: Colors.blueAccent,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(child: Text("Keep these points in mind :")),
                          SizedBox(height: 5),
                          Text("* ASK ONLY RELAVENT QUESTIONS"),
                          Text('* POST WILL BE REMOVED IF FOUND IRRELEVANT'),
                          Text(
                              "* CURRENTLY ONLY ADMINS CAN POST VIDEO IN THIS SECTION"),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  enabled: _isUploading ? false : true,
                  decoration: InputDecoration(
                      hintText: "Enter your Question",
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
              //Expanded(child: SizedBox()),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(children: [
                    Divider(thickness: 5),
                    _isUploading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  InkWell(
                                    onTap: _addImg,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Icon(Icons.insert_link),
                                          _image != null
                                              ? Text('Change Image')
                                              : Text('Add Image'),
                                        ],
                                      ),
                                    ),
                                  ),
                                  _image != null
                                      ? Container(
                                          padding: EdgeInsets.all(8.0),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.38,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Row(children: [
                                            Icon(
                                              Icons.image,
                                              color: Colors.red,
                                            ),
                                            SizedBox(width: 2),
                                            Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.13,
                                                child: Text(
                                                  '${_image.path.split('/').last}',
                                                  maxLines: 1,
                                                )),
                                                IconButton(
                                                  iconSize: 15,
                                                icon: Icon(
                                                    Icons.cancel_outlined),
                                                onPressed: () {
                                                  setState(() {
                                                    _image = null;
                                                  });
                                                }),
                                          ]),
                                        )
                                      : SizedBox(height: 0, width: 0),
                                ],
                              ),
                              if(args.admin=="Yes" || args.admin=="Super")Column(
                                children: [
                                  InkWell(
                                    onTap: _addVid,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Icon(Icons.insert_link),
                                          _video != null
                                              ? Text('Change Video')
                                              : Text('Add Video'),
                                        ],
                                      ),
                                    ),
                                  ),
                                  _video != null
                                      ? Container(
                                          padding: EdgeInsets.all(8.0),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.38,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Row(children: [
                                            Icon(
                                              Icons.video_library,
                                              color: Colors.red,
                                            ),
                                            SizedBox(width: 2),
                                            Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.13,
                                                child: Text(
                                                  '${_video.path.split('/').last}',
                                                  maxLines: 1,
                                                )),
                                                IconButton(
                                                  iconSize: 15,
                                                icon: Icon(
                                                    Icons.cancel_outlined),
                                                onPressed: () {
                                                  setState(() {
                                                    _video = null;
                                                  });
                                                }),
                                          ]),
                                        )
                                      : SizedBox(height: 0, width: 0),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RaisedButton(
                                  disabledColor: Colors.grey,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  onPressed: _isUploading ? null : _addQues,
                                  child: Text('ADD'),
                                ),
                              )
                            ],
                          ),
                  ])),
            ],
          ),
        ),
      ),
    );
  }
}
