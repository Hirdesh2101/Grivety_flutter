import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:grivety/community.dart';
import './news.dart';
import './people.dart';

class Test extends StatefulWidget {
  static const routeName ='/Test';
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> with AutomaticKeepAliveClientMixin<Test> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DefaultTabController(length: 4,
      child: Scaffold(
        drawer: Container(
        margin: MediaQuery.of(context).padding,
        child: Drawer(
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                child: Text("Header"),
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text("Logout"),
                onTap: () async {
                  final FirebaseAuth _firebase = FirebaseAuth.instance;
                  await _firebase.signOut();
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
        appBar: AppBar(
          bottom: TabBar(
            isScrollable: true,
            tabs: [
            Tab(text:"News"),
            Tab(text:"Community"),
            Tab(text:"People"),
            Tab(text: "Book",)
          ],
          
          ),
        ),
        body: TabBarView(children: [
          News(),
          Community(),
          People(),
          Text('4')
        ],),
      ),
      );
  }
}
