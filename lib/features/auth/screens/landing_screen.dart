// features/auth/screens/landing_page.dart
import 'package:flutter/material.dart';
import 'package:rlv2_flutter/core/widgets/custom_app_bar.dart';
import 'package:rlv2_flutter/features/auth/screens/login_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);
    // Your landing page UI
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'RecipeLab',
        ),
      body: Center(
        child: ElevatedButton(
          key: const ValueKey('loginButton'),
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
      ),
    );
  }
}
