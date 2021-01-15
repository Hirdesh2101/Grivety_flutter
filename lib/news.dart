import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class News extends StatefulWidget {
  final String admin;
  News(this.admin);
  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    // Firebase.initializeApp();
    return Stack(
      children: [
        Container(
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
                        ? StreamBuilder(
                          stream: FirebaseFirestore.instance.collection('Slider').snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final documents1 = snapshot.data.documents;
                            return CarouselSlider.builder(
                                options: CarouselOptions(
                                  pageViewKey: PageStorageKey('xn'),
                                  initialPage: 0,
                                  autoPlay: true,
                                  aspectRatio: 2.0,
                                  enlargeCenterPage: true,
                                ),
                                itemCount: documents1.length,
                                itemBuilder:
                                    (BuildContext context, int itemIndex) =>
                                        Container(
                                  child: CachedNetworkImage(
                                    imageUrl: documents1[itemIndex].data()['Image'],
                                    placeholder: (context, url) =>
                                        Center(child: CircularProgressIndicator()),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                ),
                              );
                          }
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
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(height: 15,),
                                              Align(
                                                  alignment: Alignment.center,
                                                  child: Image.network(
                                                    documents[index]
                                                        .data()['Image'],
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.25,
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                  )),
                                              Center(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(12.0),
                                                  child: Text(documents[index]
                                                      .data()['Title'],style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.start,),
                                                ),
                                              ),
                                              Padding(
                                                  padding: const EdgeInsets.all(12.0),
                                                  child: Text(documents[index]
                                                      .data()['Data'],style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.start,),
                                                ),
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
        ),
        if (widget.admin == 'Yes')
          Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FloatingActionButton(
                  heroTag: 'button_news_add',
                  child: Icon(Icons.add),
                  onPressed: () {},
                ),
              )),
      ],
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
