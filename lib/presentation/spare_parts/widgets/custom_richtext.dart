import 'package:flutter/material.dart';

class CustomRichtext extends StatelessWidget {
  CustomRichtext({super.key, required this.mainText, required this.boldText});

  String mainText;
  String boldText;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
          text: mainText,
          style: TextStyle(
            fontSize: 16,
          ),
          children: [
            TextSpan(
              text: boldText,
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ]),
    );
  }
}
