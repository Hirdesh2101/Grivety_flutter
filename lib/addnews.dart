import 'package:flutter/material.dart';
import './newsadd.dart';
import './slider_add.dart';

class AddNews extends StatelessWidget {
  static const routeName = '/add_news';
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
         appBar: AppBar(
          bottom: TabBar(
            isScrollable: false,
            tabs: [
              Tab(text: "Slider"),
              Tab(text: "News"),
            ],
          ),
        ),
        body: TabBarView(children: [
          SliderAdd(),
          NewsAdd(),
        ],),
      ),
    );
  }
}