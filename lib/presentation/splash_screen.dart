import 'dart:math';

import 'package:alif_electronics/constants/CONTs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:alif_electronics/presentation/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  double _logoScale = 0.0;
  double _titleOffset = 50.0;
  double _titleOpacity = 0.0;
  double _textOffset = 50.0;
  double _textOpacity = 0.0;
  double _staticOpacity = 0.8;
  bool _showIndicator = false;
  late AnimationController _controller;
  late Animation<double> _flickerAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    );

    _flickerAnimation = Tween<double>(begin: 0.2, end: 0.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic),
    );

    // Start the animation
    _controller.repeat(reverse: true);

    // Animation timeline
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        _titleOpacity = 1.0; // Fade in "Alif Electronics"
        _titleOffset = 0; // Slide "Alif Electronics" up
        _staticOpacity = 0.1; // Subtle static effect
      });
    });

    Future.delayed(const Duration(milliseconds: 900), () {
      setState(() {
        _logoScale = 1.0; // Scale in logo
      });
    });

    Future.delayed(const Duration(milliseconds: 1500), () {
      setState(() {
        _textOffset = 0; // Slide "Expert TV Repair" up
        _textOpacity = 1.0; // Fade in "Expert TV Repair"
      });
    });

    // Show circular indicator after 2300ms (when animations complete)
    Future.delayed(const Duration(milliseconds: 2300), () {
      setState(() {
        _showIndicator = true; // Show the progress indicator
      });
    });

    // Navigate to MainScreen after 4300ms (2300ms animations + 2000ms indicator)
    Future.delayed(const Duration(milliseconds: 4300), () {
      _controller.stop();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute<void>(
          builder: (context) => const MainScreen(),
        ),
      );
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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.grey[100]!, // Light grey for a clean look
              Colors.white.withOpacity(0.9), // Bright, professional white
            ],
          ),
        ),
        child: Stack(
          children: [
            AnimatedBuilder(
              animation: _flickerAnimation,
              builder: (context, child) {
                return Opacity(
                  opacity: _staticOpacity * _flickerAnimation.value,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05), // Subtler static
                      backgroundBlendMode: BlendMode.overlay,
                    ),
                    child: CustomPaint(
                      size: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
                      painter: StaticPainter(),
                    ),
                  ),
                );
              },
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 1500),
                    transform: Matrix4.identity()..scale(_logoScale),
                    curve: Curves.easeOutQuint,
                    child: SizedBox(
                      width: 150.w,
                      child: Image.asset('assets/images/appLogo.png'),
                    ),
                  ),
                  AnimatedOpacity(
                    opacity: _titleOpacity,
                    duration: const Duration(milliseconds: 1200),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 1200),
                      transform: Matrix4.translationValues(0, _titleOffset, 0),
                      curve: Curves.easeOutQuint,
                      child: Text(
                        'Alif Electronics',
                        style: GoogleFonts.roboto(
                          fontSize: 38.sp,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF589490),
                          letterSpacing: 1.3,
                          shadows: [
                            Shadow(
                              color: Colors.blueGrey.withOpacity(0.3),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  AnimatedOpacity(
                    opacity: _textOpacity,
                    duration: const Duration(milliseconds: 1200),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 1200),
                      transform: Matrix4.translationValues(0, _textOffset, 0),
                      curve: Curves.easeOutQuint,
                      child: Text(
                        'Expert TV Repair',
                        style: GoogleFonts.roboto(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF559f98),
                          letterSpacing: 1.2,
                          shadows: [
                            Shadow(
                              color: Colors.blueGrey.withOpacity(0.3),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  AnimatedOpacity(
                    opacity: _showIndicator ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 500),
                    child: SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF589490)),
                        strokeWidth: 2.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StaticPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.03)
      ..style = PaintingStyle.fill;

    final random = Random();
    for (int i = 0; i < 50; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      canvas.drawRect(
        Rect.fromLTWH(x, y, 1.5, 1.5),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}