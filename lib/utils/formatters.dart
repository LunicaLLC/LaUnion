import 'package:intl/intl.dart';

class Formatters {
  static final DateFormat _dateFormat = DateFormat('MMM d, yyyy');
  static final DateFormat _timeFormat = DateFormat('h:mm a');
  static final DateFormat _dateTimeFormat = DateFormat('MMM d, yyyy • h:mm a');
  static final NumberFormat _currencyFormat = NumberFormat.currency(
    symbol: '\$',
    decimalDigits: 2,
  );
  static final NumberFormat _compactCurrencyFormat = NumberFormat.compactCurrency(
    symbol: '\$',
    decimalDigits: 0,
  );

  static String formatDate(DateTime date) {
    return _dateFormat.format(date);
  }

  static String formatTime(DateTime time) {
    return _timeFormat.format(time);
  }

  static String formatDateTime(DateTime dateTime) {
    return _dateTimeFormat.format(dateTime);
  }

  static String formatCurrency(double amount) {
    return _currencyFormat.format(amount);
  }

  static String formatCompactCurrency(double amount) {
    return _compactCurrencyFormat.format(amount);
  }

  static String formatPhone(String phone) {
    final cleaned = phone.replaceAll(RegExp(r'[^\d]'), '');

    if (cleaned.length == 10) {
      return '(${cleaned.substring(0, 3)}) ${cleaned.substring(3, 6)}-${cleaned.substring(6)}';
    }

    return phone;
  }

  static String formatOrderStatus(String status) {
    return status.replaceAll('_', ' ').toUpperCase();
  }

  static String formatLoyaltyPoints(int points) {
    if (points >= 1000) {
      return '${(points / 1000).toStringAsFixed(1)}k';
    }
    return points.toString();
  }

  static String formatTimeAgo(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inMinutes < 1) {
      return 'just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return _dateFormat.format(date);
    }
  }
}