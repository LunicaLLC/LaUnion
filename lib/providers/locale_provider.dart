import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocaleNotifier extends Notifier<Locale> {
  @override
  Locale build() {
    return const Locale('en'); // Default to English
  }

  void toggleLocale() {
    state = state.languageCode == 'en'
        ? const Locale('es')
        : const Locale('en');
  }

  void setLocale(Locale locale) {
    if (!['en', 'es'].contains(locale.languageCode)) return;
    state = locale;
  }
}

final localeProvider = NotifierProvider<LocaleNotifier, Locale>(() {
  return LocaleNotifier();
});
