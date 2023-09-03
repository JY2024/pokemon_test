import 'package:flutter/material.dart';

class MyBoy extends StatelessWidget { // "stl" as shortcut for stateless widget creation
  int boySpriteCount; // 0 for standing, 1-2 for walking
  String direction;
  String location;
  double height = 20;

  MyBoy({required this.boySpriteCount, required this.direction, required this.location});

  @override
  Widget build(BuildContext context) {
    if (location == 'littleroot') {
      height = 20;
    } else if (location == 'pokelab') {
      height = 30;
    } else if (location == 'battleground' || location == 'attackoptions' || location == 'battlefinishedscreen') {
      height = 0;
    }

    return Container(
      height: height,
      child: Image.asset(
        // 'lib/images/boy' + direction + boySpriteCount.toString() + '.png',
        'lib/images/boy.png',
        fit: BoxFit.cover,
      )
    );
  }
}