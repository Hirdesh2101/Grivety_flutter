import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:share/share.dart';
import 'package:grivety/community.dart';
import './news.dart';
import 'package:flutter_mailer/flutter_mailer.dart';
import './people.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Test extends StatefulWidget {
  static const routeName = '/Test';
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser.uid;
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        drawer: Container(
          margin: MediaQuery.of(context).padding,
          child: Drawer(
            child: ListView(
              children: <Widget>[
                DrawerHeader(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(),
                      Text('Welcome'),
                      StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('Users')
                              .doc(user)
                              .snapshots(),
                          builder: (context, snapshot) {
                            return Text(snapshot.data.data()['Name']);
                          }),
                    ],
                  ),
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
                    String platformResponse;
                    final MailOptions mailOptions = MailOptions(
                      subject: 'Bug Report',
                      recipients: ['hirdeshgarg0012@gmail.com'],
                      isHTML: false,
                    );

                    final MailerResponse response =
                        await FlutterMailer.send(mailOptions);
                    switch (response) {
                      case MailerResponse.saved:

                        /// ios only
                        platformResponse = 'mail was saved to draft';
                        break;
                      case MailerResponse.sent:

                        /// ios only
                        platformResponse = 'mail was sent';
                        break;
                      case MailerResponse.cancelled:

                        /// ios only
                        platformResponse = 'mail was cancelled';
                        break;
                      case MailerResponse.android:
                        platformResponse = 'intent was successful';
                        break;
                      default:
                        platformResponse = 'unknown';
                        break;
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
              Tab(text: "Book")
            ],
          ),
        ),
        body: FutureBuilder(
            future:
                FirebaseFirestore.instance.collection('Users').doc(user).get(),
            builder: (context, snapshot) {
              var doc = snapshot.data;
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              return TabBarView(
                children: [
                  News(doc['Admin']),
                  Community(doc['Admin']),
                  People(),
                  Center(child: Text('Coming Soon...'))
                ],
              );
            }),
      ),
    );
  }
}
