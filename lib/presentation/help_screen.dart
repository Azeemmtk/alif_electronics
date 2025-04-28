import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:alif_electronics/constants/conts.dart';
import 'package:alif_electronics/widgets/custom_appbar.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
        context: context,
        icon: Icons.arrow_back,
        text: 'Help & Guide',
      ),
      body: Padding(
        padding: EdgeInsets.all(15.r),
        child: ListView(
          children: [
            Text(
              'Welcome to Alif Electronics',
              style: GoogleFonts.roboto(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: mainColor,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              'This guide helps you navigate and use the app to manage your electronics repair and used TV sales business efficiently.',
              style: GoogleFonts.roboto(
                fontSize: 16,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
              ),
            ),
            SizedBox(height: 20.h),
            _buildSection(
              context,
              title: 'Used TVs',
              content: [
                'View available TVs in a grid on the Used TV Screen.',
                'Tap a TV to see details like brand, model, purchase date, and prices.',
                'Add a new TV via the Add Used TV Screen by entering brand, model, details, purchase date, and prices.',
                'Edit or mark a TV as sold from the details screen.',
                'Images can be added/updated for each TV.',
              ],
            ),
            _buildSection(
              context,
              title: 'Spare Parts',
              content: [
                'Manage spare parts (e.g., Resistors, Capacitors) in the Spare Parts Screen.',
                'Search for parts by category or model.',
                'Add new parts with details like category, model, properties, price, and stock count.',
                'Edit or delete parts, and update stock counts.',
                'Upload spare parts data via Excel files (follow the format in the Instructions screen).',
                'Manage custom component categories for non-default parts.',
              ],
            ),
            _buildSection(
              context,
              title: 'Wallet & Payments',
              content: [
                'Track pending and completed payments in the Wallet Screen.',
                'View payment details, including TV info, customer name, and status.',
                'Create a payment slip to add spare parts used, service charge, and calculate the total (minus advance paid).',
                'Complete payments via QR code or manual methods (e.g., cash, bank transfer).',
                'Generate and share PDF invoices for completed payments.',
              ],
            ),
            _buildSection(
              context,
              title: 'Expenses',
              content: [
                'Record expenses in the Expense Screen to track costs.',
                'Add expenses with details like amount, category, and date.',
                'Edit or delete existing expenses.',
                'Expenses are included in financial reports for profit/loss calculations.',
              ],
            ),
            _buildSection(
              context,
              title: 'Reports',
              content: [
                'View business insights in the Report Screen.',
                'Analyze income trends with monthly/weekly charts.',
                'Generate a Monthly Report PDF summarizing profits, expenses, repairs, payments, and spare parts usage.',
                'Filter sales and services by date range to calculate total income.',
                'Monitor repair statuses (completed, pending, in-progress).',
              ],
            ),
            _buildSection(
              context,
              title: 'Tips for Best Use',
              content: [
                'Ensure all required fields (e.g., price, count) are valid when adding TVs or parts.',
                'Regularly update spare parts stock to avoid overselling.',
                'Use the search feature to quickly find TVs or parts.',
                'Back up Hive database files to prevent data loss.',
                'Check storage permissions for PDF generation and Excel uploads.',
              ],
            ),
            SizedBox(height: 20.h),
            Text(
              'Need More Help?',
              style: GoogleFonts.roboto(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: mainColor,
              ),
            ),
            SizedBox(height: 5.h),
            Text(
              'Contact our support team at support@alifelectronics.com or visit our shop (ALIF ELECTRONICS, j.T Road, Vadakara, Calicut ).',
              style: GoogleFonts.roboto(
                fontSize: 16,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, {required String title, required List<String> content}) {
    return Card(
      color: Colors.blue[50],
      elevation: 4,
      margin: EdgeInsets.only(bottom: 15.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
        side: BorderSide(color: Colors.grey.withOpacity(0.3)),
      ),
      child: ExpansionTile(
        title: Text(
          title,
          style: GoogleFonts.roboto(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: mainColor,
          ),
        ),
        children: content
            .map(
              (item) => Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '• ',
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                Expanded(
                  child: Text(
                    item,
                    style: GoogleFonts.roboto(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
            .toList(),
      ),
    );
  }
}