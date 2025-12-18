import 'package:flutter/material.dart';
import '../../config/theme.dart';
import 'app_button.dart';

class ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  final String? retryText;

  const ErrorView({
    super.key,
    required this.message,
    required this.onRetry,
    this.retryText = 'Try Again',
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
              Icons.error_outline,
              size: 64,
              color: AppTheme.spicyRed,
            ),
            const SizedBox(height: 24),
            Text(
              'Oops!',
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                color: AppTheme.spicyRed,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 32),
            AppButton(
              text: retryText!,
              onPressed: onRetry,
              primary: true,
            ),
          ],
        ),
      ),
    );
  }
}

class EmptyView extends StatelessWidget {
  final String message;
  final IconData icon;
  final String? actionText;
  final VoidCallback? onAction;

  const EmptyView({
    super.key,
    required this.message,
    this.icon = Icons.shopping_cart,
    this.actionText,
    this.onAction,
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
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            if (actionText != null && onAction != null) ...[
              const SizedBox(height: 24),
              AppButton(
                text: actionText!,
                onPressed: onAction!,
                primary: true,
              ),
            ],
          ],
        ),
      ),
    );
  }
}