import 'dart:async';
import 'package:evencir_task/constants/app_texts.dart';
import 'package:evencir_task/screens/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _glowAnimation;
  Timer? _navigationTimer;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.65, curve: Curves.easeOutCubic),
    );

    _scaleAnimation = Tween<double>(begin: 0.82, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.75, curve: Curves.easeOutBack),
      ),
    );

    _glowAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 1.0, curve: Curves.easeInOut),
      ),
    );

    _controller.forward();

    _navigationTimer = Timer(
      const Duration(milliseconds: 2800),
      _navigateToHome,
    );
  }

  void _navigateToHome() {
    if (!mounted) return;
    _navigationTimer?.cancel();
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const HomeScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOutCubic,
            ),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 700),
      ),
    );
  }

  @override
  void dispose() {
    _navigationTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF070709),
      body: GestureDetector(
        onTap: _navigateToHome,
        child: Stack(
          children: [
            // Animated Center Content
            Center(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return FadeTransition(
                    opacity: _fadeAnimation,
                    child: Transform.scale(
                      scale: _scaleAnimation.value,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Emblem Container
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              // Pulsing Glow Aura (around icon only)
                              Container(
                                width: 110,
                                height: 110,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFF4855DF).withValues(
                                        alpha: 0.35 * _glowAnimation.value,
                                      ),
                                      blurRadius: 40,
                                      spreadRadius: 15,
                                    ),
                                    BoxShadow(
                                      color: const Color(0xFF00C896).withValues(
                                        alpha: 0.25 * _glowAnimation.value,
                                      ),
                                      blurRadius: 25,
                                      spreadRadius: 8,
                                    ),
                                  ],
                                ),
                              ),

                              // Emblem Outer Ring
                              Container(
                                width: 92,
                                height: 92,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF4855DF),
                                      Color(0xFF00C896),
                                      Color(0xFF00D2FF),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  border: Border.all(
                                    color: Colors.white.withValues(alpha: 0.2),
                                    width: 1.5,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(
                                        alpha: 0.5,
                                      ),
                                      blurRadius: 12,
                                      offset: const Offset(0, 6),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Container(
                                    width: 76,
                                    height: 76,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFF0F0F14),
                                    ),
                                    child: const Icon(
                                      Icons.bolt_rounded,
                                      size: 44,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 32),

                          // Brand Name
                          ShaderMask(
                            shaderCallback: (bounds) {
                              return const LinearGradient(
                                colors: [
                                  Colors.white,
                                  Color(0xFFE0E7FF),
                                  Color(0xFF86EFAC),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ).createShader(bounds);
                            },
                            child: Text(
                              AppTexts.appName,
                              style: GoogleFonts.manrope(
                                fontSize: 36,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 8.0,
                                color: Colors.white,
                              ),
                            ),
                          ),

                          const SizedBox(height: 12),

                          // Tagline with pill badge
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.06),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.12),
                                width: 1,
                              ),
                            ),
                            child: Text(
                              AppTexts.appTagline.toUpperCase(),
                              style: GoogleFonts.mulish(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 3.0,
                                color: const Color(0xFF00C896),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Bottom Loading Indicator & Version
            Positioned(
              bottom: size.height * 0.07,
              left: 0,
              right: 0,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return FadeTransition(
                    opacity: _fadeAnimation,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Animated progress indicator
                        SizedBox(
                          width: 140,
                          height: 3,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(2),
                            child: LinearProgressIndicator(
                              value: _controller.value,
                              backgroundColor: Colors.white.withValues(
                                alpha: 0.1,
                              ),
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                Color(0xFF00C896),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "v1.0 • Ready for training",
                          style: GoogleFonts.mulish(
                            color: Colors.white.withValues(alpha: 0.35),
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
