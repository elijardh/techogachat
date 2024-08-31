import 'package:flutter/material.dart';
import 'package:techogachat/screens/sign_in_screen/sign_in_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3))
        .then((_) => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const SignInScreen(),
            )));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Text(
          'Tech Oga Chat App',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
