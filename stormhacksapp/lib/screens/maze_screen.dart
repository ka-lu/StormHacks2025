import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:stormhacksapp/screens/home_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class Maze extends StatefulWidget {
  static String typedMessage = '';

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
              left: circleX - 110,
              top: circleY - 240,
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

  // checking if ball goes into goal
  bool isGoal() {

    // ball positions
    final ballLeft = circleX - 110;
    final ballRight = ballLeft + 20;
    final ballBot = circleY - 240;
    final ballTop = ballBot + 20;

    // goal positions
    final goalTop = 275;
    final goalLeft = 125;
    final goalRight = goalLeft + 40;
    final goalBot = goalTop + 25;

    return ballRight > goalLeft &&
        ballLeft < goalRight &&
        ballBot > goalTop &&
        ballTop < goalBot;
  }
}