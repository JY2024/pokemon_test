import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pokemon_test/maps/pokelab.dart';

import 'button.dart';
import 'characters/boy.dart';
import 'characters/oak.dart';
import 'maps/littleroot.dart';

void main() {
  runApp(MyApp()); // function that initializes the app using the widget MyApp
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // variables

  double mapX = 1.125;
  double mapY = 0.65;
  double step = 0.25;
  String currentLocation = 'littleroot';

  int boySpriteCount = 0; // 0 for standing, 1-2 for walking
  String boyDirection = 'Down';

  // no mans land for littleroot
  List<List<double>> noMansLandLittleroot = [
    [0.625, 0.9]
  ];

  double labMapX = 0;
  double labMapY = 0;

  String oakDirection = 'Down'; // Up, Down, Left, Right
  static double oakX = 0.125;
  static double oakY = 0.9;
  bool chatStarted = false;
  int countPressingA = -1;


  void moveUp() {
    boyDirection = 'Up';
    if (currentLocation == 'littleroot') {
      if (canMoveTo(boyDirection, noMansLandLittleroot, mapX, mapY)) {
        setState(() {
          mapY += step;
        });

        // enter pokelab
        if (double.parse((mapX).toStringAsFixed(4)) == 0.625 && // so we basically make sure there are 4 places after the decimal and then parse the string into a double
        double.parse((mapY).toStringAsFixed(4)) == -1.1) {
          setState(() {
            currentLocation = 'pokelab';
            labMapX = 0;
            labMapY = -2.73;
          });
        }
      }
      animateWalk();
    }
  }
  void moveDown() {
    boyDirection = 'Down';
    if (currentLocation == 'littleroot') {
      if (canMoveTo(boyDirection, noMansLandLittleroot, mapX, mapY)) {
        setState(() {
          mapY -= step;
        });
      }
      animateWalk();
    }
  }
  void moveLeft() {
    boyDirection = 'Left';
    // setState(() {
    //   mapX += step;
    // });
    // animateWalk();
    if (currentLocation == 'littleroot') {
      if (canMoveTo(boyDirection, noMansLandLittleroot, mapX, mapY)) {
        setState(() {
          mapX += step;
        });
      }
      animateWalk();
    }
  }
  void moveRight() {
    boyDirection = 'Right';
    if (currentLocation == 'littleroot') {
      if (canMoveTo(boyDirection, noMansLandLittleroot, mapX, mapY)) {
        setState(() {
          mapX -= step;
        });
      }
      animateWalk();
    }
  }
  void pressedA() {
    
  }
  void pressedB() {
    
  }

  // for this animation, every 50 seconds, increase the sprite count to cycle through the animation
  void animateWalk() {
    // print()
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      setState(() {
        boySpriteCount++;
      });

      if (boySpriteCount == 3) {
        boySpriteCount = 0;
        timer.cancel();
      }
     });
  }

  bool canMoveTo(String direction, var noMansLand, double x, double y) {
    double stepX = 0;
    double stepY = 0;

    if (direction == 'Left') {
      stepX = step;
      stepY = 0;
    } else if (direction == 'Right') {
      stepX = -step;
      stepY = 0;
    } else if (direction == 'Up') {
      stepX = 0;
      stepY = step;
    } else if (direction == 'Down') {
      stepX = 0;
      stepY = -step;
    }

    for (int i = 0; i < noMansLand.length; i++) {
      if ((noMansLand[i][0] == x + stepX) &&
      (noMansLand[i][1] == y + stepY)) {
        return false;
      }
    }
    return true;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AspectRatio( // ratio of width to height of a screen
            aspectRatio: 1, // 1:1, so a square
            child: Container(
              color: Colors.black,
              child: Stack( // list of widgets and positions them one on top of the other, allowing you to overlap multiple widgets and render them from bottom to top
                children: [
                  // little root

                  LittleRoot(
                    x: mapX, // right in the middle
                    y: mapY,
                    currentMap: currentLocation,
                  ),
                
                  // pokelab
                  MyPokeLab(
                    x: labMapX,
                    y: labMapY,
                    currentMap: currentLocation,
                  ),

                  // boy character
                  Container(
                    alignment: Alignment(0, 0),
                    child: MyBoy(
                      location: currentLocation,
                      boySpriteCount: boySpriteCount,
                      direction: boyDirection,
                    ),
                  ),

                  // professor oak
                  Container(
                    alignment: Alignment(0, 0),
                    child: ProfOak(
                      x: mapX,
                      y: mapY - 0.05,
                      location: currentLocation,
                      oakDirection: oakDirection,
                    ),
                  )
                ],
              ),
            )
          ),
          Expanded(
            child: Container(
              color: Colors.grey[900],
              child: Padding(
                padding: const EdgeInsets.all(20.0), // wow you can hover over Column (below) and press the lightbulb to wrap with padding
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'G A M E B O Y',
                          style: TextStyle(color: Colors.white, fontSize: 18)
                        ),
                        Text(
                          ' <3 ',
                          style: TextStyle(color: Colors.red, fontSize: 20)
                        ),
                        Text(
                          'F L U T T E R',
                          style: TextStyle(color: Colors.white, fontSize: 18)
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                      Row(
                        children: [
                          Column(
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                              ),
                              MyButton(
                                text: '←',
                                function: moveLeft
                              ),
                              Container(
                                height: 50,
                                width: 50,
                              )
                            ],
                          ),
                          Column(
                            children: [
                              MyButton(
                                text: '↑',
                                function: moveUp
                              ),
                              Container(
                                height: 50,
                                width: 50,
                              ),
                              MyButton(
                                text: '↓',
                                function: moveDown
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                              ),
                              MyButton(
                                text: '→',
                                function: moveRight
                              ),
                              Container(
                                height: 50,
                                width: 50,
                              ),
                            ],
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Column(
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                              ),
                              MyButton(
                                text: 'b',
                                function: pressedB
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                              ),
                              MyButton(
                                text: 'a',
                                function: pressedA
                              )
                            ],
                          ),
                        ],
                      ),
                    ],),
                    Text('P O K E M O N', style: TextStyle(color: Colors.white))
                  ],
                ),
              )
            )
          )
        ],
      )
    );
  }
}