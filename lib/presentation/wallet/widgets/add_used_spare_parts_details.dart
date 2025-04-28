import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddUSedSparePartsDetails extends StatelessWidget {
  const AddUSedSparePartsDetails({
    super.key,
    required this.selectedParts,
  });

  final List<Map<String, dynamic>> selectedParts;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: selectedParts
          .map((part) => Padding(
        padding: EdgeInsets.only(top: 10.h),
        child: Row(
          mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 80.w,
              child: Text('${part['type']} (${part['count']})',
                  style: TextStyle(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface,
                      fontWeight: FontWeight.w500,
                      fontSize: 18)),
            ),
            Expanded(
              child: Center(
                child: Text(part['model'] ?? '',
                    style: TextStyle(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface,
                        fontWeight: FontWeight.w500,
                        fontSize: 18)),
              ),
            ),
            SizedBox(
              width: 80.w,
              child: Align(
                alignment: Alignment.topRight,
                child: Text(
                    ' ₹ ${part['price'] * part['count']}/-',
                    style: TextStyle(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface,
                        fontWeight: FontWeight.bold,
                        fontSize: 18)),
              ),
            ),
          ],
        ),
      ))
          .toList(),
    );
  }
}
