import 'package:flutter/material.dart';
import '../../config/constants.dart';
import '../../config/theme.dart';
import '../../../l10n/app_localizations.dart';

class WebFooter extends StatelessWidget {
  const WebFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      color: AppTheme.charcoal,
      padding: const EdgeInsets.all(AppConstants.xl),
      width: double.infinity,
      child: Column(
        children: [
          Text(
            l10n.footerRights,
            style: const TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: AppConstants.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {},
                child: Text(
                  l10n.privacyPolicy,
                  style: const TextStyle(color: Colors.white54),
                ),
              ),
              const SizedBox(width: AppConstants.lg),
              TextButton(
                onPressed: () {},
                child: Text(
                  l10n.termsOfService,
                  style: const TextStyle(color: Colors.white54),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
