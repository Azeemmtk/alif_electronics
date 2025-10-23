import 'package:alif_electronics/constants/CONTs.dart';
import 'package:alif_electronics/presentation/about_screen.dart';
import 'package:alif_electronics/presentation/help_screen.dart';
import 'package:alif_electronics/presentation/terms_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> with SingleTickerProviderStateMixin {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isSelected = !isSelected;
            });
          },
          child: ListTile(
            leading: const Icon(Icons.settings, color: mainColor),
            title: const Text('Settings'),
            trailing: Icon(
              isSelected ? Icons.expand_less : Icons.expand_more,
              color:  mainColor,
            ),
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: isSelected
                ? const BoxConstraints()
                : const BoxConstraints(maxHeight: 0),
            child: Padding(
              padding: EdgeInsets.only(left: 20.w),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.article_outlined, color: mainColor),
                    title: const Text('Terms and Services'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (context) => const TermsScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.help_outline, color: mainColor),
                    title: const Text('Help'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (context) => const HelpScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.help_outline, color: mainColor),
                    title: const Text('About us'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (context) => const AboutScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
