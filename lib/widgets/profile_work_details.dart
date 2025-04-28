import 'package:alif_electronics/provider/work_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileWorkDetails extends StatelessWidget {
  const ProfileWorkDetails({
    super.key,
    required this.workProvider,
  });

  final WorkProvider workProvider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 30.h,
        ),
        const Text(
          'Total work completed',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '${workProvider.completedWork.length}',
          style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey),
        ),
        SizedBox(
          height: 10.h,
        ),
        const Text(
          'Pending works',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '${workProvider.pendingWork.length}',
          style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey),
        ),
        SizedBox(
          height: 10.h,
        ),
        const Text(
          'In progress',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '${workProvider.inProgressWork.length}',
          style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey),
        ),
      ],
    );
  }
}