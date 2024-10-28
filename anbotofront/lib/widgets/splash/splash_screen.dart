import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  bool get isloggedInUser => false;

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(
        context,
        isloggedInUser ? '/welcome' : '/splash',
      );
    });

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 52, 49, 59),
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.7,
          child: AspectRatio(
            aspectRatio: 1,
            child: Image.asset(
              'assets/images/sports.jpg',
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
