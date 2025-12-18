import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../config/theme.dart';
import '../../../config/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:launionweb/l10n/app_localizations.dart';

class SignUpPage extends ConsumerWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.signUp)),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          padding: const EdgeInsets.all(AppConstants.lg),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                l10n.createAccount,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: AppConstants.xl),
              // Placeholder for form fields
              TextFormField(
                decoration: InputDecoration(
                  labelText: l10n.fullName,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: AppConstants.md),
              TextFormField(
                decoration: InputDecoration(
                  labelText: l10n.email,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: AppConstants.md),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: l10n.password,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: AppConstants.lg),
              ElevatedButton(
                onPressed: () {
                  // TODO: Implement sign up logic
                  context.go('/');
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: AppTheme.spicyRed,
                  foregroundColor: Colors.white,
                ),
                child: Text(l10n.signUp),
              ),
              const SizedBox(height: AppConstants.md),
              TextButton(
                onPressed: () => context.go('/signin'),
                child: Text(l10n.alreadyHaveAccountSignIn),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
