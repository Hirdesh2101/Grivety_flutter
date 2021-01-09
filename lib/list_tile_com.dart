import 'package:flutter/material.dart';

class ListTileCommunity extends StatelessWidget {
  final dynamic documents;
  final int index;
  ListTileCommunity(this.documents,this.index);

  @override
  Widget build(BuildContext context) {
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
      trailing: IconButton(
        splashRadius: 20,
        padding: EdgeInsets.all(2),
        icon: Icon(Icons.more_vert),
        onPressed: () {},
      ),
    );
  }
  }