import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
    // TODO: implement dispose
    _textEditingController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    _addQues() async {
      setState(() {
        _isUploading = true;
      });
      final user = await FirebaseAuth.instance.currentUser;
      await FirebaseFirestore.instance
          .collection('Community')
          .doc(DateTime.now().toString())
          .set({
        'uid': user.uid,
        'Question': _textEditingController.text,
        'Comments': [],
        'Image': '',
        'Video': '',
        'Likes': '0',
        'TimeStamp': DateTime.now().toString(),
      });
      _textEditingController.text = '';
      setState(() {
        _isUploading = false;
      });
      Navigator.of(context).pop();
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
            children: [
              Card(
                color: Colors.blueAccent,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Keep these points in mind"),
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
              if (_isUploading)
                Center(
                  child: CircularProgressIndicator(),
                ),
              //Expanded(child: SizedBox()),
              Divider(thickness: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      disabledColor: Colors.grey,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      onPressed: _isUploading ? null : _addQues,
                      child: Text('ADD'),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
