import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/core/widgets/custom_button.dart';
import 'package:rlv2_flutter/utils/app_flavor.dart';
import 'package:rlv2_flutter/utils/app_logger.dart';
import 'package:rlv2_flutter/utils/validators.dart';

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key, this.onLogin});

  final Future<void> Function(String email, String password)? onLogin;

  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends ConsumerState<LoginForm> {
  final formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';

  String? emailValidator(String? value) {
    final validators = StringValidators(context);
    if (!validators.emailIsValid.validate(value!)) {
      return validators.emailIsValid.error;
    }
    return null;
  }

  String? _passwordValidator(String? value) {
    final validators = StringValidators(context);
    if (!validators.passwordNotEmpty.validate(value!)) {
      return validators.passwordNotEmpty.error;
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

  Widget renderDevLogin() {
    AppLogger.info('appFlavor:  $appFlavor');
    if (appFlavor != 'development') {
      return const SizedBox();
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: CustomButton(
          onPressed: devLogin,
          fullWidth: true,
          text: 'Dev Login',
        ),
      );
    }
  }

  Future<void> devLogin() async {
    try {
      await widget.onLogin?.call(
        dotenv.env['DEV_USER_EMAIL'] ?? '',
        dotenv.env['DEV_USER_PASSWORD'] ?? '',
      );
    } catch (err) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(err.toString())),
        );
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
            validator: emailValidator,
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CustomButton(
              onPressed: login,
              fullWidth: true,
              text: 'Login',
            ),
          ),
          renderDevLogin(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CustomButton(
              onPressed: () async {
                await Navigator.pushNamed(context, '/register');
              },
              text: 'Create Account',
              fullWidth: true,
              buttonType: ButtonType.secondary,
            ),
          ),
        ],
      ),
    );
  }
}
