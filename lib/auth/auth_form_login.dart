import 'package:flutter/material.dart';
import './register.dart';

class AuthFormLogin extends StatefulWidget {
  AuthFormLogin(
    this.submitFn,
    this.isLoading,
  );

  final bool isLoading;
  final void Function(
    String email,
    String password,
    String userName,
    BuildContext ctx,
  ) submitFn;

  @override
  _AuthFormLoginState createState() => _AuthFormLoginState();
}

class _AuthFormLoginState extends State<AuthFormLogin> {
  final _formKey = GlobalKey<FormState>();
  var _userEmail = '';
  var _userName = '';
  var _userPassword = '';

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState.save();
      widget.submitFn(
          _userEmail.trim(), _userPassword.trim(), _userName.trim(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Card(
          margin: EdgeInsets.all(20),
          elevation: 10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextFormField(
                      enabled: widget.isLoading ? false : true,
                      key: ValueKey('email'),
                      validator: (value) {
                        if (value.isEmpty || !value.contains('@')) {
                          return 'Please enter a valid email address.';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email address',
                      ),
                      onSaved: (value) {
                        _userEmail = value;
                      },
                    ),
                    TextFormField(
                      enabled: widget.isLoading ? false : true,
                      key: ValueKey('password'),
                      validator: (value) {
                        if (value.isEmpty || value.length < 7) {
                          return 'Password must be at least 7 characters long.';
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: 'Password'),
                      obscureText: true,
                      onSaved: (value) {
                        _userPassword = value;
                      },
                    ),
                    SizedBox(height: 5),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                        GestureDetector(
                          child:Text('Forgot Password ?',style: TextStyle(fontSize:12),),
                          onTap:(){}
                        )
                      ],),
                    SizedBox(height: 10),
                    if (widget.isLoading) CircularProgressIndicator(),
                    if (!widget.isLoading)
                      Container(
                        width: MediaQuery.of(context).size.width*0.55,
                        child: RaisedButton(
                          color: Color.fromARGB(255, 0, 171, 227),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: _trySubmit,
                        ),
                      ),
                      SizedBox(height:5),
                    Center(
                      child: GestureDetector(
                          onTap: () => Navigator.of(context)
                              .pushNamed(Register.routeName),
                          child: Text('New User? Register Here',style: TextStyle(fontSize:12),)),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
