import 'package:cancer_detector/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  static const PAGE_ROUTE = "/splashScreen";
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _checkUserStatus();
  }

  Future _checkUserStatus() async {
    await Future.delayed(Duration(seconds: 13));
    if (_auth.currentUser != null) {
      Navigator.of(context).pushReplacementNamed(HomeScreen.PAGE_ROUTE,
          arguments: _auth.currentUser);
    } else {
      Navigator.of(context).pushReplacementNamed(LoginScreen.PAGE_ROUTE);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterAlignment: AlignmentDirectional.bottomCenter,
      persistentFooterButtons: const [
        Text(
          "Developed By Eng.Islam",
          style: TextStyle(color: Colors.grey),
        )
      ],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            child: Image.asset(
              "assets/loading.gif",
              fit: BoxFit.fitWidth,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text("Loading")
        ],
      ),
    );
  }
}
