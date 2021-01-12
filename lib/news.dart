import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class News extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Firebase.initializeApp();
    return Container(
      key: new PageStorageKey('nsnx'),
      child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('News').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final documents = snapshot.data.documents;
            //print(documents.length);
            return new ListView.builder(
              itemBuilder: (_, int index) {
                return index == 0
                    ? CarouselSlider.builder(
                        options: CarouselOptions(
                          pageViewKey: PageStorageKey('xn'),
                          initialPage: 0,
                          autoPlay: true,
                          aspectRatio: 2.0,
                          enlargeCenterPage: true,
                        ),
                        itemCount: documents.length,
                        itemBuilder: (BuildContext context, int itemIndex) =>
                            Container(
                          child: Image.network(
                            documents[itemIndex].data()['Image'],
                            height: 100,
                            width: 250,
                          ),
                        ),
                      )
                    : GestureDetector(
                        child: SingleItem(documents[index].data()['Title'],
                            documents[index].data()['Image']),
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                topLeft: const Radius.circular(10),
                                topRight: const Radius.circular(10),
                              )),
                              isDismissible: true,
                              builder: (context) => Wrap(children: [
                                    Container(
                                      child: Column(
                                        children: [
                                          Align(
                                              alignment: Alignment.center,
                                              child: Image.network(
                                                documents[index]
                                                    .data()['Image'],
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.25,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                              )),
                                          Text(documents[index].data()['Data']),
                                        ],
                                      ),
                                    ),
                                  ]));
                        },
                      );
              },
              itemCount: documents.length,
            );
          }),
    );
  }
}

@override
class SingleItem extends StatefulWidget {
  SingleItem(this.title, this.url);
  final String title;
  final String url;

  @override
  _SingleItemState createState() => _SingleItemState();
}

class _SingleItemState extends State<SingleItem> {
  @override
  Widget build(BuildContext context) {
    return new Card(
      child: Container(
        child: ListTile(
          title: Text(widget.title),
          subtitle: Text(''),
          trailing: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CachedNetworkImage(
              imageUrl: widget.url,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
        ),
      ),
      elevation: 10,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5))),
    );
  }
}
