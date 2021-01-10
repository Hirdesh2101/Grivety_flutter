import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grivety/quest_pass.dart';

class Comments extends StatefulWidget {
  static const routeName = '/comments';
  @override
  _CommentsState createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  TextEditingController _textEditingController = TextEditingController();
  bool _isUploading = false;

  @override
  Widget build(BuildContext context) {
    final QuesPass args = ModalRoute.of(context).settings.arguments;
    _addcomment() async{
      setState(() {
        _isUploading = true;
      });
      String docu='';
      await FirebaseFirestore.instance
                      .collection('Community')
                      .where('Question', isEqualTo: args.ques)
                      .get().then((value) { docu = value.docs[0].id;});
      //String docu = snapshot.data.docs[0].id;
      print(docu);
      var obj = [{'Com':_textEditingController.text,'Name':'yes'}];
      await FirebaseFirestore.instance.collection('Community').doc(docu).update({'Comments':FieldValue.arrayUnion(obj)});
      _textEditingController.text ='';  
      setState(() {
        _isUploading = false;
      });    
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
                    List<dynamic> list = snapshot.data.docs[0]['Comments'];
                    if (list.length == 0) {
                      return Center(child: Text("No Comments Yet...."));
                    }
                    return ListView.builder(
                      itemBuilder: (_, int index) {
                        return Column(
                          children: [
                            ListTile(
                              leading: CircleAvatar(
                                  radius: 15, backgroundColor: Colors.red),
                              title: Text(list[index]['Name']),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  18.0, 0.0, 8.0, 8.0),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(list[index]['Com'])),
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
                    width: MediaQuery.of(context).size.width*0.78,
                    child: TextField(
                      enabled: _isUploading ? false : true,
                      decoration: InputDecoration(
                          hintText: "Enter Comment",
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
                ),
                //Expanded(child: SizedBox()),
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: Container(
                width: MediaQuery.of(context).size.width*0.17,
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
            if (_isUploading)
              Center(
                child: CircularProgressIndicator(),
              ),
            
          ],
        ),
      ),
    );
  }
}
