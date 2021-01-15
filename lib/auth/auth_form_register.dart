import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthForm extends StatefulWidget {
  AuthForm(
    this.submitFn,
    this.isLoading,
  );

  final bool isLoading;
  final void Function(
    String email,
    String password,
    String userName,
    String gender,
    String branch,
    String year,
    BuildContext ctx,
  ) submitFn;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _userEmail = '';
  var _userName = '';
  var _userPassword = '';
  int _showing = 0;
  int _showing2 =0;
  var _branch ='';
  var _year ='';

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if(_showing==0){
      Fluttertoast.showToast(
          msg: "Please Select Branch",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          // backgroundColor: Colors.red,
          // textColor: Colors.white,
          fontSize: 16.0);
    }
    if(_showing2==0){
      Fluttertoast.showToast(
          msg: "Please Select Year",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          // backgroundColor: Colors.red,
          // textColor: Colors.white,
          fontSize: 16.0);
    }
    if (_gender == '') {
      Fluttertoast.showToast(
          msg: "Please Select Gender",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          // backgroundColor: Colors.red,
          // textColor: Colors.white,
          fontSize: 16.0);
    }

    if (isValid && _gender != ''&&_showing!=0 &&_showing2!=0) {
      _formKey.currentState.save();
      switch (_showing) {
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
      widget.submitFn(_userEmail.trim(), _userPassword.trim(), _userName.trim(),
          _gender.trim(),_branch.trim(),_year.trim(), context);
    }
  }

  int _radioValue = 0;
  String _gender = '';
  void _handelRadioValueChange(int value) {
    setState(() {
      _radioValue = value;
    });
    switch (_radioValue) {
      case 1:
        _gender = 'Male';
        break;
      case 2:
        _gender = 'Female';
        break;
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
                      key: ValueKey('username'),
                      validator: (value) {
                        if (value.isEmpty || value.length < 4) {
                          return 'Please enter at least 4 characters';
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: 'Username'),
                      onSaved: (value) {
                        _userName = value;
                      },
                    ),
                    SizedBox(height:10),
                    Row(
                      children: [
                        Text('Select Branch: '),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.14,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.40,
                          height: MediaQuery.of(context).size.height * 0.07,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(0)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                isExpanded: true,
                                hint: Text('Select Branch'),
                                value: _showing,
                                items: [
                                  DropdownMenuItem(
                                    child: Text('Select Branch'),
                                    value: 0,
                                  ),
                                  DropdownMenuItem(
                                    child: Text('Computer Science'),
                                    value: 1,
                                  ),
                                  DropdownMenuItem(
                                    child:
                                        Text('Electronics and Communication'),
                                    value: 2,
                                  ),
                                  DropdownMenuItem(
                                    child: Text('Electrical'),
                                    value: 3,
                                  ),
                                  DropdownMenuItem(
                                    child: Text('Mechanical'),
                                    value: 4,
                                  ),
                                  DropdownMenuItem(
                                    child: Text('Chemical'),
                                    value: 5,
                                  ),
                                  DropdownMenuItem(
                                    child: Text('Civil'),
                                    value: 6,
                                  ),
                                  DropdownMenuItem(
                                    child: Text('Metallurgy'),
                                    value: 7,
                                  ),
                                  DropdownMenuItem(
                                    child: Text('Architecture'),
                                    value: 8,
                                  ),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    _showing = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height:10),
                    Row(
                      children: [
                        Text('Select Year: '),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.185,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.40,
                          height: MediaQuery.of(context).size.height * 0.07,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(0)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                isExpanded: true,
                                hint: Text('Select Year'),
                                value: _showing2,
                                items: [
                                  DropdownMenuItem(
                                    child: Text('Select Year'),
                                    value: 0,
                                  ),
                                  DropdownMenuItem(
                                    child: Text('1st'),
                                    value: 1,
                                  ),
                                  DropdownMenuItem(
                                    child:
                                        Text('2nd'),
                                    value: 2,
                                  ),
                                  DropdownMenuItem(
                                    child: Text('3rd'),
                                    value: 3,
                                  ),
                                  DropdownMenuItem(
                                    child: Text('4th'),
                                    value: 4,
                                  ),
                                  DropdownMenuItem(
                                    child: Text('5th'),
                                    value: 5,
                                  ),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    _showing2 = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
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
                    Row(
                      children: [
                        Text('Gender: '),
                        new Radio(
                          value: 1,
                          groupValue: _radioValue,
                          onChanged: _handelRadioValueChange,
                        ),
                        Text('Male'),
                        new Radio(
                          value: 2,
                          groupValue: _radioValue,
                          onChanged: _handelRadioValueChange,
                        ),
                        Text('Female'),
                      ],
                    ),
                    SizedBox(height: 12),
                    if (widget.isLoading) CircularProgressIndicator(),
                    if (!widget.isLoading)
                      RaisedButton(
                        color: Color.fromARGB(255, 0, 171, 227),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          'Signup',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: _trySubmit,
                      ),
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
