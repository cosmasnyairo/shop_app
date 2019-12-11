import 'dart:math';

import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Color.fromRGBO(0, 114, 100, 1).withOpacity(0.9),
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [0, 1],
          ),
        ),
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 350),
              Icon(Icons.event_seat, size: 40,),
              Transform.rotate(
                angle: 180 * pi / 180,
                child: Icon(Icons.event_seat, size: 40),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
