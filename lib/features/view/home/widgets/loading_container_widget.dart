import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingContainerWidget extends StatelessWidget {
  const LoadingContainerWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Center(
        child: Lottie.asset('assets/lottie/loading.json',
            width: size.width / 2, height: size.height / 2),
      ),
    );
  }
}
