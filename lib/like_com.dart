import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './quest_pass.dart';
import './comments.dart';

class LikeCom extends StatelessWidget {

  final String question;
  LikeCom(this.question);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
                  .collection('Community').where('Question',isEqualTo: question)
                  .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );}
          final documents = snapshot.data.documents;
          List<dynamic> list = snapshot.data.docs[0]['Comments'];
          return Row(children: [
            FlatButton(
              child: Row(children: [
                Icon(Icons.thumb_up_sharp),
                SizedBox(height: 1, width: 8),
                Text(documents[0].data()['Likes'])
              ]),
              onPressed: () {
                String valr = documents[0].data()['Likes'];
                int val = int.parse(valr);
                val++;
                snapshot.data.doc.update({'Likes': val.toString()});
                // FirebaseFirestore.instance
               //     .collection('Community')
                 //   .doc(0)
                   // .update({'Likes': val.toString()});
              },
            ),
            FlatButton(
              child: Row(children: [
                Icon(Icons.comment),
                SizedBox(height: 1, width: 8),
                Text(list.length.toString())
              ]),
              onPressed: () {
                Navigator.of(context).pushNamed(Comments.routeName,
                    arguments: QuesPass(documents[0].data()['Question']));
              },
            )
          ]);
        });
  }
}
