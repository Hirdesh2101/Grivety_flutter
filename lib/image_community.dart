import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:lottie/lottie.dart';

class ImageCom extends StatefulWidget {
  final int index;
  final dynamic documents;
  ImageCom(this.documents, this.index);

  @override
  _ImageComState createState() => _ImageComState();
}

class _ImageComState extends State<ImageCom> {
  bool _visible = false;
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!.uid;
    dynamic docu = widget.documents[widget.index].id;
    List<dynamic> list = widget.documents[widget.index].data()['Likes'];

    return StatefulBuilder(builder: (context, setState) {
      return GestureDetector(
          key: new Key(widget.index.toString()),
          onDoubleTap: () async {
            var obj = [user];

            //_setLike();
            if (list.contains(user)) {
              await FirebaseFirestore.instance
                  .collection('Community')
                  .doc(docu)
                  .update({'Likes': FieldValue.arrayRemove(obj)});
            } else {
              setState(() {
                _visible = !_visible;
              });
              Future.delayed(const Duration(seconds: 1), () {
                setState(() {
                  _visible = !_visible;
                });
              });
              await FirebaseFirestore.instance
                  .collection('Community')
                  .doc(docu)
                  .update({'Likes': FieldValue.arrayUnion(obj)});
            }
          },
          child: Stack(children: [
            CachedNetworkImage(
              cacheKey: widget.documents[widget.index].data()['Image'],
              imageUrl: widget.documents[widget.index].data()['Image'],
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            _visible
                ? Center(
                    child: Lottie.asset(
                      'assests/likeanim.json',
                      repeat: true,
                      height: 180,
                      width: 180,
                    ),
                  )
                : SizedBox(
                    width: 0,
                    height: 0,
                  ),
          ]));
    });
  }
}
