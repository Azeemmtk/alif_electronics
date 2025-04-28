import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SparePartsTypeSelectionButton extends StatelessWidget {
  const SparePartsTypeSelectionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.h,
      width: 80,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.r),
          color: Theme.of(context)
              .colorScheme
              .primary
              .withOpacity(0.1)),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('Type'),
          Icon(Icons.add_circle_outline, size: 20),
        ],
      ),
    );
  }
}