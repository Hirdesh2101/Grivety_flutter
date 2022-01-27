import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum MenuOption { Report, Delete }

class ListTileCommunity extends StatelessWidget {
  final dynamic documents;
  final int index;
  final String admin;
  ListTileCommunity(this.documents, this.index, this.admin);
  @override
  Widget build(BuildContext context) {
    //print(admin);
    return FutureBuilder(
        // key: new Key(index.toString()),
        future: FirebaseFirestore.instance
            .collection('Users')
            .doc(documents[index].data()['uid'])
            .get(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          final data = snapshot.data!;
          if (!snapshot.hasData) {
            return ListTile(
              leading: ClipOval(
                  child: CircleAvatar(
                backgroundColor: Colors.black26,
              )),
              title: Text(''),
              subtitle: Text(''),
            );
          }
          return ListTile(
            leading: ClipOval(
              //backgroundColor: Colors.black38,
              child: (data['Image'] == 'Male' || data['Image'] == 'Female')
                  ? data['Image'] == 'Male'
                      ? Image.asset("assests/male.jpg")
                      : Image.asset("assests/female.jpg")
                  : Image.network(data['Image']),
            ),
            title: Text(data['Name']),
            subtitle: Text(data['Year']),
            trailing: PopupMenuButton(
              itemBuilder: (BuildContext context) {
                return <PopupMenuEntry>[
                  PopupMenuItem(
                    child: Text('Report'),
                    value: 1,
                  ),
                  if (admin == 'Yes' || admin == 'Super')
                    PopupMenuItem(
                      child: Text('Delete'),
                      value: 2,
                    ),
                ];
              },
              onSelected: (value) {
                final user = FirebaseAuth.instance.currentUser!.uid;
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
