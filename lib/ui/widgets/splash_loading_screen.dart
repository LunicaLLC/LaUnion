import 'package:flutter/material.dart';

class SplashLoadingScreen extends StatefulWidget {
  final VoidCallback onLoadingComplete;

  const SplashLoadingScreen({super.key, required this.onLoadingComplete});

  @override
  State<SplashLoadingScreen> createState() => _SplashLoadingScreenState();
}

class _SplashLoadingScreenState extends State<SplashLoadingScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _backgroundFade;
  late Animation<double> _backgroundScale;
  late Animation<double> _logoScale;
  late Animation<double> _logoFade;
  late Animation<double> _outlinePulse;
  late Animation<double> _outlineFade;
  late Animation<double> _pupuseriaSlide;
  late Animation<double> _pupuseriaFade;
  late Animation<double> _laUnionSlide;
  late Animation<double> _laUnionFade;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 3500), // Increased from 2500ms
      vsync: this,
    );

    // Pupuseria Title: Slide up from bottom (FIRST - starts immediately)
    _pupuseriaSlide = Tween<double>(begin: 60.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.35, curve: Curves.easeOutCubic),
      ),
    );
    _pupuseriaFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.25, curve: Curves.easeIn),
      ),
    );

    // Background: Scale up + Fade in (AFTER title - delayed start)
    _backgroundScale = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.15, 0.55, curve: Curves.easeOutCubic),
      ),
    );
    _backgroundFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.15, 0.45, curve: Curves.easeIn),
      ),
    );

    // Logo: Zoom in from center (more dramatic elastic)
    _logoScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.25, 0.65, curve: Curves.elasticOut),
      ),
    );
    _logoFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.25, 0.55, curve: Curves.easeIn),
      ),
    );

    // Outline: Pulse effect (smoother)
    _outlinePulse =
        TweenSequence<double>([
          TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.15), weight: 1),
          TweenSequenceItem(tween: Tween(begin: 1.15, end: 1.0), weight: 1),
        ]).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.45, 0.85, curve: Curves.easeInOutCubic),
          ),
        );
    _outlineFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.45, 0.65, curve: Curves.easeIn),
      ),
    );

    // La Union Title: Slide up from bottom (delayed, smoother)
    _laUnionSlide = Tween<double>(begin: 60.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.70, 1.0, curve: Curves.easeOutCubic),
      ),
    );
    _laUnionFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.70, 0.95, curve: Curves.easeIn),
      ),
    );

    _controller.forward();

    // Complete loading after animation finishes (increased delay)
    Future.delayed(const Duration(milliseconds: 4500), () {
      if (mounted) {
        widget.onLoadingComplete();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Stack(
              alignment: Alignment.center,
              children: [
                // Layer 1: Main Logo Circle
                Transform.translate(
                  offset: const Offset(-5, 10), // Move left 5px and down 10px
                  child: Transform.scale(
                    scale: _logoScale.value,
                    child: Opacity(
                      opacity: _logoFade.value,
                      child: Image.asset(
                        'assets/images/logo/splash_loading/CircleLogoImage2.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                // Layer 2: Logo Outline
                Transform.scale(
                  scale: _outlinePulse.value,
                  child: Opacity(
                    opacity: _outlineFade.value,
                    child: Image.asset(
                      'assets/images/logo/splash_loading/CircleLogoImageOutline3.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                // Layer 3: Background
                Transform.scale(
                  scale: _backgroundScale.value,
                  child: Opacity(
                    opacity: _backgroundFade.value,
                    child: Image.asset(
                      'assets/images/logo/splash_loading/PupuseriaTitleBackground3.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                // Layer 4: La Union Title (above background)
                Transform.translate(
                  offset: Offset(0, _laUnionSlide.value),
                  child: Opacity(
                    opacity: _laUnionFade.value,
                    child: Image.asset(
                      'assets/images/logo/splash_loading/LaUnionTitle2.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                // Layer 5 (topmost): Pupuseria Title
                Transform.translate(
                  offset: Offset(0, _pupuseriaSlide.value),
                  child: Opacity(
                    opacity: _pupuseriaFade.value,
                    child: Image.asset(
                      'assets/images/logo/splash_loading/PupuseriaTitle1.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
