import 'package:flutter/material.dart';

class ProfOak extends StatelessWidget { // "stl" as shortcut for stateless widget creation
  double x;
  double y;
  String location;
  String oakDirection;

  ProfOak({required this.x, required this.y, required this.location, required this.oakDirection});

  @override
  Widget build(BuildContext context) {
    if (location == 'littleroot') {
      return Container(
        alignment: Alignment(x, y), // align children within this container
        child: Image.asset(
          // 'lib/images/boy' + direction + boySpriteCount.toString() + '.png',
          'lib/images/boy.png',
          width: MediaQuery.of(context).size.width * 0.75, // a method in the Flutter framework that allows you to access information about the dimensions and layout of a device's screen.
          // context describes the part of the user interface represented by this widget
          fit: BoxFit.cover, // BoxFit: Scales the image as large as possible while still covering the entire container and preserving the aspect ratio of the image.
        )
      );
    } else {
      return Container();
    }
  }
}