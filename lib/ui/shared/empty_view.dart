import 'package:flutter/material.dart';
import '../../config/theme.dart';

class EmptyView extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData icon;
  final String? buttonText;
  final VoidCallback? onButtonPressed;

  const EmptyView({
    super.key,
    required this.title,
    this.subtitle,
    this.icon = Icons.inbox,
    this.buttonText,
    this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 64,
              color: AppTheme.lightGrey,
            ),
            const SizedBox(height: 24),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 8),
              Text(
                subtitle!,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.charcoal.withOpacity(0.6),
                ),
              ),
            ],
            if (buttonText != null && onButtonPressed != null) ...[
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: onButtonPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.spicyRed,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
                child: Text(buttonText!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}