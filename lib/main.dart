import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grivety/addnews.dart';
import 'package:grivety/auth/addImage.dart';
import 'dart:async';
import 'package:grivety/auth/login.dart';
import 'package:grivety/auth/register.dart';
import 'package:grivety/comments.dart';
import 'package:grivety/edit_profile.dart';
import 'package:grivety/news_dtail.dart';
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
  bool _isTimerDone = false;
  @override
  void initState() {
    Timer(
        const Duration(seconds: 2), () => setState(() => _isTimerDone = true));
    super.initState();
  }

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
            home: appshapshot.connectionState != ConnectionState.done ||
                    !_isTimerDone
                ? Splash()
                : StreamBuilder(
                    stream: FirebaseAuth.instance.authStateChanges(),
                    builder: (ctx, userSnapshot) {
                      if (userSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Splash();
                      }
                      if (userSnapshot.hasData) {
                        return Test();
                      }
                      return Loginscreen();
                    }),
            routes: {
              Test.routeName: (ctx) => Test(),
              Splash.routeName: (ctx) => Splash(),
              Loginscreen.routeName: (ctx) => Loginscreen(),
              Communityadd.routeName: (ctx) => Communityadd(),
              Comments.routeName: (ctx) => Comments(),
              Register.routeName: (ctx) => Register(),
              AddImage.routeName: (ctx) => AddImage(),
              EditProfile.routeName: (ctx) => EditProfile(),
              AddNews.routeName: (ctx) => AddNews(),
              NewsDetail.routeName: (ctx) => NewsDetail(),
            },
            onUnknownRoute: (settings) {
              return MaterialPageRoute(
                builder: (ctx) => Loginscreen(),
              );
            },
          );
        });
  }
}
