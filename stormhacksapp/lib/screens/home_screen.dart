

import 'package:flutter/material.dart';
import 'maze_screen.dart';


String globalMessage = '';
class SimpleChatInput extends StatefulWidget {
  const SimpleChatInput({super.key});

  @override
  _SimpleChatInputState createState() => _SimpleChatInputState();
}

class _SimpleChatInputState extends State<SimpleChatInput> {
  final TextEditingController _textController = TextEditingController();

  void _handleMaze() {
  final message = _textController.text;
  if (message.isNotEmpty) {

    globalMessage = message;


    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Maze()
        ),
    );
    _textController.clear();
    FocusScope.of(context).unfocus();
  }
}

  @override
  Widget build(BuildContext context) {
    return Container(
      // The background color for the input area
      color: Colors.white, 
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 4.0, top: 4.0),
      child: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end, // Aligns to the bottom as text wraps
          children: <Widget>[
            // the Text Field (Auto-growing and Rounded)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: TextField(
                  controller: _textController,
                  minLines: 1, 
                  maxLines: 5, // Allows the field to grow up to 5 lines
                  keyboardType: TextInputType.multiline,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    hintText: "iMessage",
                    // Removes the default underline
                    border: InputBorder.none, 
                    // Adds rounded border and light background
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide.none, // Hide border lines
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide.none, // Hide border lines
                    ),
                  ),
                ),
              ),
            ),

            // The Send Button
            Padding(
              padding: const EdgeInsets.only(bottom: 4.0), // A small bottom padding for alignment
              child: IconButton(
                icon: const Icon(Icons.send, color: Colors.blue),
                onPressed: _handleMaze,
                iconSize: 32.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // This hides the keyboard when tapping anywhere outside the TextField
        FocusScope.of(context).unfocus();
      },
      behavior: HitTestBehavior.translucent, // ensures taps on empty space are detected
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Chat Demo',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        
        body: Center(
          child: Column(
            children: const <Widget>[
              Expanded(
                child: Text('You smell'),
              ),
            ],
          ),
        ),

        bottomNavigationBar: const SimpleChatInput(),
      ),
    );
  }
}
