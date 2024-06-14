import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:whistler/core/resources/index.dart';
import 'package:whistler/core/resources/route_manager.dart';
import 'package:whistler/features/viewmodel/language/cubit/language_cubit.dart';
import 'package:whistler/features/viewmodel/record/cubit/record_cubit.dart';
import 'package:whistler/features/viewmodel/service/whistler/whistler_cubit.dart';
import 'package:whistler/products/init/app_init.dart';

Future<void> main() async {
  /// App Initialization
  await AppInit().init();
  runApp(const MyApp());
}

final class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => WhistlerCubit()..init()),
        BlocProvider(create: (context) => RecordCubit()..init()),
        BlocProvider(create: (context) => LanguageCubit()),
      ],
      child: MaterialApp(
        builder: FToastBuilder(),
        title: AppStrings.appName,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteManager.getRoute,
        initialRoute: Routes.splashRoute,
        theme: getAppTheme(),
      ),
    );
  }
}
