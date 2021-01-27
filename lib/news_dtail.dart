import 'package:flutter/material.dart';
import './quest_pass.dart';

class NewsDetail extends StatelessWidget {
  static const routeName = '/NewsDetail';
  @override
  Widget build(BuildContext context) {
    final Details args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
          //dragStartBehavior: DragStartBehavior.down,
              child: Container(
                //margin: MediaQuery.of(context).padding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
              
                     Center(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          args.documents[args.index].data()['Title'],
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize:18),
                          
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                    SizedBox(height:5),
                    Hero(tag: args.documents[args.index].data()['Image'],
                                          child: Align(
                          alignment: Alignment.center,
                          child: FadeInImage(
                            placeholder: AssetImage('assests/loading.png'),
                            image: NetworkImage(
                              args.documents[args.index].data()['Image'],
                            ),
                            height: MediaQuery.of(context).size.height * 0.25,
                            width: MediaQuery.of(context).size.width,
                          )),
                    ),
                   
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        args.documents[args.index].data()['Data'],
                        style: TextStyle(),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}