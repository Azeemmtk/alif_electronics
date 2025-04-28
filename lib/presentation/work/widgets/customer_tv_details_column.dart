import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../models/work/work_model.dart';

class CustomerTVDetailsColumn extends StatelessWidget {
  CustomerTVDetailsColumn({
    super.key,
    required this.data,
    required this.head,
    required this.value,
  });

  final WorkModel data;
  final String head;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          head,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black54,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 17,
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
      ],
    );
  }
}
