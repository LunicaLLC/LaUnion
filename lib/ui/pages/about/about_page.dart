import 'package:flutter/material.dart';
import '../../widgets/web_footer.dart';
import '../../../config/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:launionweb/l10n/app_localizations.dart';

class AboutPage extends ConsumerWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: AppConstants.xl),
            child: Center(
              child: Text(
                l10n.aboutUs,
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppConstants.lg),
            child: Text(
              l10n.aboutDescription,
              style: const TextStyle(fontSize: 18),
            ),
          ),
          const SizedBox(height: AppConstants.xxl),
          const WebFooter(),
        ],
      ),
    );
  }
}
