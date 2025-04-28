import 'package:alif_electronics/constants/conts.dart';
import 'package:alif_electronics/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(context: context, icon: Icons.arrow_back, text: 'Terms of Service'),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Markdown(
            data: '''
# Terms of Service for Alif Electronics App

Last Updated: April 22, 2025

Welcome to the Alif Electronics App , developed by Alif Electronics. This App is designed as a single-user tool to manage your TV repair shop, including work orders, payment slips, reports, and image capture/selection from the camera or gallery. By downloading, installing, or using the App, you agree to be bound by these Terms of Service. If you do not agree, please do not use the App.

## 1. Acceptance of Terms
By accessing or using the App, you confirm that you are using it as a single user for personal or business purposes related to your TV repair shop. You acknowledge that the App is intended solely for your use and not for distribution or multi-user access.

## 2. License
We grant you a limited, non-exclusive, non-transferable, revocable license to use the App on your device for managing your TV repair shop. You may not:
- Modify, reverse-engineer, or decompile the App.
- Distribute, sublicense, or sell the App.
- Use the App for purposes other than TV repair shop management.

## 3. Data Usage and Storage
- **Local Storage**: The App uses Hive to store data locally on your device (e.g., work orders, payment details, images). We do not collect, transmit, or store this data.
- **Camera and Gallery Access**: The App requests permission to access your device’s camera and gallery to allow image capture or selection (e.g., for work order photos). These images are stored locally and used only within the App. You grant us permission to process these images for your repair shop management purposes.
- **Data Responsibility**: You are solely responsible for the accuracy and security of data entered or stored in the App, including images.

## 4. Permissions
- **Camera Access**: The App may request camera access to capture photos (e.g., of repaired TVs). You may revoke this permission in your device settings at any time.
- **Gallery Access**: The App may request gallery access to select existing images. You may revoke this permission in your device settings at any time.
- **Revocation**: Revoking permissions may limit certain features (e.g., image uploads).

## 5. User Conduct
You agree not to:
- Use the App to violate any laws or infringe on others’ rights.
- Introduce viruses or malicious code.
- Use images or data in the App for purposes beyond TV repair shop management.

## 6. Intellectual Property
The App and its content (e.g., charts, icons, design) are owned by us or our licensors and protected by copyright and other laws. You may not use our intellectual property without prior written consent.

## 7. Third-Party Services
The App uses third-party libraries (e.g., Flutter, Provider, fl_chart, Hive) under their respective licenses. We are not responsible for their performance or updates. Check their terms for details.

## 8. Disclaimer of Warranties
The App is provided "as is" without warranties of any kind, express or implied, including merchantability or fitness for a particular purpose. We do not guarantee uninterrupted or error-free operation.

## 9. Limitation of Liability
To the maximum extent permitted by law, we shall not be liable for any indirect, incidental, or consequential damages arising from your use of the App, including data loss, image corruption, or business interruption.

## 10. Termination
We may terminate or suspend your access to the App at our discretion, with or without notice, if you breach these Terms. Upon termination, your right to use the App ceases, and local data may be retained on your device unless manually deleted.

## 11. Changes to Terms
We may update these Terms periodically. Continued use of the App after changes constitutes acceptance of the new Terms. We will notify you of significant updates via the App.

## 12. Governing Law
These Terms are governed by the laws of [Your Country/State], without regard to conflict of law principles. Any disputes will be resolved in the courts of [Your Jurisdiction].

## 13. Contact Us
For questions or concerns, contact us at [Your Email Address] or [Your Support URL].

By using the App, you acknowledge that you have read, understood, and agree to be bound by these Terms of Service.
          ''',
            styleSheet: MarkdownStyleSheet(
              p: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.onBackground),
              h1: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: mainColor),
              h2: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: mainColor),
            ),
          ),
        ),
      ),
    );
  }
}