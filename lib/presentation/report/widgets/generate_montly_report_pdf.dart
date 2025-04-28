import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:typed_data';

// Conditionally import dart:html for web only
import 'package:universal_html/html.dart' as html;

class GenerateMonthlyReportPdf {
  Future<String> generateAndSavePdf({
    required double totalIncome,
    required double totalExpense,
    required double netProfit,
    required double completedWorks,
    required double pendingWorks,
    required double inProgressWorks,
    required double cancelledWorks,
    required double totalReceived,
    required double pendingAmount,
    required double purchasedExpense,
    required double totalUsed,
    required double totalTvSold,
    required double availableTv,
    required double tvIncome,
  }) async {
    final pdf = pw.Document();

    // Load the custom font from assets
    final fontData = await rootBundle.load('assets/fonts/Roboto-Regular.ttf');
    final ttf = pw.Font.ttf(fontData);

    // Add a page to the PDF
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Monthly Report',
                style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                  font: ttf,
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Text(
                'Total Income and Expense',
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                  font: ttf,
                ),
              ),
              pw.SizedBox(height: 10),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Total Income', style: pw.TextStyle(font: ttf)),
                  pw.Text('₹$totalIncome', style: pw.TextStyle(font: ttf)),
                ],
              ),
              pw.SizedBox(height: 5),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Total Expense', style: pw.TextStyle(font: ttf)),
                  pw.Text('₹$totalExpense', style: pw.TextStyle(font: ttf)),
                ],
              ),
              pw.Divider(),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    netProfit > 0 ? 'Net Profit' : 'Net Loss',
                    style:
                    pw.TextStyle(fontWeight: pw.FontWeight.bold, font: ttf),
                  ),
                  pw.Text(
                    '₹${netProfit.abs()}',
                    style:
                    pw.TextStyle(fontWeight: pw.FontWeight.bold, font: ttf),
                  ),
                ],
              ),
              pw.SizedBox(height: 20),
              pw.Text(
                'Repair Summary',
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                  font: ttf,
                ),
              ),
              pw.SizedBox(height: 10),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Total Repair Completed',
                      style: pw.TextStyle(font: ttf)),
                  pw.Text('${completedWorks.toInt()}',
                      style: pw.TextStyle(font: ttf)),
                ],
              ),
              pw.SizedBox(height: 5),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Pending Works', style: pw.TextStyle(font: ttf)),
                  pw.Text('${pendingWorks.toInt()}',
                      style: pw.TextStyle(font: ttf)),
                ],
              ),
              pw.SizedBox(height: 5),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Started Works', style: pw.TextStyle(font: ttf)),
                  pw.Text('${inProgressWorks.toInt()}',
                      style: pw.TextStyle(font: ttf)),
                ],
              ),
              pw.SizedBox(height: 5),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Work Cancelled', style: pw.TextStyle(font: ttf)),
                  pw.Text('${cancelledWorks.toInt()}',
                      style: pw.TextStyle(font: ttf)),
                ],
              ),
              pw.SizedBox(height: 20),
              pw.Text(
                'Payment Reports',
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                  font: ttf,
                ),
              ),
              pw.SizedBox(height: 10),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Total Amount Received',
                      style: pw.TextStyle(font: ttf)),
                  pw.Text('₹$totalReceived', style: pw.TextStyle(font: ttf)),
                ],
              ),
              pw.SizedBox(height: 5),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Pending Amount', style: pw.TextStyle(font: ttf)),
                  pw.Text('₹$pendingAmount', style: pw.TextStyle(font: ttf)),
                ],
              ),
              pw.SizedBox(height: 20),
              pw.Text(
                'Spare Parts Report',
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                  font: ttf,
                ),
              ),
              pw.SizedBox(height: 10),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Purchased Expense', style: pw.TextStyle(font: ttf)),
                  pw.Text('₹$purchasedExpense', style: pw.TextStyle(font: ttf)),
                ],
              ),
              pw.SizedBox(height: 5),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Total Used', style: pw.TextStyle(font: ttf)),
                  pw.Text('₹$totalUsed', style: pw.TextStyle(font: ttf)),
                ],
              ),
              pw.SizedBox(height: 20),
              pw.Text(
                'Used TV\'s Report',
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                  font: ttf,
                ),
              ),
              pw.SizedBox(height: 10),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Total TV Sold', style: pw.TextStyle(font: ttf)),
                  pw.Text('${totalTvSold.toInt()}',
                      style: pw.TextStyle(font: ttf)),
                ],
              ),
              pw.SizedBox(height: 5),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Available', style: pw.TextStyle(font: ttf)),
                  pw.Text('${availableTv.toInt()}',
                      style: pw.TextStyle(font: ttf)),
                ],
              ),
              pw.Divider(),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Income from Used TV',
                    style:
                    pw.TextStyle(fontWeight: pw.FontWeight.bold, font: ttf),
                  ),
                  pw.Text(
                    '₹$tvIncome',
                    style:
                    pw.TextStyle(fontWeight: pw.FontWeight.bold, font: ttf),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );

    // Generate PDF bytes
    final pdfBytes = await pdf.save();

    if (kIsWeb) {
      // Web: Trigger browser download
      final blob = html.Blob([pdfBytes]);
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.document.createElement('a') as html.AnchorElement
        ..href = url
        ..style.display = 'none'
        ..download = 'monthly_report_${DateTime.now().millisecondsSinceEpoch}.pdf';
      html.document.body?.append(anchor);
      anchor.click();
      anchor.remove(); // Remove the anchor element directly
      html.Url.revokeObjectUrl(url);
      return 'monthly_report_downloaded';
    } else {
      // Mobile: Save to external storage
      final directory = await getExternalStorageDirectory();
      final file = File(
          '${directory!.path}/monthly_report_${DateTime.now().millisecondsSinceEpoch}.pdf');
      await file.writeAsBytes(pdfBytes);
      print('PDF saved at: ${file.path}');
      return file.path;
    }
  }
}