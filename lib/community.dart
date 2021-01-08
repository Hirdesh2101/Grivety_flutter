import 'package:flutter/material.dart';
import 'package:grivety/community_add.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Community extends StatefulWidget {
  @override
  _CommunityState createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          key: new PageStorageKey('community'),
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Community')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final documents = snapshot.data.documents;
                return ListView.builder(
                  reverse: true,
                  itemBuilder: (_, int index) {
                    return Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            child: Image.asset(
                              'assests/google.png',
                              height: 80,
                              width: 80,
                            ),
                          ),
                          title: Text(documents[index].data()['Name']),
                          subtitle: Text('year'),
                          trailing: IconButton(
                            splashRadius: 20,
                            padding: EdgeInsets.all(2),
                            icon: Icon(Icons.more_vert),
                            onPressed: () {},
                          ),
                        ),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                documents[index].data()['Question'],
                                textAlign: TextAlign.left,
                              ),
                            )),
                        if(documents[index].data()['Image']!='')Image.network(
                                                documents[index]
                                                    .data()['Image'],
                                              ),
                        Row(children: [
                          FlatButton(
                            child: Row(children: [
                              Icon(Icons.thumb_up_sharp),
                              SizedBox(height:1,width:8),
                              Text(documents[index].data()['Likes'])
                            ]),
                            onPressed: () {
                              String valr = documents[index].data()['Likes'];
                              int val = int.parse(valr);
                              val++;
                              print(index.toString());
                              FirebaseFirestore.instance.collection('Community').doc(index.toString()).update({'Likes':val.toString()});
                            },
                          ),
                          FlatButton(
                            child: Row(children: [
                              Icon(Icons.comment),
                              SizedBox(height:1,width:8),
                              
                              Text(documents[index].data()['Likes'])
                            ]),
                            onPressed: () {},
                          )
                        ]),
                        Divider(
                          thickness: 2,
                        )
                      ],
                    );
                  },
                  itemCount: documents.length,
                );
              }),
        ),
        Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                  child: Icon(Icons.add),
                  onPressed: () {
                    Navigator.of(context).pushNamed(Communityadd.routeName);
                  }),
            )),
      ],
    );
  }
}
