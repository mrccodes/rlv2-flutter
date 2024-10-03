import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/core/providers/auth_service_provider.dart';
import 'package:rlv2_flutter/features/auth/screens/splash_screen.dart';
import 'package:rlv2_flutter/features/auth/providers/user_context_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      await ref.read(authNotifierProvider.notifier).login(_email, _password);
      final authState = ref.read(authNotifierProvider);
      if (authState.user != null) {
        unawaited(ref
            .read(userContextSessionNotifierProvider.notifier)
            .loadUserSession(authState.user!.id));
        if (mounted) {
          unawaited(Navigator.pushReplacementNamed(context, '/dashboard'));
        }
      } else if (authState.error != null && mounted) {
        _showError(authState.error!);
      }
    }
  }

  Future<void> _testSubmit() async {
    _formKey.currentState!.save();
    await ref
        .read(authNotifierProvider.notifier)
        .login('mrc@matt.com', 'password123');
    final authState = ref.read(authNotifierProvider);
    if (authState.user != null) {
      await ref
          .read(userContextSessionNotifierProvider.notifier)
          .loadUserSession(authState.user!.id);
      if (mounted) {
        unawaited(Navigator.pushReplacementNamed(context, '/dashboard'));
      }
    } else if (authState.error != null && mounted) {
      _showError(authState.error!);
    }
  }

  void _showError(String error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(error)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: authState.isLoading
          ? const SplashScreen()
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      key: const ValueKey('emailField'),
                      decoration: const InputDecoration(labelText: 'Email'),
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter your email' : null,
                      onSaved: (value) => _email = value!,
                    ),
                    TextFormField(
                      key: const ValueKey('passwordField'),
                      decoration: const InputDecoration(labelText: 'Password'),
                      obscureText: true,
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter your password' : null,
                      onSaved: (value) => _password = value!,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      key: const ValueKey('submitButton'),
                      onPressed: _submit,
                      child: const Text('Login'),
                    ),
                    ElevatedButton(
                      onPressed: _testSubmit,
                      child: const Text('Login Test'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
