import 'package:flutter/material.dart';

class Maze extends StatefulWidget {
  const Maze({super.key});

  @override
  _mazeState createState() => _mazeState();
}

class _mazeState extends State<Maze> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Hello, this is a test"),
        ),
    );
  }
}