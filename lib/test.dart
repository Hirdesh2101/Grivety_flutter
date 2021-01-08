import 'package:flutter/material.dart';
import 'package:grivety/community.dart';
import './news.dart';
import './people.dart';

class Test extends StatefulWidget {
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
        drawer: Drawer(child: Text("hello"),),
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
