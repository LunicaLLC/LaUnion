import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:launionweb/l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'config/theme.dart';
import 'router.dart';
import 'providers/locale_provider.dart';

class LaUnionFoodApp extends ConsumerWidget {
  const LaUnionFoodApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);

    return MaterialApp.router(
      title: 'La Unión Pupusería y Taquería',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.light,
      routerConfig: AppRouter.router,
      locale: locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('es'), // Spanish
      ],
    );
  }
}
