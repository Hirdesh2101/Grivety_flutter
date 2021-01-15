import 'package:flutter/material.dart';
import 'package:grivety/community_add.dart';
import 'package:grivety/image_community.dart';
import 'package:grivety/like_com.dart';
import './video_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './list_tile_com.dart';

class Community extends StatefulWidget {
  final String admin;
  Community(this.admin);
  @override
  _CommunityState createState() => _CommunityState();
}

class _CommunityState extends State<Community>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          key: new PageStorageKey('community'),
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Community')
                  .orderBy('TimeStamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final documents = snapshot.data.documents;
                return ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      key: new ValueKey(index.toString()),
                      children: [
                        ListTileCommunity(documents, index,widget.admin),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                documents[index].data()['Question'],
                                textAlign: TextAlign.left,
                              ),
                            )),
                        if (documents[index].data()['Image'] != '')
                          ImageCom(documents, index),
                        if (documents[index].data()['Video'] != '')
                          VideoPlayercustom(index.toString()),
                        LikeCom(documents, index),
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
                heroTag: 'button_comm_add',
                  child: Icon(Icons.add),
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      Communityadd.routeName,
                    );
                  }),
            )),
      ],
    );
  }
}
