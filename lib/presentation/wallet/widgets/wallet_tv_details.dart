import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class WalletTvDetails extends StatelessWidget {
  const WalletTvDetails({
    super.key,
    required this.head,
    required this.data,
  });

  final String head;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          head,
          style: GoogleFonts.roboto(
            // color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          data,
          style: GoogleFonts.roboto(
            // color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}