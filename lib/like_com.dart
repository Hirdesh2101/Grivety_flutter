import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:like_button/like_button.dart';
import './quest_pass.dart';
import './comments.dart';

class LikeCom extends StatelessWidget {
  final int index;
  final dynamic documents;
  final String question;
  LikeCom(this.documents, this.index, this.question);
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!.uid;
    dynamic docu = documents[index].id;
    List<dynamic> list = documents[index]['Likes'];
    Future<bool> likeFunc(bool init) async {
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
      return !init;
    }

    return Row(children: [
      SizedBox(
        width: 5,
      ),
      Row(
        children: [
          LikeButton(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              size: 24,
              padding: const EdgeInsets.all(0.0),
              isLiked: list.contains(user) ? true : false,
              likeBuilder: (bool isLiked) {
                return Icon(
                  isLiked ? Icons.favorite : Icons.favorite_border,
                  color: isLiked ? Colors.red : Colors.white,
                  // size: kIsWeb &&
                  //         (defaultTargetPlatform ==
                  //                 TargetPlatform.windows ||
                  //             defaultTargetPlatform ==
                  //                 TargetPlatform.macOS ||
                  //             defaultTargetPlatform ==
                  //                 TargetPlatform.linux)
                  //     ? MediaQuery.of(context).size.height * 0.070
                  //     : MediaQuery.of(context).size.width * 0.070,
                );
              },
              onTap: likeFunc),
          Text(documents[index].data()['Likes'].length.toString()),
        ],
      ),
      SizedBox(
        width: 8,
      ),
      Row(
        children: [
          IconButton(
            icon: Icon(Icons.chat_bubble_outline),
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
