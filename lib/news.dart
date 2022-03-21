import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:grivety/addnews.dart';
import 'package:grivety/news_dtail.dart';
import 'package:url_launcher/url_launcher.dart';
import './quest_pass.dart';
import 'package:dio/dio.dart';
import 'package:shimmer/shimmer.dart';

class News extends StatefulWidget {
  final String admin;
  News(this.admin);
  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  var data = [];
  var data2 = [];

  void _sheet(dynamic documents, int index) {
    Navigator.of(context)
        .pushNamed(NewsDetail.routeName, arguments: Details(documents, index));
  }

  @mustCallSuper
  Widget build(BuildContext context) {
    super.build(context);
    // Firebase.initializeApp();
    return Stack(
      children: [
        Container(
          key: new PageStorageKey('nsnx'),
          child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('News').snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final documents = snapshot.data!.docs;
                //print(documents.length);
                return FutureBuilder(future: Future.microtask(() async {
                  Response response;
                  var dio = Dio();
                  response = await dio
                      .get('http://10.0.2.2:3000/')
                      .timeout(Duration(seconds: 5));
                  data = (response.data['news']);
                  data2 = (response.data['newsLink']);
                }), builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                    itemBuilder: (_, int index) {
                      print(data.length);
                      return index == 0
                          ? StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('Slider')
                                  .snapshots(),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                final documents1 = snapshot.data!.docs;
                                return CarouselSlider.builder(
                                  options: CarouselOptions(
                                    pageViewKey: PageStorageKey('xn'),
                                    initialPage: 0,
                                    autoPlay: true,
                                    aspectRatio: 2.0,
                                    enlargeCenterPage: true,
                                  ),
                                  itemCount: documents1.length,
                                  itemBuilder: (BuildContext context,
                                          int itemIndex, _) =>
                                      _cardwidget(
                                          documents1, itemIndex, context),
                                );
                              })
                          : index >= documents.length
                              ? Card(
                                  child: Container(
                                    child: ListTile(
                                      title: Text(data[index -
                                          int.parse(
                                              documents.length.toString())]),
                                      subtitle: Text(''),
                                      onTap: () => launch(data2[index -
                                          int.parse(
                                              documents.length.toString())]),
                                    ),
                                  ),
                                  elevation: 10,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                )
                              : widget.admin == 'Yes' || widget.admin == 'Super'
                                  ? Dismissible(
                                      background: Container(
                                        color: Colors.red,
                                        child: Align(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              Icon(
                                                Icons.delete,
                                                color: Colors.white,
                                              ),
                                              Text(
                                                " Delete",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                                textAlign: TextAlign.right,
                                              ),
                                              SizedBox(
                                                width: 20,
                                              ),
                                            ],
                                          ),
                                          alignment: Alignment.centerRight,
                                        ),
                                      ),
                                      key:
                                          Key(documents[index].data()['Title']),
                                      direction: DismissDirection.startToEnd,
                                      child: GestureDetector(
                                        child: SingleItem(
                                            documents[index].data()['Title'],
                                            documents[index].data()['Image']),
                                        onTap: () {
                                          _sheet(documents, index);
                                        },
                                      ),
                                      confirmDismiss: (direction) async {
                                        final bool res = await showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                content: Text(
                                                    "Are you sure you want to delete ?"),
                                                actions: <Widget>[
                                                  FlatButton(
                                                    child: Text(
                                                      "Cancel",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                  FlatButton(
                                                    child: Text(
                                                      "Delete",
                                                      style: TextStyle(
                                                          color: Colors.red),
                                                    ),
                                                    onPressed: () {
                                                      FirebaseFirestore.instance
                                                          .collection('News')
                                                          .doc(documents[index -
                                                                  data.length]
                                                              .id)
                                                          .delete();
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                ],
                                              );
                                            });
                                        return res;
                                      },
                                    )
                                  : GestureDetector(
                                      child: SingleItem(
                                          documents[index].data()['Title'],
                                          documents[index].data()['Image']),
                                      onTap: () {
                                        _sheet(documents, index);
                                      },
                                    );
                    },
                    itemCount: documents.length + data.length,
                  );
                });
              }),
        ),
        if (widget.admin == 'Yes' || widget.admin == 'Super')
          Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FloatingActionButton(
                  heroTag: 'button_news_add',
                  child: Icon(Icons.add),
                  onPressed: () =>
                      Navigator.of(context).pushNamed(AddNews.routeName),
                ),
              )),
      ],
    );
  }

  Widget _cardwidget(List documents1, int itemIndex, BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: CachedNetworkImage(
              cacheKey: documents1[itemIndex].data()['Image'],
              imageUrl: documents1[itemIndex].data()['Image'],
              placeholder: (context, url) => Center(
                  child: Shimmer.fromColors(
                      enabled: true,
                      baseColor: Colors.grey[500]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: double.infinity,
                        color: Colors.white60,
                      ))),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          if (widget.admin == 'Yes' || widget.admin == 'Super')
            Align(
              alignment: Alignment.topRight,
              child: PopupMenuButton(
                itemBuilder: (BuildContext context) {
                  return <PopupMenuEntry>[
                    PopupMenuItem(
                      child: Text('Delete'),
                      value: 1,
                    ),
                  ];
                },
                onSelected: (value) {
                  if (value == 1) {
                    dynamic docu1 = documents1[itemIndex].id;
                    showDialog(
                        context: context,
                        builder: (_) {
                          return AlertDialog(
                            content: Text("Are you sure you want to delete ?"),
                            actions: <Widget>[
                              FlatButton(
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              FlatButton(
                                child: Text(
                                  "Delete",
                                  style: TextStyle(color: Colors.red),
                                ),
                                onPressed: () {
                                  FirebaseFirestore.instance
                                      .collection('Slider')
                                      .doc(docu1)
                                      .delete();
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        });
                  }
                },
              ),
            )
        ],
      ),
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
            child: Hero(
              tag: widget.url,
              child: CachedNetworkImage(
                cacheKey: widget.url,
                imageUrl: widget.url,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
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
