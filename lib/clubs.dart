import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Clubs extends StatefulWidget {
  @override
  _ClubsState createState() => _ClubsState();
}

class _ClubsState extends State<Clubs> {
  int _index = 0;
  List<Map<String, String>> clubsfilter = [];
  List<Map<String, String>> clubs = [
    {
      'name': 'CACS',
      'type': 'Welfare',
      'link': 'https://instagram.com/cacs_mnit?igshid=1jqj65rjc8o1y'
    },
    {
      'name': 'SMP',
      'type': 'Welfare',
      'link': 'https://instagram.com/smp.mnit?igshid=1hlen53c0r42r'
    },
    {
      'name': 'CODESHOWS',
      'type': 'Technical',
      'link': 'https://instagram.com/cacs_mnit?igshid=1jqj65rjc8o1y'
    },
    {
      'name': 'TECHNICAL SOCIETY',
      'type': 'Technical',
      'link': 'https://instagram.com/cacs_mnit?igshid=1jqj65rjc8o1y'
    },
    {
      'name': 'ZINE',
      'type': 'Technical',
      'link': 'https://instagram.com/zine.robotics?igshid=18fib1kz0vvkd'
    },
    {
      'name': 'EDCELL',
      'type': 'Personal Development',
      'link': 'https://instagram.com/edcmnitj?igshid=15lob4ql9jitm'
    },
    {
      'name': 'SAE',
      'type': 'Personal Development',
      'link': 'https://instagram.com/sae_mnit_jaipur?igshid=1jdkci311owof'
    },
    {
      'name': 'MDS',
      'type': 'Cultural',
      'link': 'https://instagram.com/mdsmnitjaipur?igshid=1fvomzby7ymei'
    },
    {
      'name': 'MC2',
      'type': 'Cultural',
      'link': 'https://instagram.com/mc2_officialpage?igshid=1272kdu899jd8'
    },
    {
      'name': 'DIL',
      'type': 'Cultural',
      'link': 'https://instagram.com/dil.dramsoc?igshid=ytefldo3k5rq'
    },
    {
      'name': 'FILM AND PHOTOGRAPHY',
      'type': 'Cultural',
      'link': 'https://instagram.com/fandp_club?igshid=zxv1rkjnu7sq'
    },
    {
      'name': 'LEVEL X',
      'type': 'Cultural',
      'link': 'https://instagram.com/l.e.v.e.l_x?igshid=15brjioe83wq0'
    },
    {
      'name': 'ALCOM',
      'type': 'Welfare',
      'link': 'https://instagram.com/alcom_mnit?igshid=1abhc6jfpumph'
    },
    {
      'name': 'NSS',
      'type': 'Welfare',
      'link': 'https://instagram.com/nssmnit?igshid=1az25jhr0wpfe'
    },
    {
      'name': 'UBA',
      'type': 'Welfare',
      'link': 'https://instagram.com/ubamnit?igshid=17ajxffo6ndaa'
    },
    {
      'name': 'VSS',
      'type': 'Welfare',
      'link': 'https://instagram.com/vssmnit?igshid=6qz6ljwaaaos'
    },
    {
      'name': 'HOPE',
      'type': 'Welfare',
      'link': 'https://instagram.com/hope.everywhere?igshid=11ygw33m5mw1p'
    },
    {
      'name': 'ENERGY CLUB',
      'type': 'Welfare',
      'link': 'https://instagram.com/the_energy_club?igshid=q9yvdq3hv0um'
    },
    {
      'name': 'ROTRACT',
      'type': 'Welfare',
      'link': 'https://instagram.com/mnit_rotaract_club?igshid=covnq4lg2iel'
    },
    {
      'name': 'THINK INDIA',
      'type': 'Welfare',
      'link': 'https://instagram.com/thinkindiamnit?igshid=12hp7w6d1depr'
    },
    {
      'name': 'MAVERICS',
      'type': 'Personal Development',
      'link': 'https://instagram.com/mavericks.mnit?igshid=479fvivnrr7y'
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
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          insetAnimationCurve: Curves.easeIn,
                          insetAnimationDuration: Duration(milliseconds: 500),
                          child: Wrap(children: [
                            Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                   Image.asset('assests/logo1.png',width: 40,height: 50,),
                                    Column(
                                      children: [
                                        Text('Type:'),
                                        Text('${x1[index]['type']}'),
                                      ],
                                    ),
                                  ],),
                                  SizedBox(height: 5,),
                                  Text('${x1[index]['name']}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                  SizedBox(height: 5,),
                                  Text('Descrpition'),
                                  SizedBox(height: 8,),
                                  Container(
                                    width: MediaQuery.of(context).size.width*0.45,
                                    child: RaisedButton(
                                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                      onPressed: (){},
                                    child: Text('More Information'),
                                    color: Colors.black38,
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width*0.45,
                                    child: RaisedButton(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                        //splashRadius: 15,
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
                        //splashRadius: 15,
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
