class Validators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }

    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }

    final phoneRegex = RegExp(r'^[0-9]{10}$');
    final cleaned = value.replaceAll(RegExp(r'[^\d]'), '');

    if (!phoneRegex.hasMatch(cleaned)) {
      return 'Please enter a valid 10-digit phone number';
    }

    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }

    if (value.length < 2) {
      return 'Name must be at least 2 characters';
    }

    return null;
  }

  static String? validateCardNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Card number is required';
    }

    final cleaned = value.replaceAll(RegExp(r'[^\d]'), '');

    if (cleaned.length < 16) {
      return 'Card number must be 16 digits';
    }

    // Luhn algorithm for basic validation
    if (!_isValidLuhn(cleaned)) {
      return 'Invalid card number';
    }

    return null;
  }

  static String? validateExpiryDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Expiry date is required';
    }

    final dateRegex = RegExp(r'^(0[1-9]|1[0-2])\/?([0-9]{2})$');

    if (!dateRegex.hasMatch(value)) {
      return 'Please enter MM/YY format';
    }

    final parts = value.split('/');
    final month = int.parse(parts[0]);
    final year = int.parse('20${parts[1]}');

    final now = DateTime.now();
    final expiry = DateTime(year, month);

    if (expiry.isBefore(now)) {
      return 'Card has expired';
    }

    return null;
  }

  static String? validateCVC(String? value) {
    if (value == null || value.isEmpty) {
      return 'CVC is required';
    }

    if (value.length < 3) {
      return 'CVC must be 3-4 digits';
    }

    return null;
  }

  static bool _isValidLuhn(String number) {
    int sum = 0;
    bool alternate = false;

    for (int i = number.length - 1; i >= 0; i--) {
      int digit = int.parse(number[i]);

      if (alternate) {
        digit *= 2;
        if (digit > 9) {
          digit = (digit % 10) + 1;
        }
      }

      sum += digit;
      alternate = !alternate;
    }

    return (sum % 10 == 0);
  }
}