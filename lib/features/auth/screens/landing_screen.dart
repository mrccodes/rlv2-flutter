// features/auth/screens/landing_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/core/widgets/shared_scaffold.dart';
import 'package:rlv2_flutter/features/auth/screens/login_screen.dart';

class LandingScreen extends ConsumerWidget {
  const LandingScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return SharedScaffold(
      appBarTitle: 'RecipeLab',
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
