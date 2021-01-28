import 'package:flutter/material.dart';
//import 'package:scroll_snap_list/scroll_snap_list.dart';

class Clubs extends StatefulWidget {
  @override
  _ClubsState createState() => _ClubsState();
}

class _ClubsState extends State<Clubs> {
  int _index = 0;
  List<Map<String, String>> clubsfilter = [];
  List<Map<String, String>> clubs = [
    {'name': 'CACS', 'type': 'Welfare'},
    {'name': 'SMP', 'type': 'Welfare'},
    {'name': 'CODESHOWS', 'type': 'Technical'},
    {'name': 'TECHNICAL SOCIETY', 'type': 'Technical'},
    {'name': 'ZINE', 'type': 'Technical'},
    {'name': 'EDCELL', 'type': 'Personal Development'},
    {'name': 'SAE', 'type': 'Personal Development'},
    {'name': 'MDS', 'type': 'Cultural'},
    {'name': 'MC2', 'type': 'Cultural'},
    {'name': 'DIL', 'type': 'Cultural'},
    {'name': 'FILM AND PHOTOGRAPHY', 'type': 'Cultural'},
    {'name': 'LEVEL X', 'type': 'Cultural'},
    {'name': 'ALCOM', 'type': 'Welfare'},
    {'name': 'NSS', 'type': 'Welfare'},
    {'name': 'UBA', 'type': 'Welfare'},
    {'name': 'VSS', 'type': 'Welfare'},
    {'name': 'HOPE', 'type': 'Welfare'},
    {'name': 'ENERGY CLUB', 'type': 'Welfare'},
    {'name': 'ROTRACT', 'type': 'Welfare'},
    {'name': 'THINK INDIA', 'type': 'Welfare'},
    {'name': 'MAVERICS', 'type': 'Personal Development'},
  ];
  Widget _buildListItem(
      BuildContext context, int index, List<Map<String, String>> x1) {
    return Container(
      //width: MediaQuery.of(context).size.height * 0.50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Card(
            elevation: 15,
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext ctx) {
                      return Dialog(
                          //decoration: BoxDecoration(color: Colors.blue),
                          insetAnimationCurve: Curves.easeIn,
                          insetAnimationDuration: Duration(milliseconds: 500),
                          child: Text('${x1[index]['name']}'));
                    });
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 54, 59, 63),
                    //border: Border.all(color: Colors.lightBlueAccent),
                    borderRadius: BorderRadius.circular(20)),
                height: MediaQuery.of(context).size.height * 0.30,
                width: MediaQuery.of(context).size.width * 0.48,
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text('${x1[index]['name']}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                          )),
                    )),
              ),
            ),
          )
        ],
      ),
    );
  }

  PageController pageController =
      PageController(initialPage: 0, viewportFraction: 0.65);
  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
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
                      clubsfilter.length != 0
                          ? '${clubsfilter[_index]['name']}'
                          : '${clubs[_index]['name']}',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: Colors.white38),
                    )),
              ),
            ),
          ),
          PageView.builder(
              itemCount:
                  clubsfilter.length == 0 ? clubs.length : clubsfilter.length,
              controller: pageController,
              onPageChanged: (int index) => setState(() => _index = index),
              itemBuilder: (_, i) {
                return Transform.scale(
                    scale: i == _index
                        ? Curves.easeIn.transform(1)
                        : Curves.easeOut.transform(0.85),
                    child: clubsfilter.length == 0
                        ? _buildListItem(context, i, clubs)
                        : _buildListItem(context, i, clubsfilter));
              }),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Browse',
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        color: Colors.white70)),
                Text('Clubs',
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        color: Colors.white70)),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        iconSize: 24,
                        splashRadius: 15,
                        icon: Icon(Icons.all_inclusive),
                        onPressed: () {
                          setState(() {
                            pageController.jumpToPage(0);
                            _index = 0;
                            clubsfilter.clear();
                          });
                        }),
                    IconButton(
                        iconSize: 24,
                        splashRadius: 15,
                        icon: Icon(Icons.music_note),
                        onPressed: () {
                          setState(() {
                            pageController.jumpToPage(0);
                            _index = 0;
                            clubsfilter.clear();
                            clubsfilter = clubs
                                .where(
                                    (element) => element['type'] == 'Cultural')
                                .toList();
                          });
                        }),
                    IconButton(
                        iconSize: 24,
                        icon: Icon(Icons.computer),
                        onPressed: () {
                          clubsfilter.clear();
                          setState(() {
                            pageController.jumpToPage(0);
                            _index = 0;
                            clubsfilter = clubs
                                .where(
                                    (element) => element['type'] == 'Technical')
                                .toList();
                          });
                        }),
                    IconButton(
                        iconSize: 24,
                        icon: Icon(Icons.favorite),
                        onPressed: () {
                          clubsfilter.clear();
                          setState(() {
                            pageController.jumpToPage(0);
                            _index = 0;
                            clubsfilter = clubs
                                .where(
                                    (element) => element['type'] == 'Welfare')
                                .toList();
                          });
                        }),
                    IconButton(
                        iconSize: 24,
                        icon: Icon(Icons.trending_up),
                        onPressed: () {
                          clubsfilter.clear();
                          setState(() {
                            pageController.jumpToPage(0);
                            _index = 0;
                            clubsfilter = clubs
                                .where((element) =>
                                    element['type'] == 'Personal Development')
                                .toList();
                          });
                        })
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
