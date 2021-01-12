import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum MenuOption { Report, Delete }

class ListTileCommunity extends StatelessWidget {
  final dynamic documents;
  final int index;
  ListTileCommunity(this.documents, this.index);

  @override
  Widget build(BuildContext context) {
    //print(admin);

    return ListTile(
      leading: CircleAvatar(
        child: Image.asset(
          'assests/google.png',
          height: 80,
          width: 80,
        ),
      ),
      title: Text(documents[index].data()['Name']),
      subtitle: Text('year'),
      trailing: PopupMenuButton(
        itemBuilder: (BuildContext context) {
          return <PopupMenuEntry>[
            PopupMenuItem(
              child: Text('Report'),
              value: 1,
            ),
            if ('y' == 'YES')
              PopupMenuItem(
                child: Text('Delete'),
                value: 2,
              ),
          ];
        },
        onSelected: (value){
          final user = FirebaseAuth.instance.currentUser.uid;
          var obj = [{'User':user}];
          if(value==1){
            dynamic docu = documents[index].id;
            FirebaseFirestore.instance.collection('Community').doc(docu).update({'Reports':FieldValue.arrayUnion(obj)});
          }
        },
      ),
      /* IconButton(
        splashRadius: 20,
        padding: EdgeInsets.all(2),
        icon: Icon(Icons.more_vert),
        onPressed: () {},
      ),*/
    );
  }
}
