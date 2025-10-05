import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class Maze extends StatefulWidget {
  const Maze({super.key});

  @override
  _mazeState createState() => _mazeState();
}

class _mazeState extends State<Maze> {
  double circleX = 150;
  double circleY = 150;
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
              left: circleX - 110,
              top: circleY - 110,
              child: Container (
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),

            Positioned(
              left: 60,
              top: (0),
              child: Container (
                width: 40,
                height: 25,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  borderRadius: BorderRadius.circular(20), 
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}