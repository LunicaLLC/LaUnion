import 'package:flutter/material.dart';
import '../../config/theme.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool primary;
  final bool loading;
  final bool disabled;
  final IconData? icon;
  final double? width;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.primary = true,
    this.loading = false,
    this.disabled = false,
    this.icon,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: disabled || loading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: primary ? AppTheme.spicyRed : Colors.transparent,
          foregroundColor: primary ? Colors.white : AppTheme.spicyRed,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: primary
                ? BorderSide.none
                : BorderSide(color: AppTheme.spicyRed, width: 2),
          ),
        ),
        child: loading
            ? const SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation(Colors.white),
          ),
        )
            : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 20),
              const SizedBox(width: 8),
            ],
            Text(
              text,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color? color;
  final double size;

  const AppIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.color,
    this.size = 24,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: color ?? AppTheme.spicyRed,
        size: size,
      ),
      style: IconButton.styleFrom(
        shape: CircleBorder(
          side: BorderSide(
            color: color ?? AppTheme.spicyRed,
            width: 1,
          ),
        ),
      ),
    );
  }
}