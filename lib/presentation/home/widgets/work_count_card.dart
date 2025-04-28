import 'package:alif_electronics/constants/conts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alif_electronics/provider/work_provider.dart';
import 'package:alif_electronics/widgets/home_word_details_text.dart';

class WorkCountCard extends StatelessWidget {
  const WorkCountCard({
    super.key,
    required this.workProvider,
  });

  final WorkProvider workProvider;

  @override
  Widget build(BuildContext context) {
    final h=MediaQuery.of(context).size.height;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 6,
      child: Container(
        height: 180,
        width: MediaQuery.of(context).size.width - 29.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13.5.r),
          color: Colors.blue[50],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            HomeWordDetailsText(
              text: 'Total Work\n${workProvider.totalWorks}',
              color: mainColor,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                HomeWordDetailsText(
                  text: 'Pending\n${workProvider.pendingWork.length}',
                  color: const Color(0xFFFB0069),
                ),
                HomeWordDetailsText(
                  text: 'In Progress\n${workProvider.inProgressWork.length}',
                  color: const Color(0xFFA3A539),
                ),
                HomeWordDetailsText(
                  text: 'Completed\n${workProvider.completedWork.length}',
                  color: const Color(0xFF326732),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
