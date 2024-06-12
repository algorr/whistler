import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/material.dart';

class ChatBubblesWidget extends StatelessWidget {
  const ChatBubblesWidget(
      {super.key, required this.text, required this.time, required this.index});

  final String text;
  final String time;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BubbleSpecialThree(
          isSender: index.isOdd ? true : false,
          text: text,
          color: const Color(0xFF1B97F3),
          tail: true,
          textStyle: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        Text(time, style: const TextStyle(fontSize: 12, color: Colors.grey))
      ],
    );
  }
}
