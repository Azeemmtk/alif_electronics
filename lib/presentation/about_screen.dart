import 'package:alif_electronics/widgets/about_screen_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:alif_electronics/constants/conts.dart';
import 'package:alif_electronics/widgets/custom_appbar.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AboutScreenHelper helper= AboutScreenHelper();
    return Scaffold(
      appBar: customAppbar(
        context: context,
        icon: Icons.arrow_back,
        text: 'About Alif Electronics',
      ),
      body: Padding(
        padding: EdgeInsets.all(15.r),
        child: ListView(
          children: [
            SizedBox(
              child: Image.asset(
                'assets/images/logo tv.png',height: 120.h,
              ),
            ),
            SizedBox(height: 20.h,),
            Text(
              'Alif Electronics',
              style: GoogleFonts.roboto(
                fontSize: 24 ,
                fontWeight: FontWeight.bold,
                color: mainColor,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10.h),
            Text(
              'Your all-in-one solution for managing electronics repair and used TV sales.',
              style: GoogleFonts.roboto(
                fontSize: 16 ,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.h),
            // About Section
            Card(
              color: Colors.blue[50],
              elevation: 4,
              margin: EdgeInsets.only(bottom: 15.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
                side: BorderSide(color: Colors.grey.withOpacity(0.3)),
              ),
              child: Padding(
                padding: EdgeInsets.all(16.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'About the App',
                      style: GoogleFonts.roboto(
                        fontSize: 18 ,
                        fontWeight: FontWeight.bold,
                        color: mainColor,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'Alif Electronics is designed to streamline your business operations. Manage used TV inventory, track spare parts, handle payments, record expenses, and generate insightful reports with ease. Key features include:',
                      style: GoogleFonts.roboto(
                        fontSize: 16 ,
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.8),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    helper.buildBulletPoint(context,
                        'Used TV Management: Add, edit, and sell TVs with detailed tracking.'),
                    helper.buildBulletPoint(context,
                        'Spare Parts Inventory: Organize parts, upload via Excel, and monitor stock.'),
                    helper.buildBulletPoint(context,
                        'Payment Processing: Create payment slips, generate PDF invoices, and track statuses.'),
                    helper.buildBulletPoint(context,
                        'Expense Tracking: Record and categorize business expenses.'),
                    helper.buildBulletPoint(context,
                        'Reports: Visualize income trends and export monthly summaries.'),
                  ],
                ),
              ),
            ),
            // Version & Developer Info
            Card(
              elevation: 4,
              color: Colors.blue[50],
              margin: EdgeInsets.only(bottom: 15.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
                side: BorderSide(color: Colors.grey.withOpacity(0.3)),
              ),
              child: Padding(
                padding: EdgeInsets.all(16.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'App Information',
                      style: GoogleFonts.roboto(
                        fontSize: 18 ,
                        fontWeight: FontWeight.bold,
                        color: mainColor,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    helper.buildInfoRow(context, 'Version',
                        '1.0.0'), // Update with actual version
                    helper.buildInfoRow(
                        context, 'Developer', 'Alif Electronics Team'),
                    helper.buildInfoRow(context, 'Last Updated', 'April 2025'),
                  ],
                ),
              ),
            ),
            // Contact Info
            Card(
              color: Colors.blue[50],
              elevation: 4,
              margin: EdgeInsets.only(bottom: 15.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
                side: BorderSide(color: Colors.grey.withOpacity(0.3)),
              ),
              child: Padding(
                padding: EdgeInsets.all(16.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Contact Us',
                      style: GoogleFonts.roboto(
                        fontSize: 18 ,
                        fontWeight: FontWeight.bold,
                        color: mainColor,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    helper.buildInfoRow(
                        context, 'Email', 'support@alifelectronics.com'),
                    // _buildInfoRow(context, 'Website', 'www.alifelectronics.com'),
                    helper.buildInfoRow(context, 'Phone',
                        '984-640-3043'), // Update with actual contact
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              'Alif Electronics',
              style: GoogleFonts.roboto(
                fontSize: 16 ,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
