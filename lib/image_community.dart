import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class ImageCom extends StatelessWidget {
  int index;
  dynamic documents;
  ImageCom(this.documents,this.index);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        key: new Key(index.toString()),
        onDoubleTap: () {
          String valr = documents[index].data()['Likes'];
          int val = int.parse(valr);
          val++;
          FirebaseFirestore.instance
              .collection('Community')
              .doc(index.toString())
              .update({'Likes': val.toString()});
        },
        child: FadeInImage.assetNetwork(
          image: documents[index].data()['Image'],
          placeholder: 'assests/google.png',
          placeholderScale: 4.0,
        ));
  }
}
