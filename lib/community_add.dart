import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Communityadd extends StatefulWidget {
  static const routeName = '/community_add';
  @override
  _CommunityaddState createState() => _CommunityaddState();
}

class _CommunityaddState extends State<Communityadd> {
  TextEditingController _textEditingController = TextEditingController();
  bool _isUploading = false;
  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _addQues() async {
      if (_textEditingController.text.trim() != '') {
        setState(() {
          _isUploading = true;
        });
        final user = FirebaseAuth.instance.currentUser;
        await FirebaseFirestore.instance
            .collection('Community')
            .doc(DateTime.now().toString())
            .set({
          'uid': user.uid,
          'Question': _textEditingController.text.trim(),
          'Comments': [],
          'Image': '',
          'Video': '',
          'Likes': [],
          'TimeStamp': DateTime.now().toString(),
        });
        _textEditingController.clear();
        setState(() {
          _isUploading = false;
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
                          Center(
                              child: Text("Keep these points in mind :")),
                          SizedBox(height: 5),
                          Text("* ASK ONLY RELAVENT QUESTIONS"),
                          Text(
                              '* POST WILL BE REMOVED IF FOUND IRRELEVANT'),
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
                          borderRadius:
                              BorderRadius.all(Radius.circular(10)))),
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
                              GestureDetector(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(Icons.insert_link),
                            Text('Add Image'),
                          ],
                        ),
                      ),
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
