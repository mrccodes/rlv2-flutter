import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/core/models/api_exception_model.dart';
import 'package:rlv2_flutter/core/widgets/custom_button.dart';

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key, this.onSubmit});

  // Use Future<void> Function()? for function signature
  final Future<void> Function(String email, String password)? onSubmit;

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

      try {
        await widget.onSubmit?.call(email, password);
      }  catch (err) {
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
            decoration: const InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
            onSaved: (value) => email = value!,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your email';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(),
            ),
            onSaved: (value) => password = value!,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: CustomButton(
                  onPressed: submit,
                  text: 'Login',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: CustomButton(
                  onPressed: submit,
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
