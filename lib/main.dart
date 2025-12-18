import 'package:flutter/material.dart';
import 'l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app.dart';
import 'config/env.dart';
import 'config/supabase_config.dart';
import 'ui/widgets/splash_loading_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment configuration
  await Env.load();
  await SupabaseConfig.initialize();

  // Add error handling
  runApp(
    ErrorBoundary(
      child: ProviderScope(
        child: SplashScreenWrapper(child: const LaUnionFoodApp()),
      ),
    ),
  );
}

class SplashScreenWrapper extends StatefulWidget {
  final Widget child;

  const SplashScreenWrapper({super.key, required this.child});

  @override
  State<SplashScreenWrapper> createState() => _SplashScreenWrapperState();
}

class _SplashScreenWrapperState extends State<SplashScreenWrapper> {
  bool _showSplash = true;
  bool _isMobileWeb = false;

  @override
  void initState() {
    super.initState();
    _checkIfMobileWeb();
  }

  void _checkIfMobileWeb() {
    // Check if running on web and if screen width is mobile-sized
    final views = WidgetsBinding.instance.platformDispatcher.views;
    if (views.isEmpty) {
      _isMobileWeb = false;
      return;
    }

    final view = views.first;
    final width = view.physicalSize.width / view.devicePixelRatio;
    _isMobileWeb = width < 800; // Consider mobile if width < 800px
  }

  @override
  Widget build(BuildContext context) {
    // Skip splash screen on desktop web
    if (!_isMobileWeb) {
      return widget.child;
    }

    if (_showSplash) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashLoadingScreen(
          onLoadingComplete: () {
            setState(() {
              _showSplash = false;
            });
          },
        ),
      );
    }

    return widget.child;
  }
}

class ErrorBoundary extends StatefulWidget {
  final Widget child;

  const ErrorBoundary({super.key, required this.child});

  @override
  State<ErrorBoundary> createState() => _ErrorBoundaryState();
}

class _ErrorBoundaryState extends State<ErrorBoundary> {
  bool hasError = false;
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    if (hasError) {
      return MaterialApp(
        home: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error, size: 64, color: Colors.red),
                const SizedBox(height: 20),
                const Text(
                  'App Error',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(errorMessage),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      hasError = false;
                      errorMessage = '';
                    });
                  },
                  child: Text(AppLocalizations.of(context)!.restartApp),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return widget.child;
  }

  void catchError(FlutterErrorDetails details) {
    // Schedule error state update to avoid calling setState during build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          hasError = true;
          errorMessage = details.exceptionAsString();
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    FlutterError.onError = catchError;
  }
}
