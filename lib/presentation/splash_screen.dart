import 'package:alif_electronics/constants/conts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:alif_electronics/presentation/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _circleSize = 1.w;
  bool _showContent = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _circleSize =
            MediaQuery.of(context).size.height * 2; // Ensures full coverage
      });
    });

    Future.delayed(const Duration(milliseconds: 1500), () {
      setState(() {
        _showContent = true;
      });
    });

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute<void>(
          builder: (context) => MainScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(seconds: 1),
              width: _circleSize,
              height: _circleSize,
              decoration: const BoxDecoration(
                color: mainColor,
              ),
            ),
            if (_showContent)
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: 300, child: Image.asset('assets/images/logo.png')),
                  Positioned(
                      left: 65.w,
                      bottom: 0.h,
                      child: Text(
                        'Manage your shop',
                        style: GoogleFonts.stalinistOne(
                          fontSize: 16.sp,
                          color: logoColor.withOpacity(0.8),
                        ),
                      )),
                ],
              )
          ],
        ),
      ),
    );
  }
}
