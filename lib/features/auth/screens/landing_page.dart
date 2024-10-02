// features/auth/screens/landing_page.dart
import 'package:flutter/material.dart';
import 'package:rlv2_flutter/features/auth/screens/login_screen.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);
    // Your landing page UI
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate to LoginScreen
            Navigator.push(
              context,
              MaterialPageRoute<LoginScreen>(
                builder: (_) => const LoginScreen(),
              ),
            );
          },
          child: const Text('Go to Login'),
      ),
    ),);
  }
}
