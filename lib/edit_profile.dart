import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  static const routeName = '/edit_profile';
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(title: Text('Edit Profile'),),
          body: Center(
        child: Text("Soon...."),
      ),
    );
  }
}