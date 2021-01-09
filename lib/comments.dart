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
                    List<dynamic> list = snapshot.data.docs[0]['Comments'];
                    if(list.length==0){
                      return Center(
                        child:Text("No Comments Yet....")
                      );
                    }
                    return ListView.builder(itemBuilder: (_, int index) {
                      return Column(
                        children: [
                          ListTile(
                            leading: CircleAvatar(radius:15,backgroundColor:Colors.red),
                            title: Text(list[index]['Name']),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(18.0,0.0,8.0,8.0),
                            child: Align(alignment: Alignment.centerLeft,child: Text(list[index]['Com'])),
                          ),
                          Divider()
                        ],
                      );
                    },
                    itemCount: list.length,
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: TextField(
                enabled: _isUploading ? false : true,
                decoration: InputDecoration(
                    hintText: "Enter your Comment",
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
            Divider(thickness: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: RaisedButton(
                    disabledColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    onPressed: _isUploading
                        ? null
                        : () {
                            setState(() {
                              _isUploading = true;
                            });
                          },
                    child: Text('ADD'),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
