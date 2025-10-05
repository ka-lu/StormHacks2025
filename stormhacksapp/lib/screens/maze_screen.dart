import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:async';
import 'package:flutter/scheduler.dart';


class Maze extends StatefulWidget {
  const Maze({super.key});

  @override
  _mazeState createState() => _mazeState();
}

class _mazeState extends State<Maze> with SingleTickerProviderStateMixin{
  
  static const double board = 300; // the size of the game
  
  
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

            // blue box
            Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20), // For a rounded rectangle
              ),
            ),

            // obstacle
            Positioned(
              left: 125,
              top: 75,
              child: Container (
                width: 100,
                height: 20,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 16, 70, 133),
                  borderRadius: BorderRadius.circular(10), 
                ),
              ),
            ),

            // obstacle
            Positioned(
              left: 25,
              top: 130,
              child: Container (
                width: 90,
                height: 20,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 16, 70, 133),
                  borderRadius: BorderRadius.circular(10), 
                ),
              ),
            ),

            // obstacle
            Positioned(
              left: 155,
              top: 160,
              child: Container (
                width: 120,
                height: 20,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 16, 70, 133),
                  borderRadius: BorderRadius.circular(10), 
                ),
              ),
            ),

            // obstacle
            Positioned(
              left: 70,
              top: 220,
              child: Container (
                width: 60,
                height: 20,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 16, 70, 133),
                  borderRadius: BorderRadius.circular(10), 
                ),
              ),
            ),

            // white ball
            Positioned(
              left: circleX - 10,
              top: circleY - 140,
              child: Container (
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),

            // black hole
            Positioned(
              left: 125,
              top: 275,
              child: Container (
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
    );
  }
}