import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stormhacksapp/screens/home_screen.dart';
import 'home_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/scheduler.dart';


class Maze extends StatefulWidget {
  static String typedMessage = '';

  const Maze({super.key});

  @override
  _mazeState createState() => _mazeState();
}

class _mazeState extends State<Maze> {
  static const double mazeSize = 300.0;
  static const double ballDiameter = 20.0;
  static const double minX = 0.0;
  static const double maxX = mazeSize - ballDiameter;
  static const double minY = 0.0;
  static const double maxY = mazeSize - ballDiameter;

  double resetX = 150;
  double resetY = 0;

  double circleX = 150;
  double circleY = 0;

  double gravity = 2.0;
  double horizontalSpeed = 5.0;

  List<Rect> platforms = [];

  @override
  void initState() {
    super.initState();

    platforms = [
      Rect.fromLTWH(125, 75, 100, 20),
      Rect.fromLTWH(25, 130, 90, 20),
      Rect.fromLTWH(155, 160, 120, 20),
      Rect.fromLTWH(70, 220, 60, 20),
    ];

    Timer.periodic(const Duration(milliseconds: 256), (timer) {
      setState(() {
        applyGravity();
        clampBoundaries();
      });
    });
  }

  bool goalReached = false;

  void clampBoundaries() {
    if (!goalReached && (circleX > 125 && circleX < 165) && (circleY > 275)) {
      goalReached = true;
      _sendSMS();
      Navigator.push(
      context,
        MaterialPageRoute(
          builder: (context) => ChatScreen()
          ), 
      );
    }
    if (circleY > maxY) {
      circleX = resetX;
      circleY = resetY;
      return;
    }
    circleX = circleX.clamp(minX, maxX);
    circleY = circleY.clamp(minY, maxY);
  }

  void applyGravity() {
    double nextY = circleY + gravity;

    bool onPlatform = false;
    for (Rect p in platforms) {
      if (circleX + 20 > p.left && circleX < p.right) {
        if (circleY + 20 <= p.top && nextY + 20 >= p.top) {
          nextY = p.top - 20;
          onPlatform = true;
        }
      }
    }
    if (!onPlatform) {
      circleY = nextY;
    }
  }

  KeyEventResult handleKey(FocusNode node, KeyEvent event) {
    if (event is KeyDownEvent || event is KeyRepeatEvent) {
      if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
        circleX -= horizontalSpeed;
        setState(() {});
      }
      else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
        circleX += horizontalSpeed;
        setState(() {});
      }
    }
    return KeyEventResult.handled;
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      autofocus: true, // <-- Ensures it receives keyboard events immediately
      onKeyEvent: handleKey,
      child: Scaffold(
        body: Center(
          child: Stack(
            children: [

              Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),

              ...platforms.map((p) => Positioned(
                left: p.left,
                top: p.top,
                child: Container(
                  width: p.width,
                  height: p.height,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 16, 70, 133),
                    //borderRadius: BorderRadius.circular(10),
                  ),
                ),
              )),

              Positioned(
                left: circleX,
                top: circleY,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ),

              Positioned(
                left: 125,
                top: 275,
                child: Container(
                  width: 40,
                  height: 25,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


void _sendSMS() async {
  final phoneNumber = '+17783253856'; // replace with your number
  final encodedMessage = Uri.encodeComponent(globalMessage).replaceAll('+', '%20');
  final Uri smsUri = Uri.parse('sms:$phoneNumber?body=$encodedMessage');

  if (await canLaunchUrl(smsUri)) {
    await launchUrl(smsUri);
  } else {
    print('Could not launch SMS app');
    }
  }
}