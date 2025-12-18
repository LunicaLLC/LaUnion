import 'package:flutter/material.dart';
import '../../config/theme.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final double elevation;
  final BorderRadius? borderRadius;

  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
    this.backgroundColor,
    this.elevation = 2,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      color: backgroundColor ?? Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius ?? BorderRadius.circular(12),
        child: Padding(
          padding: padding ?? const EdgeInsets.all(16),
          child: child,
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color? color;

  const InfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: color ?? AppTheme.spicyRed,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.charcoal.withOpacity(0.6),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}