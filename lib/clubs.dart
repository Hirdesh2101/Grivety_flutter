import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Clubs extends StatefulWidget {
  @override
  _ClubsState createState() => _ClubsState();
}

class _ClubsState extends State<Clubs> {
  int _index = 0;
  int _index2 = 0;
  List<Map<String, String>> clubsfilter = [];
  List<Map<String, String>> clubs = [
    {
      'name': 'CACS',
      'type': 'Welfare',
      'link': 'https://instagram.com/cacs_mnit?igshid=1jqj65rjc8o1y',
      'desc': 'Caltural Arts And Creative Society.',
      'img': 'assests/cacs.jpeg'
    },
    {
      'name': 'SMP',
      'type': 'Welfare',
      'link': 'https://instagram.com/smp.mnit?igshid=1hlen53c0r42r',
      'desc': 'Student Mentership Programme.',
      'img': 'assests/smp.jpeg'
    },
    {
      'name': 'CODESHOWS',
      'type': 'Technical',
      'link':'https://instagram.com/technicalsociety_mnit?igshid=1o6v993owy5a0',
      'desc': 'Technical Club Of Mnit Jaipur.',
      'img': 'assests/ts.jpeg'
    },
    {
      'name': 'TECHNICAL SOCIETY',
      'type': 'Technical',
      'link':'https://instagram.com/technicalsociety_mnit?igshid=1o6v993owy5a0',
      'desc': 'Technical Society Of Mnit Jaipur.',
      'img': 'assests/ts.jpeg'
    },
    {
      'name': 'ZINE',
      'type': 'Technical',
      'link': 'https://instagram.com/zine.robotics?igshid=18fib1kz0vvkd',
      'desc': 'Robotics Club Of Mnit Jaipur.',
      'img': 'assests/zine.jpeg'
    },
    {
      'name': 'EDCELL',
      'type': 'Personal Development',
      'link': 'https://instagram.com/edcmnitj?igshid=15lob4ql9jitm',
      'desc': 'Entrepreneurship Develpoment Club Of Mnit Jaipur.',
      'img': 'assests/edcell.jpeg'
    },
    {
      'name': 'SAE',
      'type': 'Personal Development',
      'link': 'https://instagram.com/sae_mnit_jaipur?igshid=1jdkci311owof',
      'desc': 'Technical Club Of Mnit Jaipur.',
      'img': 'assests/sae.jpeg'
    },
    {
      'name': 'MDS',
      'type': 'Cultural',
      'link': 'https://instagram.com/mdsmnitjaipur?igshid=1fvomzby7ymei',
      'desc': 'Music and Dance Society Of Mnit Jaipur.',
      'img': 'assests/mds.jpeg'
    },
    {
      'name': 'MC2',
      'type': 'Cultural',
      'link': 'https://instagram.com/mc2_officialpage?igshid=1272kdu899jd8',
      'desc': 'Dance Club Of Mnit Jaipur.',
      'img': 'assests/mc2.jpeg'
    },
    {
      'name': 'DIL',
      'type': 'Cultural',
      'link': 'https://instagram.com/dil.dramsoc?igshid=ytefldo3k5rq',
      'desc': 'Drama Club Of Mnit Jaipur.',
      'img': 'assests/dil.jpeg'
    },
    {
      'name': 'FILM AND PHOTOGRAPHY',
      'type': 'Cultural',
      'link': 'https://instagram.com/fandp_club?igshid=zxv1rkjnu7sq',
      'desc': 'Film And Photography Club Of Mnit Jaipur.',
      'img': 'assests/fndp.jpeg'
    },
    {
      'name': 'LEVEL X',
      'type': 'Cultural',
      'link': 'https://instagram.com/l.e.v.e.l_x?igshid=15brjioe83wq0',
      'desc': 'Dance Club Of Mnit Jaipur.',
      'img': 'assests/mds.jpeg'
    },
    {
      'name': 'ALCOM',
      'type': 'Welfare',
      'link': 'https://instagram.com/alcom_mnit?igshid=1abhc6jfpumph',
      'desc': 'Alumni Club Of Mnit Jaipur.',
      'img': 'assests/alcom.jpeg'
    },
    {
      'name': 'NSS',
      'type': 'Welfare',
      'link': 'https://instagram.com/nssmnit?igshid=1az25jhr0wpfe',
      'desc': 'Society Welfare Club Of Mnit Jaipur.',
      'img': 'assests/nss.jpeg'
    },
    {
      'name': 'UBA',
      'type': 'Welfare',
      'link': 'https://instagram.com/ubamnit?igshid=17ajxffo6ndaa',
      'desc': 'Society Welfare Club Of Mnit Jaipur.',
      'img': 'assests/uba.jpeg'
    },
    {
      'name': 'VSS',
      'type': 'Welfare',
      'link': 'https://instagram.com/vssmnit?igshid=6qz6ljwaaaos',
      'desc': 'Society Welfare Club Of Mnit Jaipur.',
      'img': 'assests/vss.jpeg'
    },
    {
      'name': 'HOPE',
      'type': 'Welfare',
      'link': 'https://instagram.com/hope.everywhere?igshid=11ygw33m5mw1p',
      'desc': 'Society Welfare Club Of Mnit Jaipur.',
      'img': 'assests/hope.jpeg'
    },
    {
      'name': 'ENERGY CLUB',
      'type': 'Welfare',
      'link': 'https://instagram.com/the_energy_club?igshid=q9yvdq3hv0um',
      'desc': 'Educational Club Of Mnit Jaipur.',
      'img': 'assests/energy.jpeg'
    },
    {
      'name': 'ROTRACT',
      'type': 'Welfare',
      'link': 'https://instagram.com/mnit_rotaract_club?igshid=covnq4lg2iel',
      'desc': 'Society Welfare Club Of Mnit Jaipur.',
      'img': 'assests/rotr.jpeg'
    },
    {
      'name': 'THINK INDIA',
      'type': 'Welfare',
      'link': 'https://instagram.com/thinkindiamnit?igshid=12hp7w6d1depr',
      'desc': 'Society Welfare Club Of Mnit Jaipur.',
      'img': 'assests/think.jpeg'
    },
    {
      'name': 'MAVERICS',
      'type': 'Personal Development',
      'link': 'https://instagram.com/mavericks.mnit?igshid=479fvivnrr7y',
      'desc': 'Language Club Of Mnit Jaipur.',
      'img': 'assests/mav.jpeg'
    },
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
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          insetAnimationCurve: Curves.easeIn,
                          insetAnimationDuration: Duration(milliseconds: 500),
                          child: Wrap(children: [
                            Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Image.asset(
                                        '${x1[index]['img']}',
                                       height: MediaQuery.of(context).size.height * 0.15,
                            width: MediaQuery.of(context).size.width * 0.38,
                                      ),
                                      Column(
                                        children: [
                                          Text('Type:'),
                                          Text('${x1[index]['type']}'),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    '${x1[index]['name']}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text('${x1[index]['desc']}'),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.45,
                                    child: RaisedButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      onPressed: () {},
                                      child: Text('More Coming Soon..'),
                                      color: Colors.black38,
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.45,
                                    child: RaisedButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        onPressed: () async {
                                          final url = '${x1[index]['link']}';
                                          if (await canLaunch(url)) {
                                            await launch(url);
                                          } else {
                                            Fluttertoast.showToast(
                                                msg: "Could Not Open Handel",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                // backgroundColor: Colors.red,
                                                // textColor: Colors.white,
                                                fontSize: 16.0);
                                          }
                                        },
                                        child: Text('Social Handel'),
                                        color: Color.fromARGB(255, 54, 59, 63)),
                                  ),
                                ],
                              ),
                            ),
                          ]));
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.asset(
                            '${x1[index]['img']}',
                            height: MediaQuery.of(context).size.height * 0.15,
                            width: MediaQuery.of(context).size.width * 0.38,
                          ),
                          SizedBox(height: 10,),
                          Text('${x1[index]['name']}',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                              )),
                        ],
                      ),
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
          Align(
            alignment: Alignment.center,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.35,
              child: PageView.builder(
                  itemCount: clubsfilter.length == 0
                      ? clubs.length
                      : clubsfilter.length,
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
            ),
          ),
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
                    Column(
                      children: [
                        IconButton(
                            iconSize: 24,
                            //splashRadius: 15,
                            icon: Icon(Icons.all_inclusive),
                            onPressed: () {
                              setState(() {
                                pageController.jumpToPage(0);
                                _index = 0;
                                _index2 = 0;
                                clubsfilter.clear();
                              });
                            }),
                        _index2 == 0
                            ? Text('All')
                            : SizedBox(
                                height: 0,
                                width: 0,
                              )
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                            iconSize: 24,
                            //splashRadius: 15,
                            icon: Icon(Icons.music_note),
                            onPressed: () {
                              setState(() {
                                pageController.jumpToPage(0);
                                _index = 0;
                                _index2 = 1;
                                clubsfilter.clear();
                                clubsfilter = clubs
                                    .where((element) =>
                                        element['type'] == 'Cultural')
                                    .toList();
                              });
                            }),
                        _index2 == 1
                            ? Text('Cultural')
                            : SizedBox(
                                height: 0,
                                width: 0,
                              )
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                            iconSize: 24,
                            icon: Icon(Icons.computer),
                            onPressed: () {
                              clubsfilter.clear();
                              setState(() {
                                pageController.jumpToPage(0);
                                _index = 0;
                                _index2 = 2;
                                clubsfilter = clubs
                                    .where((element) =>
                                        element['type'] == 'Technical')
                                    .toList();
                              });
                            }),
                        _index2 == 2
                            ? Text('Technical')
                            : SizedBox(
                                height: 0,
                                width: 0,
                              )
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                            iconSize: 24,
                            icon: Icon(Icons.favorite),
                            onPressed: () {
                              clubsfilter.clear();
                              setState(() {
                                pageController.jumpToPage(0);
                                _index = 0;
                                _index2 = 3;
                                clubsfilter = clubs
                                    .where((element) =>
                                        element['type'] == 'Welfare')
                                    .toList();
                              });
                            }),
                        _index2 == 3
                            ? Text('Welfare')
                            : SizedBox(
                                height: 0,
                                width: 0,
                              )
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                            iconSize: 24,
                            icon: Icon(Icons.trending_up),
                            onPressed: () {
                              clubsfilter.clear();
                              setState(() {
                                pageController.jumpToPage(0);
                                _index = 0;
                                _index2 = 4;
                                clubsfilter = clubs
                                    .where((element) =>
                                        element['type'] ==
                                        'Personal Development')
                                    .toList();
                              });
                            }),
                        _index2 == 4
                            ? Text('P.D.')
                            : SizedBox(
                                height: 0,
                                width: 0,
                              )
                      ],
                    )
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
