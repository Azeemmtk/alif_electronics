import 'package:alif_electronics/presentation/spare_parts/screens/edit_component_screen.dart';
import 'package:alif_electronics/provider/spare_parts_provider.dart';
import 'package:alif_electronics/widgets/custom_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:alif_electronics/presentation/spare_parts/widgets/component/build_component_image.dart';
import 'package:alif_electronics/presentation/spare_parts/widgets/custom_richtext.dart';

class SeeAllComponentScreen extends StatelessWidget {
  const SeeAllComponentScreen({super.key});

  static const List<String> defaultCategories = [
    'Resistor',
    'Capacitor',
    'Transistor',
    'IC'
  ];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SparePartsProvider>(context);
    final newComponents = provider.dropdownItems
        .where((category) => !defaultCategories.contains(category))
        .toList();

    return Scaffold(
      appBar: customAppbar(
        context: context,
        icon: Icons.arrow_back,
        text: 'Newly Added Components',
      ),
      body: Padding(
        padding: EdgeInsets.all(15.r),
        child: newComponents.isEmpty
            ? const Center(child: Text('No newly added components available'))
            : ListView.separated(
                itemBuilder: (context, index) {
                  final category = newComponents[index];
                  final categoryProps = provider.customCategories[category] ??
                      {
                        'extra1': 'Property 1',
                        'extra2': 'Property 2',
                        'imagePath': 'Unknown',
                      };
                  final imagePath = categoryProps['imagePath'] ?? 'Unknown';

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (context) =>
                              EditComponentScreen(categoryToEdit: category),
                        ),
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: const BorderSide(color: CupertinoColors.systemGrey2),
                      ),
                      color: Colors.white,
                      elevation: 6,
                      child: Padding(
                        padding: EdgeInsets.all(9.r),
                        child: Row(
                          children: [
                            SizedBox(
                              height: 60,
                              width: 60,
                              child: buildImage(imagePath),
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    category,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                    ),
                                  ),
                                  CustomRichtext(
                                    mainText: '${categoryProps['extra1']} ',
                                    boldText: '',
                                  ),
                                  CustomRichtext(
                                    mainText: '${categoryProps['extra2']} ',
                                    boldText: '',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(height: 10.h),
                itemCount: newComponents.length,
              ),
      ),
    );
  }
}