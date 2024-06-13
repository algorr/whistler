import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:whistler/core/resources/index.dart';

class LoadingContainerWidget extends StatelessWidget {
  const LoadingContainerWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Center(
          child: Lottie.asset(AssetsManager.loadingLottie,
              width: size.width / 2, height: size.height / 2),
        ),
      ),
    );
  }
}
