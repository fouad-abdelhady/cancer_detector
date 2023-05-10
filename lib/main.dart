import 'package:cancer_detector/config/router.dart';
import 'package:cancer_detector/screens/home_screen.dart';
import 'package:cancer_detector/screens/register_screen.dart';
import 'package:cancer_detector/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    Firebase.initializeApp();
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
              titleTextStyle:
                  TextStyle(color: Colors.black, letterSpacing: 1.5))),
      initialRoute: SplashScreen.PAGE_ROUTE,
      onGenerateRoute: (settings) =>
          ScreensRouter().onGenerateRoute(settings: settings),
    );
  }
}
