import 'package:flutter/material.dart';

class PeopleFilter extends StatefulWidget {
  Function(
    int _showing1,
    int _showing2,
  ) _run;
  Function()_remove;
  PeopleFilter(this._run,this._remove);
  @override
  _PeopleFilterState createState() => _PeopleFilterState();
}

class _PeopleFilterState extends State<PeopleFilter> {
  _applyFilter() {
    widget._run(_showing, _showing2);
  }
  _remove(){
    setState(() {
      _showing =0;
      _showing2 =0;
    });
    widget._remove();
  }

  int _showing = 0;
  int _showing2 = 0;
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.40,
          height: MediaQuery.of(context).size.height * 0.06,
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
      Container(
        width: MediaQuery.of(context).size.width * 0.34,
        height: MediaQuery.of(context).size.height * 0.06,
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
                  child: Text('2nd'),
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
      Container(
        width: MediaQuery.of(context).size.width * 0.09,
        child: IconButton(
          icon: Icon(Icons.arrow_forward),
          splashRadius: 28,
          iconSize: 24,
          tooltip: 'Apply',
          onPressed: _applyFilter,
        ),
      ),
      Container(
        width: MediaQuery.of(context).size.width * 0.09,
        child: IconButton(
          icon: Icon(Icons.remove),
          splashRadius: 28,
          iconSize: 24,
          tooltip: 'Remove',
          onPressed: _remove,
        ),
      )
    ]);
  }
}
