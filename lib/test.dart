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
                                Container(
                                    width: 90,
                                    height: 90,
                                    decoration: new BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: new DecorationImage(
                                          fit: BoxFit.fill,
                                          image: (snapshot.data
                                                          .data()['Image'] ==
                                                      'Male' ||
                                                  snapshot.data
                                                          .data()['Image'] ==
                                                      'Female')
                                              ? snapshot.data.data()['Image'] ==
                                                      'Male'
                                                  ? AssetImage(
                                                      "assests/male.jpg")
                                                  : AssetImage(
                                                      "assests/female.jpg")
                                              : NetworkImage(
                                                  snapshot.data.data()['Image'],
                                                ),
                                        ))),
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
                        onTap: ()=>Navigator.of(context).pushNamed(EditProfile.routeName),
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
                        onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CustomDialogBox(
                                    title: 'Grivety',
                                    img: 'https://firebasestorage.googleapis.com/v0/b/grivety-flutter.appspot.com/o/finalgrivitylogo.png?alt=media&token=a46ae3b8-25ae-447d-a175-be143df6200e',
                                    text: 'Close',
                                    descriptions: "App developed by Hirdesh Garg 2nd Year Chemical Engineering",
                                    branch: '',
                                  );
                                });
                          }
                      ),
                    ],
                  );
                }),
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
