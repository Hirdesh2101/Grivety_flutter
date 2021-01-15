import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cached_network_image/cached_network_image.dart';

enum MenuOption { Report, Delete }

class ListTileCommunity extends StatelessWidget {
  final dynamic documents;
  final int index;
  final String admin;
  ListTileCommunity(this.documents, this.index,this.admin);
  @override
  Widget build(BuildContext context) {
    //print(admin);
    return FutureBuilder(
        // key: new Key(index.toString()),
        future: FirebaseFirestore.instance
            .collection('Users')
            .doc(documents[index].data()['uid'])
            .get(),
        builder: (context, snapshot) {
          final data = snapshot.data;
          if (!snapshot.hasData) {
            return ListTile(
              leading: ClipOval(child: CircleAvatar(backgroundColor: Colors.white,)),
              subtitle: Text(''),
            );
          }
          return ListTile(
            leading: ClipOval(
              child: CachedNetworkImage(
                imageUrl: data['Image'],
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            title: Text(documents[index].data()['Name']),
            subtitle: Text(data['Year']),
            trailing: PopupMenuButton(
              itemBuilder: (BuildContext context) {
                return <PopupMenuEntry>[
                  PopupMenuItem(
                    child: Text('Report'),
                    value: 1,
                  ),
                  if (admin == 'Yes')
                    PopupMenuItem(
                      child: Text('Delete'),
                      value: 2,
                    ),
                ];
              },
              onSelected: (value) {
                final user = FirebaseAuth.instance.currentUser.uid;
                var obj = [
                  {'User': user}
                ];
                if (value == 1) {
                  dynamic docu = documents[index].id;
                  FirebaseFirestore.instance
                      .collection('Community')
                      .doc(docu)
                      .update({'Reports': FieldValue.arrayUnion(obj)});
                }
                if (value == 2) {
                  dynamic docu = documents[index].id;
                  FirebaseFirestore.instance
                      .collection('Community')
                      .doc(docu)
                      .delete();
                }
              },
            ),
          );
        });
  }
}
