// features/auth/screens/landing_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/core/widgets/custom_button.dart';
import 'package:rlv2_flutter/features/auth/screens/login_screen.dart';
import 'package:rlv2_flutter/features/navigation/widgets/custom_app_bar.dart';

class LandingScreen extends ConsumerWidget {
  const LandingScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'RecipeLab'),
      body: Center(
        child: CustomButton(
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
          text: 'Go to Login',
        ),
      ),
    );
  }
}
