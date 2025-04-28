import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../models/work/work_model.dart';

class TvAndCustomerDetailColumn extends StatelessWidget {
  TvAndCustomerDetailColumn({
    super.key,
    required this.data,
    required this.head,
    required this.value,
  });

  final WorkModel data;
  final head;
  final value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(head,
            style: TextStyle(
                fontSize: 17,
                color:
                    Theme.of(context).colorScheme.onSurface.withOpacity(0.6))),
        Text(value,
            style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.w500,
                fontSize: 18)),
      ],
    );
  }
}
