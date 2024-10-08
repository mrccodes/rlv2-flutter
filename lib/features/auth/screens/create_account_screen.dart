import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/core/widgets/shared_scaffold.dart';
import 'package:rlv2_flutter/features/auth/providers/auth_provider.dart';
import 'package:rlv2_flutter/features/auth/providers/user_session_context_provider.dart';
import 'package:rlv2_flutter/features/auth/screens/splash_screen.dart';
import 'package:rlv2_flutter/features/auth/widgets/create_account_form.dart';
import 'package:rlv2_flutter/l10n/l10n.dart';

class CreateAccountScreen extends ConsumerStatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  CreateAccountScreenState createState() => CreateAccountScreenState();
}

class CreateAccountScreenState extends ConsumerState<CreateAccountScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

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

    // Handle form login
    Future<void> handleCreateAccount({
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
      // await ref.read(authProvider.notifier).createAccount(email, password);
    }

    return SharedScaffold(
      appBarTitle: 'RecipeLab',
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.createAccountScreenTitle,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            // Wrap the form in the scrollable view
            CreateAccountForm(
              onCreateAccount: handleCreateAccount,
            ),
          ],
        ),
      ),
    );
  }
}
