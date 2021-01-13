import 'package:flutter/material.dart';
import './peoplefilter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class People extends StatefulWidget {
  @override
  _PeopleState createState() => _PeopleState();
}

class _PeopleState extends State<People> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  String _branch;
  String _year;
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

  void _remove(){
    setState(() {
        _isVisible = false;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          PeopleFilter(_run,_remove),
          if (_isVisible)
            FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('Users')
                    .where('Branch', isEqualTo: _branch)
                    .where("Year", isEqualTo: _year)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final documents = snapshot.data.documents;
                  return Expanded(
                    child: ListView.builder(
                      itemBuilder: (_, int index) {
                        return ListTile(
                          key: Key(index.toString()),
                          leading: CircleAvatar(
                            backgroundColor: Colors.red,
                          ),
                          title: Text(documents[index].data()['Name']),
                        );
                      },
                      itemCount: documents.length,
                    ),
                  );
                })
        ],
      ),
    );
  }
}
