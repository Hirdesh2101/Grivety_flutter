import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import './peoplefilter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import './custom_dailog.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';

class People extends StatefulWidget {
  final String admin;
  People(this.admin);
  @override
  _PeopleState createState() => _PeopleState();
}

class _PeopleState extends State<People> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  String? _branch;
  String? _year;
  bool _isVisible = false;
  void _run(int _showing1, int _showing2) {
    switch (_showing1) {
      case 1:
        _branch = 'Computer Science';
        break;
      case 2:
        _branch = 'Electronics and Communication';
        break;
      case 3:
        _branch = 'Electrical';
        break;
      case 4:
        _branch = 'Mechanical';
        break;
      case 5:
        _branch = 'Chemical';
        break;
      case 6:
        _branch = 'Civil';
        break;
      case 7:
        _branch = 'Metallurgy';
        break;
      case 8:
        _branch = 'Architecture';
        break;
    }
    switch (_showing2) {
      case 1:
        _year = '1st';
        break;
      case 2:
        _year = '2nd';
        break;
      case 3:
        _year = '3rd';
        break;
      case 4:
        _year = '4th';
        break;
      case 5:
        _year = '5th';
        break;
    }
    if (_showing1 != 0 && _showing2 != 0) {
      setState(() {
        _isVisible = true;
      });
    } else {
      Fluttertoast.showToast(
          msg: "Please Select Filters",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          // backgroundColor: Colors.red,
          // textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  void _remove() {
    setState(() {
      _isVisible = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Stack(children: [
        Column(
          children: [
            PeopleFilter(_run, _remove),
            if (_isVisible)
              FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('Users')
                      .where('Branch', isEqualTo: _branch)
                      .where("Year", isEqualTo: _year)
                      .get(),
                  builder: (_, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: ProfileShimmer(
                          padding: EdgeInsets.all(2.0),
                        ),
                      );
                    }
                    final documents = snapshot.data!.docs;
                    return Expanded(
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (_, int index) {
                          return ListTile(
                              trailing: widget.admin == 'Super'
                                  ? documents[index].data()['Admin'] == 'Super'
                                      ? SizedBox(width: 0, height: 0)
                                      : PopupMenuButton(
                                          itemBuilder: (BuildContext context) {
                                            return <PopupMenuEntry>[
                                              PopupMenuItem(
                                                child: documents[index]
                                                            .data()['Admin'] ==
                                                        'Yes'
                                                    ? Text('Remove Admin')
                                                    : Text('Make Admin'),
                                                value: 1,
                                              ),
                                            ];
                                          },
                                          onSelected: (value) {
                                            if (value == 1) {
                                              dynamic docu =
                                                  documents[index].id;
                                              if (documents[index]
                                                      .data()['Admin'] ==
                                                  'Yes') {
                                                FirebaseFirestore.instance
                                                    .collection('Users')
                                                    .doc(docu)
                                                    .update({'Admin': 'NO'});
                                              } else if (documents[index]
                                                      .data()['Admin'] ==
                                                  'NO') {
                                                FirebaseFirestore.instance
                                                    .collection('Users')
                                                    .doc(docu)
                                                    .update({'Admin': 'Yes'});
                                              }
                                              Fluttertoast.showToast(
                                                  msg: "Please Refresh",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 1,
                                                  fontSize: 16.0);
                                            }
                                          },
                                        )
                                  : SizedBox(width: 0, height: 0),
                              key: Key(index.toString()),
                              leading: (documents[index].data()['Image'] ==
                                          'Male' ||
                                      documents[index].data()['Image'] ==
                                          'Female')
                                  ? documents[index].data()['Image'] == 'Male'
                                      ? const CircleAvatar(
                                          radius: 23,
                                          backgroundImage:
                                              AssetImage("assests/male.jpg"))
                                      : const CircleAvatar(
                                          radius: 23,
                                          backgroundImage:
                                              AssetImage("assests/female.jpg"))
                                  : ClipOval(
                                      child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl:
                                            documents[index].data()['Image'],
                                        height: 40,
                                        width: 40,
                                        placeholder: (context, url) =>
                                            const CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                    ),
                              title: Text(documents[index].data()['Name']),
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return CustomDialogBox(
                                        title: documents[index].data()['Name'],
                                        img: documents[index].data()['Image'],
                                        text: 'Close',
                                        descriptions: documents[index]
                                                    .data()['Description'] ==
                                                null
                                            ? "No Description"
                                            : documents[index]
                                                .data()['Description'],
                                        branch:
                                            documents[index].data()['Branch'],
                                      );
                                    });
                              });
                        },
                        itemCount: documents.length,
                      ),
                    );
                  })
          ],
        ),
        if (!_isVisible)
          Align(alignment: Alignment.center, child: Text("Select Filters..."))
      ]),
    );
  }
}
