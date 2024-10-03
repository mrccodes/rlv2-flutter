import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/features/auth/notifiers/auth_notifier.dart';
import 'package:rlv2_flutter/features/auth/providers/auth_provider.dart';

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key});

  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends ConsumerState<LoginForm> {
  final formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';

  Future<void> submit() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      await ref.read(authNotifierProvider.notifier).login(email, password);
    }
  }

  Future<void> testSubmit() async {
    formKey.currentState!.save();
    await ref
        .read(authNotifierProvider.notifier)
        .login('matt@matt.com', 'password123');
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(labelText: 'Email'),
            onSaved: (value) => email = value!,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your email';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Password'),
            onSaved: (value) => password = value!,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
          ),
          ElevatedButton(
            onPressed: submit,
            child: const Text('Submit'),
          ),
          ElevatedButton(
            onPressed: testSubmit,
            child: const Text('Test Submit'),
          ),
        ],
      ),
    );
  }
}
