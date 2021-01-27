import 'package:flutter/material.dart';
//import 'package:scroll_snap_list/scroll_snap_list.dart';

class Clubs extends StatefulWidget {
  @override
  _ClubsState createState() => _ClubsState();
}

class _ClubsState extends State<Clubs> {
  int _index = 0;
  List<Map<String, String>> clubs = [
    {'name': 'Codeshows', 'type': 'Technical'},
    {'name': 'MDS', 'type': 'Cultural'},
  ];
  Widget _buildListItem(BuildContext context, int index) {
    return Container(
      //width: MediaQuery.of(context).size.height * 0.50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Card(
            elevation: 15,
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 54, 59, 63),
                  //border: Border.all(color: Colors.lightBlueAccent),
                  borderRadius: BorderRadius.circular(20)),
              height: MediaQuery.of(context).size.height * 0.30,
              width: MediaQuery.of(context).size.width * 0.48,
              child: Align(alignment:Alignment.bottomCenter,child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text('${clubs[index]['name']}',style: TextStyle(fontSize: 20,fontWeight:FontWeight.w800,)),
              )),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Color.fromARGB(255 , 34, 39, 45),
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Container(
              decoration: BoxDecoration(
                  //color: Colors.grey,
                  color: Color.fromARGB(255, 54, 59, 63),
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(30))),
              height: MediaQuery.of(context).size.height * 0.68,
              width: MediaQuery.of(context).size.width * 0.40,
              child: Center(
                child: RotatedBox(
                    quarterTurns: 3,
                    child: Text(
                      '${clubs[_index]['name']}',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: Colors.white38),
                    )),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                Text('Browse',
                    style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w700,
                        color: Colors.white70)),
                Text('Clubs',
                    style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w700,
                        color: Colors.white70)),
              ],
            ),
          ),
          PageView.builder(
              itemCount: clubs.length,
              controller: PageController(viewportFraction: 0.65),
              onPageChanged: (int index) => setState(() => _index = index),
              itemBuilder: (_, i) {
                return Transform.scale(
                    scale: i == _index
                        ? Curves.easeIn.transform(1)
                        : Curves.easeOut.transform(0.85),
                    child: _buildListItem(context, i));
              }),
        ],
      ),
    );
  }
}
