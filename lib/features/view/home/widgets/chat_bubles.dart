import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/material.dart';
import 'package:whistler/core/resources/index.dart';

final class ChatBubblesWidget extends StatelessWidget {
  const ChatBubblesWidget(
      {super.key, required this.text, required this.time, required this.index});

  final String text;
  final String time;
  final int index;

  @override
  Widget build(BuildContext context) {
    return BubbleSpecialThree(
      isSender: index.isOdd ? true : false,
      text: text,
      color: ColorManager.blue,
      tail: true,
      textStyle: Theme.of(context).textTheme.bodyMedium!,
    );
  }
}
