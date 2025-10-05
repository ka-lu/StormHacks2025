import 'package:flutter/material.dart';
import 'dart:async';
import 'home_screen.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double progress = 0.0;
  double drainSpeed = 0.005; // How fast the bar drains (adjust for difficulty)
  double tapIncrease = 0.03; // How much each tap fills (adjust for difficulty)
  Timer? _drainTimer;
  bool hasWon = false;

  @override
  void initState() {
    super.initState();
    startDraining();
  }

  void startDraining() {
    _drainTimer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (mounted && !hasWon) {
        setState(() {
          progress -= drainSpeed;
          
          // If bar reaches 0, reset to prevent negative values
          if (progress < 0) {
            progress = 0;
          }
          
          // Check if player won (reached 100%)
          if (progress >= 1.0) {
            hasWon = true;
            _drainTimer?.cancel();
            _navigateToHome();
          }
        });
      }
    });
  }

  void handleTap() {
    if (!hasWon && mounted) {
      setState(() {
        progress += tapIncrease;
        // Cap at 100%
        if (progress > 1.0) {
          progress = 1.0;
          hasWon = true;
          _drainTimer?.cancel();
          _navigateToHome();
        }
      });
    }
  }

  void _navigateToHome() {
    // Small delay to show the completed bar
    Future.delayed(const Duration(milliseconds: 500), () {
      // go to chat screen
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ChatScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    _drainTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: handleTap,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Loading...',
                style: TextStyle(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              Text(
                'Tap to load faster!',
                style: TextStyle(
                  color: const Color.fromARGB(255, 44, 141, 231),
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Container(
                  height: 30,
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color.fromARGB(255, 12, 53, 116), width: 2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(13),
                    child: LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.grey[800],
                      valueColor: AlwaysStoppedAnimation<Color>(
                        progress < 0.3
                            ? Colors.red
                            : progress < 0.7
                                ? Colors.orange
                                : Colors.green,
                      ),
                      minHeight: 30,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 0),
              Text(
                '${(progress * 100).toStringAsFixed(0)}%',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 5),
              if (progress < 0.2)
                Text(
                  'Tap faster!',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}