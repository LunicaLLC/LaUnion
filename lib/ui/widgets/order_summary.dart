import 'package:flutter/material.dart';
import '../../config/theme.dart';
import '../../utils/formatters.dart';

class OrderSummary extends StatelessWidget {
  final double subtotal;
  final double tax;
  final double total;
  final int itemCount;
  final VoidCallback? onCheckout;

  const OrderSummary({
    super.key,
    required this.subtotal,
    required this.tax,
    required this.total,
    required this.itemCount,
    this.onCheckout,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildSummaryRow('Subtotal', subtotal),
          const SizedBox(height: 8),
          _buildSummaryRow('Tax', tax),
          const Divider(height: 24),
          _buildSummaryRow('Total', total, isTotal: true),
          const SizedBox(height: 16),
          if (onCheckout != null)
            ElevatedButton(
              onPressed: onCheckout,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.spicyRed,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 48),
              ),
              child: Text(
                'Checkout ($itemCount ${itemCount == 1 ? 'item' : 'items'})',
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, double amount, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.normal,
            color: isTotal
                ? AppTheme.charcoal
                : AppTheme.charcoal.withOpacity(0.6),
          ),
        ),
        Text(
          Formatters.formatCurrency(amount),
          style: TextStyle(
            fontSize: isTotal ? 18 : 14,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
            color: isTotal ? AppTheme.spicyRed : AppTheme.charcoal,
          ),
        ),
      ],
    );
  }
}
