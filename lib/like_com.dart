import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './quest_pass.dart';
import './comments.dart';

class LikeCom extends StatelessWidget {
  final int index;
  final dynamic documents;
  LikeCom(this.documents, this.index);
  @override
  Widget build(BuildContext context) {
    List<dynamic> list = documents[index].data()['Comments'];
    return Row(children: [
            FlatButton(
              child: Row(children: [
                Icon(Icons.thumb_up_sharp),
                SizedBox(height: 1, width: 8),
                Text(documents[index].data()['Likes'])
              ]),
              onPressed: () async {
                String index2 = documents[index].id;
                String valr = documents[index].data()['Likes'];
                int val = int.parse(valr);
                val++;
                FirebaseFirestore.instance
                    .collection('Community')
                    .doc(index2.toString())
                    .update({'Likes': val.toString()});
              },
            ),
            FlatButton(
              child: Row(children: [
                Icon(Icons.comment),
                SizedBox(height: 1, width: 8),
                Text(list.length.toString())
              ]),
              onPressed: () {
                print(documents[index].data()['Question']);
                Navigator.of(context).pushNamed(Comments.routeName,
                    arguments: QuesPass(documents[index].data()['Question']));
              },
            )
          ]);
  }
}
