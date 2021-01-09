import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:grivety/comments.dart';
import 'package:grivety/community_add.dart';
import 'package:grivety/splash.dart';
import './test.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initialize = Firebase.initializeApp();
    return FutureBuilder(
        future: _initialize,
        builder: (context, appshapshot) {
          return MaterialApp(
            title: "Grivety",
            theme: ThemeData.dark(),
            darkTheme: ThemeData.dark(),
            home: appshapshot.connectionState != ConnectionState.done
                ? Splash()
                : Test(),
            routes: {
              Splash.routeName: (ctx) => Splash(),
              Communityadd.routeName: (ctx) => Communityadd(),
              Comments.routeName: (ctx) => Comments(),
            },
            onUnknownRoute: (settings) {
              return MaterialPageRoute(
                builder: (ctx) => Test(),
              );
            },
          );
        });
  }
}
