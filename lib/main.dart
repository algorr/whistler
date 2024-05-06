import 'package:flutter/material.dart';
import 'package:whistler/features/view/home/home_view.dart';
import 'package:whistler/products/init/app_init.dart';

Future<void> main() async {
  /// App Initialization
  await AppInit().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeView(),
    );
  }
}
