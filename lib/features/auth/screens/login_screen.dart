import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/core/widgets/custom_app_bar.dart';
import 'package:rlv2_flutter/features/auth/providers/auth_provider.dart';
import 'package:rlv2_flutter/features/auth/providers/user_context_provider.dart';
import 'package:rlv2_flutter/features/auth/screens/splash_screen.dart';
import 'package:rlv2_flutter/features/auth/widgets/login_form.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends ConsumerState<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    ref.watch(userSessionListenerProvider);
    final authState = ref.watch(authNotifierProvider);

    // Handle loading
    if (authState.isLoading) {
      return const SplashScreen();
    }

    // Handle successful login
    if (authState.user != null) {
      // Use WidgetsBinding to delay the 
      // navigation until after the build is done
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, '/dashboard');
      });
      return const SplashScreen(); // Placeholder during navigation
    }

    // Handle login error
    if (authState.error != null) {
      // Use WidgetsBinding to show error after build completes
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(authState.error!)),
        );
      });
    }

    // Handle form login
    Future<void> handleLogin(String email, String password) async {
      await ref.read(authNotifierProvider.notifier).login(email, password);
    }

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'RecipeLab',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: LoginForm(
          onSubmit: handleLogin,
        ),
      ),
    );
  }
}
