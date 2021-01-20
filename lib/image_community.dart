import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImageCom extends StatefulWidget {
  final int index;
  final dynamic documents;
  ImageCom(this.documents, this.index);

  @override
  _ImageComState createState() => _ImageComState();
}

class _ImageComState extends State<ImageCom> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        key: new Key(widget.index.toString()),
        onDoubleTap: () {
          String valr = widget.documents[widget.index].data()['Likes'];
          int val = int.parse(valr);
          val++;
          FirebaseFirestore.instance
              .collection('Community')
              .doc(widget.index.toString())
              .update({'Likes': val.toString()});
        },
        child: CachedNetworkImage(
          cacheKey: widget.documents[widget.index].data()['Image'],
          imageUrl: widget.documents[widget.index].data()['Image'],
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ));
  }
}
