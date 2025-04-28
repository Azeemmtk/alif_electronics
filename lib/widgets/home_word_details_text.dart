import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeWordDetailsText extends StatelessWidget {
  HomeWordDetailsText({
    super.key,
    required this.color,
    required this.text,
  });

  String text;
  Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 15.5,
            fontWeight: FontWeight.bold,
            shadows: const [
              Shadow(
                  blurRadius: 10, color: Colors.black26, offset: Offset(2, 2))
            ],
            color: color),
      ),
    );
  }
}
