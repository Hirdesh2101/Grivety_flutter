import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import './auth_form_register.dart';
import './addImage.dart';

class Register extends StatefulWidget {
  static const routeName = '/register_screen';
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _submitAuthForm(
    String email,
    String password,
    String username,
    String gender,
    String branch,
    String year,
    BuildContext ctx,
  ) async {
    //UserCredential authResult;

    try {
      setState(() {
        _isLoading = true;
      });
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = FirebaseAuth.instance.currentUser;

      FirebaseFirestore.instance.collection('Users').doc(user!.uid).set({
        'Name': username,
        'Image': gender,
        'Email': email,
        'Year': year,
        'Branch': branch,
        'Admin': 'NO',
      });
      Navigator.of(context).pushReplacementNamed(AddImage.routeName);
    } on PlatformException catch (err) {
      var message = 'An error occurred, pelase check your credentials!';

      if (err.message != null) {
        message = err.message!;
      }

      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      print(err);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(
        _submitAuthForm,
        _isLoading,
      ),
    );
  }
}
