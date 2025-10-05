import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class Maze extends StatefulWidget {
  @override
  _mazeState createState() => _mazeState();
}

class _mazeState extends State<Maze> {
  double circleX = 250;
  double circleY = 250;
  double speed = 1.5;

  @override
  void initState() {
    super.initState();
    accelerometerEventStream().listen((AccelerometerEvent event) {
      setState(() {
        circleX += event.x * speed * -1;
        circleY += event.y * speed;

        circleX = circleX.clamp(10, 490);
        circleY = circleY.clamp(10, 490);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: 
        Stack(
          children: [

            Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20), // For a rounded rectangle
              ),
            ),

            Positioned(
              left: (300-20) / 2,
              top: (300-20) / 2,
              child: Container (
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}