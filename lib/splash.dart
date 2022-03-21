import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Splash extends StatelessWidget {
  static const routeName = '/Splash';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(
                'assests/logo2.png',
                height: 150,
                width: 150,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Grivety',
                style: GoogleFonts.getFont('Hurricane',
                    textStyle: const TextStyle(
                      fontSize: 28,
                      //fontWeight: FontWeight.bold,
                      letterSpacing: 3.0,
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
