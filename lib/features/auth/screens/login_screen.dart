import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/features/auth/providers/auth_provider.dart';
import 'package:rlv2_flutter/features/auth/providers/user_session_context_provider.dart';
import 'package:rlv2_flutter/features/auth/screens/splash_screen.dart';
import 'package:rlv2_flutter/features/auth/widgets/login_form.dart';
import 'package:rlv2_flutter/features/navigation/widgets/custom_app_bar.dart';
import 'package:rlv2_flutter/utils/widget_handle_error.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends ConsumerState<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    ref.watch(userSessionListenerProvider);
    final authState = ref.watch(authProvider);

    // Handle successful login
    if (authState.user != null) {
      // Use WidgetsBinding to delay the
      // navigation until after the build is done
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, '/dashboard');
      });
      return const SplashScreen(); // Placeholder during navigation
    }

    // Handle form login
    Future<void> handleLogin(String email, String password) async {
      try {
        await ref.read(authProvider.notifier).login(email, password);
      } catch (e) {
        if (context.mounted) {
          widgetHandleError(e, context, notifyUser: true);
        }
      }
    }

    return Scaffold(
      appBar: const CustomAppBar(title: 'RecipeLab'),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Padding(
          padding: const EdgeInsets.only(top: 150),
          child: Column(
            children: [
              const Text(
                'Login to RecipeLab',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              LoginForm(
                onLogin: handleLogin,
                isLoading: authState.isLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
