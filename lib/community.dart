import 'package:flutter/material.dart';
//import 'package:flutter_native_admob/native_admob_options.dart';
//import 'package:flutter_native_admob/flutter_native_admob.dart';
//import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:grivety/community_add.dart';
import 'package:grivety/image_community.dart';
import 'package:grivety/like_com.dart';
import './video_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './list_tile_com.dart';

class Community extends StatefulWidget {
  @override
  _CommunityState createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  //static const _adUnitID = "<ca-app-pub-3940256099942544/2247696110>";
   //final _controller = NativeAdmobController();
  
  @override
  void dispose() {
   // _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser.uid;
    String s = '';
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
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        //if (index % 3 == 0)
                         /* Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.only(bottom: 20.0),
                            child: NativeAdmob(
                             // options: NativeAdmobOptions(),
                              adUnitID: _adUnitID,
                              controller: _controller,
                              loading: Center(child: CircularProgressIndicator()),
                            ),
                          ),*/
                        ListTileCommunity(documents, index, s),
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
                        LikeCom(
                          documents[index].data()['Question'],
                        ),
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
                    Navigator.of(context).pushNamed(
                      Communityadd.routeName,
                    );
                  }),
            )),
      ],
    );
  }
}
