import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './quest_pass.dart';
import './comments.dart';

class LikeCom extends StatelessWidget {
  final int index;
  final dynamic documents;
  final String question;
  LikeCom(this.documents, this.index, this.question);
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser.uid;
    dynamic docu = documents[index].id;
    List<dynamic> list = documents[index]['Likes'];
    return Row(children: [
      SizedBox(width: 5,),
      Row(
        children: [
          IconButton(
            iconSize: 24,
            splashRadius: 28,
              icon: Icon(
                list.contains(user) ? Icons.favorite : Icons.favorite_border,
                color: list.contains(user) ? Colors.redAccent : Colors.white,
              ), onPressed: () async {
            var obj = [user];
            if (list.contains(user)) {
              FirebaseFirestore.instance
                  .collection('Community')
                  .doc(docu)
                  .update({'Likes': FieldValue.arrayRemove(obj)});
            } else {
              FirebaseFirestore.instance
                  .collection('Community')
                  .doc(docu)
                  .update({'Likes': FieldValue.arrayUnion(obj)});
            }
          }),
          Text(documents[index].data()['Likes'].length.toString()),
        ],
      ),
      SizedBox(width: 8,),
      Row(
        children: [
          IconButton(
            
            icon:  Icon(Icons.chat_bubble_outline),
              
            
            onPressed: () {
              print(documents[index].data()['Question']);
              Navigator.of(context).pushNamed(Comments.routeName,
                  arguments: QuesPass(documents[index].data()['Question']));
            },
          ),
          Text(documents[index].data()['Comments'].length.toString())
        ],
      )
    ]);
  }
}
