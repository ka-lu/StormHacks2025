

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
      color: const Color.fromARGB(255, 104, 37, 32), 
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
                    fillColor: const Color.fromARGB(255, 255, 239, 239),
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
                icon: const Icon(Icons.send, color: Color.fromRGBO(243, 159, 33, 1)),
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
        backgroundColor: const Color.fromARGB(255, 207, 56, 56),
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                Text(
                  'Fastenger',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Bangers',
                    shadows: [
                      Shadow(
                          blurRadius:10.0,  // shadow blur
                            color: Colors.orange, // shadow color
                            offset: Offset(0.0,2.0), // how much shadow will be shown
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 0),

                Text(
                  'the fastest messenger in NA',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Bangers',
                    shadows: [
                      Shadow(
                          blurRadius:10.0,  // shadow blur
                            color: Colors.orange, // shadow color
                            offset: Offset(0.0,2.0), // how much shadow will be shown
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 0),

                Image.asset(
                  'assets/TheFlash.png',
                  width: 400,
                  height: 200,
                  errorBuilder: (context, error, stackTrace) {
                    return Column(
                      children: [
                        Container(
                          width: 400,
                          height: 400,
                          color: Colors.grey[300],
                          child: Icon(
                            Icons.error_outline,
                            size: 50,
                            color: const Color.fromARGB(255, 124, 32, 25),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Image not found',
                          style: TextStyle(color: const Color.fromARGB(255, 99, 22, 17)),
                        ),
                      ],
                    );
                  },
                ),

                SizedBox(height: 0),
              ],
            ),
          ),
        ),

        bottomNavigationBar: const SimpleChatInput(),
      ),
    );
  }
}
 