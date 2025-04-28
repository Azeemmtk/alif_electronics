import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ExcelFormatRow extends StatelessWidget {
  ExcelFormatRow({super.key, required this.text, required this.column});
  int column;
  String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Column $column: ',
          style: GoogleFonts.roboto(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.roboto(
              fontSize: 17,
              fontWeight: FontWeight.w400,
            ),
            softWrap: true,
          ),
        ),
      ],
    );
  }
}
