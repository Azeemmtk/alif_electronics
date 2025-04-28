import 'package:alif_electronics/models/work/work_model.dart';
import 'package:alif_electronics/presentation/wallet/generate_pdf.dart';
import 'package:alif_electronics/widgets/custom_button.dart';
import 'package:alif_electronics/widgets/customsnackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:open_file/open_file.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:universal_html/html.dart' as html;

class ShareSaveAsPdfButton extends StatelessWidget {
  const ShareSaveAsPdfButton({
    super.key,
    required this.pdfgenerate,
    required this.data,
    required this.selectedParts,
    required this.serviceCharge,
    required this.totalAmount,
  });

  final GeneratePdf pdfgenerate;
  final WorkModel data;
  final List<Map<String, dynamic>> selectedParts;
  final double serviceCharge;
  final double totalAmount;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 15.h),
        CustomButton(
          text: 'Share',
          onTap: () async {
            try {
              if (kIsWeb) {
                // Web: Share via navigator.share or fallback to download
                final pdfBytes = await pdfgenerate.getPdfBytes(
                  workId: data.workId,
                  customerName: data.customerName,
                  phoneNumber: data.phoneNumber,
                  spareParts: selectedParts,
                  serviceCharge: serviceCharge,
                  advancePaid: data.advancePaid,
                  totalAmount: totalAmount,
                );
                final blob = html.Blob([pdfBytes], 'application/pdf');
                final url = html.Url.createObjectUrlFromBlob(blob);
                if (html.window.navigator.share != null) {
                  await html.window.navigator.share({
                    'title': 'Payment Slip - ${data.workId}',
                    'text': 'Here is the payment slip for Work ID: ${data.workId}',
                    'files': [
                      html.File([blob], 'invoice_${data.workId}.pdf',
                          {'type': 'application/pdf'})
                    ],
                  });
                  html.Url.revokeObjectUrl(url);
                  customSnackbar(
                      context: context, Message: 'PDF shared successfully');
                } else {
                  // Fallback to download if navigator.share is unavailable
                  final anchor = html.document.createElement('a') as html.AnchorElement
                    ..href = url
                    ..style.display = 'none'
                    ..download = 'invoice_${data.workId}.pdf';
                  html.document.body?.append(anchor);
                  anchor.click();
                  anchor.remove();
                  html.Url.revokeObjectUrl(url);
                  customSnackbar(
                      context: context, Message: 'PDF downloaded (sharing not supported)');
                }
              } else {
                // Mobile: Share via file
                final String pdfPath = await pdfgenerate.generateAndSavePdf(
                  workId: data.workId,
                  customerName: data.customerName,
                  phoneNumber: data.phoneNumber,
                  spareParts: selectedParts,
                  serviceCharge: serviceCharge,
                  advancePaid: data.advancePaid,
                  totalAmount: totalAmount,
                );
                await Share.shareXFiles(
                  [XFile(pdfPath)],
                  text: 'Here is the payment slip for Work ID: ${data.workId}',
                  subject: 'Payment Slip - ${data.workId}',
                );
                customSnackbar(
                    context: context, Message: 'PDF shared successfully');
              }
            } catch (e) {
              print('Error sharing PDF: $e');
              customSnackbar(
                  context: context, Message: 'Failed to share PDF: $e');
            }
          },
        ),
        SizedBox(height: 15.h),
        CustomButton(
          text: 'Save as pdf',
          icon: FontAwesomeIcons.solidFilePdf,
          onTap: () async {
            try {
              final String result = await pdfgenerate.generateAndSavePdf(
                workId: data.workId,
                customerName: data.customerName,
                phoneNumber: data.phoneNumber,
                spareParts: selectedParts,
                serviceCharge: serviceCharge,
                advancePaid: data.advancePaid,
                totalAmount: totalAmount,
              );
              if (kIsWeb) {
                // Web: PDF is downloaded
                customSnackbar(context: context, Message: 'PDF downloaded');
              } else {
                // Mobile: Open the saved PDF
                final openResult = await OpenFile.open(result);
                if (openResult.type != ResultType.done) {
                  customSnackbar(
                      context: context,
                      Message: 'Failed to open PDF: ${openResult.message}');
                } else {
                  customSnackbar(
                      context: context, Message: 'PDF saved and opened');
                }
              }
            } catch (e) {
              print('Error generating PDF: $e');
              customSnackbar(
                  context: context, Message: 'Failed to generate PDF: $e');
            }
          },
        ),
      ],
    );
  }
}