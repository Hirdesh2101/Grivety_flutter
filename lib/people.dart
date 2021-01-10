import 'package:flutter/material.dart';

class People extends StatefulWidget {
  @override
  _PeopleState createState() => _PeopleState();
}

class _PeopleState extends State<People> {
  int _showing = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: MediaQuery.of(context).size.width*0.40,
              height: MediaQuery.of(context).size.height*0.09,
              decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(25)),
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
                    child: Text('Electronics and Communication'),
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
          ),
        ],
      ),
    );
  }
}
