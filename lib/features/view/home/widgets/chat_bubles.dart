import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/material.dart';

class ChatBubblesWidget extends StatelessWidget {
  const ChatBubblesWidget({super.key, required this.text, required this.time});

  final String text;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BubbleSpecialThree(
          text: text,
          color: Color(0xFF1B97F3),
          tail: true,
          textStyle: TextStyle(color: Colors.white, fontSize: 16),
        ),
        Text(time, style: TextStyle(fontSize: 12, color: Colors.grey))
      ],
    );
  }
}
