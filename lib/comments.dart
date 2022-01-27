import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grivety/quest_pass.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:readmore/readmore.dart';

class Comments extends StatefulWidget {
  static const routeName = '/comments';
  @override
  _CommentsState createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  TextEditingController _textEditingController = TextEditingController();
  bool _isUploading = false;

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final QuesPass args =
        ModalRoute.of(context)!.settings.arguments as QuesPass;
    print(args.ques);
    _addcomment() async {
      if (_textEditingController.text.trim() != '') {
        setState(() {
          _isUploading = true;
        });
        String docu = '';
        await FirebaseFirestore.instance
            .collection('Community')
            .where('Question', isEqualTo: args.ques)
            .get()
            .then((value) {
          docu = value.docs[0].id;
        });
        final user = FirebaseAuth.instance.currentUser;
        var obj = [
          {'Com': _textEditingController.text.trim(), 'uid': user!.uid}
        ];
        await FirebaseFirestore.instance
            .collection('Community')
            .doc(docu)
            .update({'Comments': FieldValue.arrayUnion(obj)});
        _textEditingController.clear();
        setState(() {
          _isUploading = false;
        });
      } else {
        Fluttertoast.showToast(
            msg: "Enter a valid Comment",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Comments",
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
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('Community')
                      .where('Question', isEqualTo: args.ques)
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    // String docu = snapshot.data.docs[0].id;
                    List<dynamic> list = snapshot.data!.docs[0]['Comments'];
                    print(list);
                    if (list.length == 0) {
                      return Center(child: Text("No Comments Yet...."));
                    }
                    return ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (_, int index) {
                        return Column(
                          children: [
                            StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection('Users')
                                    .doc(list[index]['uid'])
                                    .snapshots(),
                                builder: (context,
                                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                                  final data = snapshot.data!;
                                  if (!snapshot.hasData) {
                                    return ListTile(
                                      leading: CircleAvatar(
                                        radius: 15,
                                        backgroundColor: Colors.black26,
                                      ),
                                      title: Text(''),
                                    );
                                  }
                                  return ListTile(
                                    leading: ClipOval(
                                        // radius: 15,
                                        child: (data['Image'] == 'Male' ||
                                                data['Image'] == 'Female')
                                            ? data['Image'] == 'Male'
                                                ? Image.asset(
                                                    "assests/male.jpg")
                                                : Image.asset(
                                                    "assests/female.jpg")
                                            : Image.network(data['Image'])),
                                    title: Text(data['Name']),
                                  );
                                }),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  18.0, 0.0, 8.0, 8.0),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: ReadMoreText(
                                    list[index]['Com'],
                                    trimLines: 3,
                                    trimMode: TrimMode.Line,
                                  )),
                            ),
                            Divider()
                          ],
                        );
                      },
                      itemCount: list.length,
                    );
                  }),
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.78,
                    child: TextField(
                      enabled: _isUploading ? false : true,
                      decoration: InputDecoration(
                          hintText: "Enter Comment",
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
                ),
                //Expanded(child: SizedBox()),
                _isUploading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.17,
                          child: RaisedButton(
                            disabledColor: Colors.grey,
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(13),
                            // RoundedRectangleBorder(
                            //    borderRadius: BorderRadius.all(Radius.circular(200))),
                            onPressed: _isUploading ? null : _addcomment,
                            child: Icon(Icons.send),
                          ),
                        ),
                      )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
