import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/core/widgets/loading_widget.dart';
import 'package:rlv2_flutter/features/auth/models/register_model.dart';
import 'package:rlv2_flutter/features/auth/providers/auth_provider.dart';
import 'package:rlv2_flutter/features/auth/providers/user_session_context_provider.dart';
import 'package:rlv2_flutter/features/auth/screens/splash_screen.dart';
import 'package:rlv2_flutter/features/auth/widgets/register_form.dart';
import 'package:rlv2_flutter/features/navigation/widgets/custom_app_bar.dart';
import 'package:rlv2_flutter/features/organization/models/create_organization_model.dart';
import 'package:rlv2_flutter/features/user/models/create_user_information_model.dart';
import 'package:rlv2_flutter/features/user/models/create_user_model.dart';
import 'package:rlv2_flutter/l10n/l10n.dart';
import 'package:rlv2_flutter/utils/app_logger.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends ConsumerState<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    var formLoading = false;

    ref.watch(userSessionListenerProvider);
    final authState = ref.watch(authProvider);

    // Handle loading
    if (authState.isLoading) {
      return const SplashScreen();
    }

    // Handle successful account creation
    if (authState.user != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, '/dashboard');
      });
      return const SplashScreen(); // Placeholder during navigation
    }

    // Handle login error
    if (authState.error != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(authState.error!),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      });
    }

    // Handle form registration
    Future<void> handleRegister({
      required bool isOrganizationAccount,
      required String email,
      required String password,
      required String firstName,
      required String lastName,
      required String username,
      required String userImage,
      required String organizationName,
      required String organizationDescription,
      required String organizationImage,
    }) async {
      try {
        formLoading = true;
        final user = CreateUser(
          email: email,
          password: password,
          username: username,
        );
        final userInformation = CreateUserInformationBase(
          firstName: firstName,
          lastName: lastName,
          image: userImage,
        );
        final organization = CreateOrganizationBase(
          name: organizationName,
          description: organizationDescription,
          image: organizationImage,
        );

        final registerData = Register(
          user: user,
          userInformation: userInformation,
          organization: organization,
        );

        await ref.read(authProvider.notifier).register(registerData);
      } catch (e) {
        AppLogger.error(e.toString());
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content:
                  const Text('An error occurred while creating your account. '
                      'Please try again.'),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
      } finally {
        formLoading = false;
      }
    }

    return Scaffold(
      appBar: const CustomAppBar(title: 'RecipeLab'),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.registerScreenTitle,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            // Wrap the form in the scrollable view
            if (formLoading)
              Container(
                alignment: Alignment.center,
                child: const LoadingWidget(),
              )
            else
              RegisterForm(
                onRegister: handleRegister,
              ),
          ],
        ),
      ),
    );
  }
}
