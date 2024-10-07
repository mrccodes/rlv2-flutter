import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/core/widgets/custom_button.dart';
import 'package:rlv2_flutter/utils/email_regex.dart';
import 'package:rlv2_flutter/utils/number_regex.dart';
import 'package:rlv2_flutter/utils/symbol_regex.dart';

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key, this.onLogin, this.onCreateAccount});

  // Use Future<void> Function()? for function signature
  final Future<void> Function(String email, String password)? onLogin;
  final Future<void> Function(String email, String password)? onCreateAccount;

  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends ConsumerState<LoginForm> {
  final formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';

  String? _emailValidator(String? value) {
    if (value!.isEmpty) {
      return 'Please enter your email';
    }
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _passwordValidator(String? value) {
    if (value!.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 9) {
      return 'Password must be at least 9 characters';
    }
    if (value.length > 20) {
      return 'Password must be less than 20 characters';
    }
    if (!numberRegex.hasMatch(value)) {
      return 'Password must contain at least one number';
    }
    if (!symbolRegex.hasMatch(value)) {
      return 'Password must contain at least one symbol';
    }
    return null;
  }

  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      try {
        await widget.onLogin?.call(email, password);
      } catch (err) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(err.toString())),
          );
        }
      }
    }
  }

  Future<void> createAccount() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      try {
        await widget.onCreateAccount?.call(email, password);
      } catch (err) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(err.toString())),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            validator: _emailValidator,
            decoration: const InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
            onSaved: (value) => email = value!,
          ),
          const SizedBox(height: 16),
          TextFormField(
            validator: _passwordValidator,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(),
            ),
            onSaved: (value) => password = value!,
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: CustomButton(
                  onPressed: login,
                  text: 'Login',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: CustomButton(
                  onPressed: createAccount,
                  text: 'Create Account',
                  buttonType: ButtonType.secondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
