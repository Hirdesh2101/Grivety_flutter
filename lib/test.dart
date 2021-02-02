import 'package:grivety/clubs.dart';

import './edit_profile.dart';
import './custom_dailog.dart';
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
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Users')
                    .doc(user)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Container(),
                    );
                  }
                  return ListView(
                    children: <Widget>[
                      DrawerHeader(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 45,
                                  backgroundImage: (snapshot.data
                                                  .data()['Image'] ==
                                              'Male' ||
                                          snapshot.data.data()['Image'] ==
                                              'Female')
                                      ? snapshot.data.data()['Image'] == 'Male'
                                          ? AssetImage("assests/male.jpg")
                                          : AssetImage("assests/female.jpg")
                                      : NetworkImage(
                                          snapshot.data.data()['Image']),
                                ),
                                SizedBox(height: 10),
                                Text('Welcome'),
                                Text(snapshot.data.data()['Name']),
                              ],
                            ),
                          ],
                        ),
                      ),
                      ListTile(
                          leading: Icon(Icons.person),
                          title: Text('Profile'),
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CustomDialogBox(
                                    title: snapshot.data.data()['Name'],
                                    img: snapshot.data.data()['Image'],
                                    text: 'Close',
                                    descriptions: snapshot.data
                                                .data()['Description'] ==
                                            null
                                        ? "No Description"
                                        : snapshot.data.data()['Description'],
                                    branch: snapshot.data.data()['Branch'],
                                  );
                                });
                          }),
                      ListTile(
                        leading: Icon(Icons.mode_edit),
                        title: Text('Edit Profile'),
                        onTap: () => Navigator.of(context)
                            .pushNamed(EditProfile.routeName),
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
                            'Check out my app Grivety ....',
                            subject: 'Look what I made!'),
                      ),
                      ListTile(
                        title: Text('Report Bug'),
                        onTap: () async {
                          final MailOptions mailOptions = MailOptions(
                            subject: 'Bug Report',
                            recipients: ['grivetyapp@gmail.com'],
                            isHTML: false,
                          );
                          await FlutterMailer.send(mailOptions);
                        },
                      ),
                      ListTile(
                          title: Text('About us'),
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CustomDialogBox(
                                    title: 'Grivety',
                                    img: '',
                                    text: 'Close',
                                    descriptions:
                                        "App developed by Hirdesh Garg 2nd Year Chemical Engineering",
                                    branch: '',
                                  );
                                });
                          }),
                    ],
                  );
                }),
          ),
        ),
        appBar: AppBar(
          bottom: TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: "Community"),
              Tab(text: "News"),
              Tab(text: "People"),
              Tab(text: "Clubs")
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
                  Community(doc['Admin']),
                  News(doc['Admin']),
                  People(doc['Admin']),
                  Clubs(),
                ],
              );
            }),
      ),
    );
  }
}
