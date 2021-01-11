import 'package:flutter/material.dart';

enum MenuOption{Report,Delete}

class ListTileCommunity extends StatelessWidget {
  final dynamic documents;
  final String admin;
  final int index;
  ListTileCommunity(this.documents,this.index,this.admin);

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
      trailing: PopupMenuButton<MenuOption>(
        itemBuilder: (BuildContext context){
          return <PopupMenuEntry<MenuOption>>[
            PopupMenuItem(child: Text('Report'),
            value: MenuOption.Report,
            ),
            if(admin =='YES')PopupMenuItem(child: Text('Delete'),
            value: MenuOption.Delete,
            ),
          ];
        },
      )
      
      
     /* IconButton(
        splashRadius: 20,
        padding: EdgeInsets.all(2),
        icon: Icon(Icons.more_vert),
        onPressed: () {},
      ),*/
    );
  }
  }