import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:share/share.dart';
import 'package:grivety/community.dart';
import './news.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import './people.dart';

class Test extends StatefulWidget {
  static const routeName = '/Test';
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
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
                  leading: Icon(Icons.person),
                  title: Text('Profile'),
                ),
                ListTile(
                  leading: Icon(Icons.mode_edit),
                  title: Text('Edit Profile'),
                ),
                ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text("Logout"),
                  onTap: () async {
                    final FirebaseAuth _firebase = FirebaseAuth.instance;
                    await _firebase.signOut();
                    Navigator.pop(context);
                  },
                ),
                Divider(),
                ListTile(
                  title: Text('Share'),
                  onTap: () => Share.share(
                      'check out my website https://example.com',
                      subject: 'Look what I made!'),
                ),
                ListTile(
                  title: Text('Report Bug'),
                  onTap: () async {
                    final Email email = Email(
                      body: 'Email body',
                      subject: 'Email subject',
                      recipients: ['example@example.com'],
                      //cc: ['cc@example.com'],
                      // bcc: ['bcc@example.com'],
                      //attachmentPaths: ['/path/to/attachment.zip'],
                      isHTML: false,
                    );
                    String platformResponse;
                    try {
                      await FlutterEmailSender.send(email);
                      platformResponse = 'success';
                    } catch (error) {
                      platformResponse = error.toString();
                    }
                    print(platformResponse);
                  },
                ),
                ListTile(
                  title: Text('Contact us'),
                ),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          bottom: TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: "News"),
              Tab(text: "Community"),
              Tab(text: "People"),
              Tab(
                text: "Book",
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            News(),
            Community(),
            People(),
            Center(child: Text('Coming Soon...'))
          ],
        ),
      ),
    );
  }
}
