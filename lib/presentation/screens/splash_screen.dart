import 'package:flutter/material.dart';
import 'package:test_expenses/utils/test_styles.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Splash\nScreen',
          style: TestStyles().title,
        ),
      ),
    );
  }
}
