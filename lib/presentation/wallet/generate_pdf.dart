import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:typed_data';
import 'package:universal_html/html.dart' as html;
import 'package:intl/intl.dart';

class GeneratePdf {
  Future<String> generateAndSavePdf({
    required String workId,
    required String customerName,
    required String phoneNumber,
    required List<Map<String, dynamic>> spareParts,
    required double serviceCharge,
    required String advancePaid,
    required double totalAmount,
  }) async {
    final pdfBytes = await _generatePdfBytes(
      workId: workId,
      customerName: customerName,
      phoneNumber: phoneNumber,
      spareParts: spareParts,
      serviceCharge: serviceCharge,
      advancePaid: advancePaid,
      totalAmount: totalAmount,
    );

    if (kIsWeb) {
      // Web: Trigger browser download
      final blob = html.Blob([pdfBytes]);
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.document.createElement('a') as html.AnchorElement
        ..href = url
        ..style.display = 'none'
        ..download = 'invoice_$workId.pdf';
      html.document.body?.append(anchor);
      anchor.click();
      anchor.remove();
      html.Url.revokeObjectUrl(url);
      return 'invoice_downloaded';
    } else {
      // Mobile: Save to external storage
      final directory = await getExternalStorageDirectory();
      final file = File('${directory!.path}/invoice_$workId.pdf');
      await file.writeAsBytes(pdfBytes);
      print('PDF saved at: ${file.path}');
      return file.path;
    }
  }

  Future<Uint8List> getPdfBytes({
    required String workId,
    required String customerName,
    required String phoneNumber,
    required List<Map<String, dynamic>> spareParts,
    required double serviceCharge,
    required String advancePaid,
    required double totalAmount,
  }) async {
    return await _generatePdfBytes(
      workId: workId,
      customerName: customerName,
      phoneNumber: phoneNumber,
      spareParts: spareParts,
      serviceCharge: serviceCharge,
      advancePaid: advancePaid,
      totalAmount: totalAmount,
    );
  }

  Future<Uint8List> _generatePdfBytes({
    required String workId,
    required String customerName,
    required String phoneNumber,
    required List<Map<String, dynamic>> spareParts,
    required double serviceCharge,
    required String advancePaid,
    required double totalAmount,
  }) async {
    final pdf = pw.Document();

    final fontData = await rootBundle.load('assets/fonts/Roboto-Regular.ttf');
    final ttf = pw.Font.ttf(fontData);

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Invoice',
                style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                  font: ttf,
                ),
              ),
              pw.SizedBox(height: 10),
              pw.Text(
                'Invoice ID: $workId',
                style: pw.TextStyle(fontSize: 16, font: ttf),
              ),
              pw.SizedBox(height: 20),
              pw.Text(
                'Customer Details',
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                  font: ttf,
                ),
              ),
              pw.SizedBox(height: 5),
              pw.Text('Name: $customerName', style: pw.TextStyle(font: ttf)),
              pw.Text('Phone: $phoneNumber', style: pw.TextStyle(font: ttf)),
              pw.SizedBox(height: 20),
              pw.Text(
                'Spare Parts Used',
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                  font: ttf,
                ),
              ),
              pw.SizedBox(height: 5),
              if (spareParts.isEmpty)
                pw.Text('No spare parts used', style: pw.TextStyle(font: ttf))
              else
                pw.Table(
                  border: pw.TableBorder.all(),
                  columnWidths: {
                    0: const pw.FlexColumnWidth(2),
                    1: const pw.FlexColumnWidth(2),
                    2: const pw.FlexColumnWidth(1),
                    3: const pw.FlexColumnWidth(2),
                  },
                  children: [
                    pw.TableRow(
                      children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(
                            'Type',
                            style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold, font: ttf),
                            textAlign: pw.TextAlign.center,
                          ),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(
                            'Model',
                            style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold, font: ttf),
                            textAlign: pw.TextAlign.center,
                          ),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(
                            'Count',
                            style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold, font: ttf),
                            textAlign: pw.TextAlign.center,
                          ),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(
                            'Price',
                            style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold, font: ttf),
                            textAlign: pw.TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    ...spareParts.map((part) => pw.TableRow(
                      children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(
                            part['type'],
                            style: pw.TextStyle(font: ttf),
                            textAlign: pw.TextAlign.center,
                          ),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(
                            part['model'] ?? '',
                            style: pw.TextStyle(font: ttf),
                            textAlign: pw.TextAlign.center,
                          ),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(
                            part['count'].toString(),
                            style: pw.TextStyle(font: ttf),
                            textAlign: pw.TextAlign.center,
                          ),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(
                            '₹${part['price'] * part['count']}',
                            style: pw.TextStyle(font: ttf),
                            textAlign: pw.TextAlign.center,
                          ),
                        ),
                      ],
                    )),
                  ],
                ),
              pw.SizedBox(height: 20),
              pw.Text(
                'Charges',
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                  font: ttf,
                ),
              ),
              pw.SizedBox(height: 5),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Service Charge', style: pw.TextStyle(font: ttf)),
                  pw.Text('₹$serviceCharge', style: pw.TextStyle(font: ttf)),
                ],
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Advance Paid', style: pw.TextStyle(font: ttf)),
                  pw.Text('-₹$advancePaid', style: pw.TextStyle(font: ttf)),
                ],
              ),
              pw.Divider(),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Total Amount',
                    style:
                    pw.TextStyle(fontWeight: pw.FontWeight.bold, font: ttf),
                  ),
                  pw.Text(
                    '₹$totalAmount',
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

    return await pdf.save();
  }
}