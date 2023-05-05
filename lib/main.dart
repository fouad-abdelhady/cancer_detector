import 'package:cancer_detector/config/router.dart';
import 'package:cancer_detector/screens/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
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
        primarySwatch: Colors.blue,
      ),
      initialRoute: LoginScreen.PAGE_ROUTE,
      onGenerateRoute: (settings) =>
          ScreensRouter().onGenerateRoute(settings: settings),
    );
  }
}
