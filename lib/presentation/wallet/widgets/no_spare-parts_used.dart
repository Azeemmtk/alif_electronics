import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoSparePsrtsUsed extends StatelessWidget {
  const NoSparePsrtsUsed({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text('No spare parts selected',
        style: TextStyle(
            fontSize: 16,
            color: Theme.of(context)
                .colorScheme
                .onSurface
                .withOpacity(0.6)));
  }
}