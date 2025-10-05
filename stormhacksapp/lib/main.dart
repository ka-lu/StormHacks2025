import 'package:flutter/material.dart';
import 'screens/maze_screen.dart';
//import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat demo' ,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Maze(),
      //home: const ChatScreen(),
    );
  }
}


