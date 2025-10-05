import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/loading_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const LoadingScreen(),
      //home: const ChatScreen(),
      //home : const Maze(),
    );
  }
}