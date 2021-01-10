import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ImageCom extends StatefulWidget {
  int index;
  dynamic documents;
  ImageCom(this.documents, this.index);

  @override
  _ImageComState createState() => _ImageComState();
}

class _ImageComState extends State<ImageCom> {
  TransformationController controller = TransformationController();

  String velocity = "VELOCITY";

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
        child: InteractiveViewer(
          maxScale: 5.0,
          transformationController: controller,
          onInteractionEnd: (ScaleEndDetails end){
            controller.value = Matrix4.identity();
            setState(() {
              velocity = end.velocity.toString();
            });
          },
          child: FadeInImage.assetNetwork(
            image: widget.documents[widget.index].data()['Image'],
            placeholder: 'assests/google.png',
            placeholderScale: 4.0,
          ),
        ));
  }
}