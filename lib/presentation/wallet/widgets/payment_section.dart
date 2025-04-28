import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

import '../../../models/work/work_model.dart';
import '../../../provider/spare_parts_provider.dart';
import '../../../provider/wallet_provider.dart';
import '../../../provider/work_provider.dart';
import '../../../widgets/custom_button.dart';

class PaymentSection extends StatelessWidget {
  const PaymentSection({
    super.key,
    required this.totalAmount,
    required this.selectedParts,
    required this.sparePartsProvider,
    required this.workProvider,
    required this.data,
    required this.walletProvider,
  });

  final double totalAmount;
  final List<Map<String, dynamic>> selectedParts;
  final SparePartsProvider sparePartsProvider;
  final WorkProvider workProvider;
  final WorkModel data;
  final WalletProvider walletProvider;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: AlertDialog(
        backgroundColor: Colors.blue[50],
        title: const Text('Payment Options'),
        content: SizedBox(
          width: MediaQuery.of(context).size.width<=394? double.maxFinite: (MediaQuery.of(context).size.width)/3.5 ,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TabBar(
                labelColor: Theme.of(context).colorScheme.primary,
                unselectedLabelColor: Theme.of(context).colorScheme.onSurface,
                indicatorColor: Theme.of(context).colorScheme.primary,
                tabs: const [
                  Tab(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.qr_code),
                        SizedBox(width: 5),
                        Text('QR Code'),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.payment),
                        SizedBox(width: 8),
                        Text('Manual'),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 300.h,
                child: TabBarView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              height: 150,
                              width: 150,
                              child: PrettyQrView.data(
                                  data: 'Your amount is $totalAmount')),
                          const Text('Scan to Pay'),
                          CustomButton(
                            text: 'Paid',
                            onTap: () async {
                              print(
                                  'Selected parts before saving: $selectedParts');
                              if (selectedParts.isNotEmpty) {
                                for (var part in selectedParts) {
                                  sparePartsProvider.decreaseSparePartCount(
                                      part['model'], part['count']);
                                }
                                await workProvider.updatePaymentStatus(
                                  paymentStatus: 'Online payment',
                                  workId: data.workId,
                                  totalAmount: totalAmount,
                                );
                                await workProvider.saveSparePartsUsage(
                                    data.workId, selectedParts);
                                walletProvider.getAllWork();
                              }
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('Bank Details:'),
                          const Text('Account: 123456789'),
                          const Text('IFSC: ABC123'),
                          SizedBox(height: 10.h),
                          CustomButton(
                            text: 'Paid in cash',
                            onTap: () async {
                              print(
                                  'Selected parts before saving: $selectedParts');
                              if (selectedParts.isNotEmpty) {
                                for (var part in selectedParts) {
                                  sparePartsProvider.decreaseSparePartCount(
                                      part['model'], part['count']);
                                }
                                await workProvider.updatePaymentStatus(
                                  workId: data.workId,
                                  paymentStatus: 'Paid in cash',
                                  totalAmount: totalAmount,
                                );
                                await workProvider.saveSparePartsUsage(
                                    data.workId, selectedParts);
                                walletProvider.getAllWork();
                              }
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          SizedBox(
            width: 120.w,
            child: CustomButton(
              text: 'Cancel',
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
