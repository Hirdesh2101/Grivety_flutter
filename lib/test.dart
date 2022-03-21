import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:google_fonts/google_fonts.dart';
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
    var user = FirebaseAuth.instance.currentUser!.uid;
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
                builder: (context, AsyncSnapshot snapshot) {
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
                                (snapshot.data!.data()['Image'] == 'Male' ||
                                        snapshot.data!.data()['Image'] ==
                                            'Female')
                                    ? snapshot.data!.data()['Image'] == 'Male'
                                        ? const CircleAvatar(
                                            radius: 40,
                                            backgroundImage:
                                                AssetImage("assests/male.jpg"))
                                        : const CircleAvatar(
                                            radius: 40,
                                            backgroundImage: AssetImage(
                                                "assests/female.jpg"))
                                    : ClipOval(
                                        child: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          imageUrl:
                                              snapshot.data!.data()['Image'],
                                          height: 40,
                                          width: 40,
                                          placeholder: (context, url) =>
                                              const CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        ),
                                      ),
                                SizedBox(height: 10),
                                Text('Welcome'),
                                Text(snapshot.data!.data()['Name']),
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
                                    title: snapshot.data!.data()['Name'],
                                    img: snapshot.data!.data()['Image'],
                                    text: 'Close',
                                    descriptions: snapshot.data!
                                                .data()['Description'] ==
                                            null
                                        ? "No Description"
                                        : snapshot.data!.data()['Description'],
                                    branch: snapshot.data!.data()['Branch'],
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
                                        "App developed by Hirdesh Garg ",
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
          title: Text(
            'Grivety',
            style: GoogleFonts.getFont('Hurricane',
                textStyle: const TextStyle(
                  fontSize: 28,
                  //fontWeight: FontWeight.bold,
                  letterSpacing: 3.0,
                )),
          ),
          bottom: TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: "Community"),
              Tab(text: "Alerts"),
              Tab(text: "People"),
              Tab(text: "Clubs")
            ],
          ),
        ),
        body: FutureBuilder(
            future:
                FirebaseFirestore.instance.collection('Users').doc(user).get(),
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              var doc = snapshot.data;
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              return TabBarView(
                children: [
                  Community(doc!['Admin']),
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
