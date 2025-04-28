import 'package:alif_electronics/presentation/wallet/generate_pdf.dart';
import 'package:alif_electronics/presentation/wallet/widgets/add_used_spare_parts_details.dart';
import 'package:alif_electronics/presentation/wallet/widgets/advance_paid_total_widget.dart';
import 'package:alif_electronics/presentation/wallet/widgets/go_to_payment_button.dart';
import 'package:alif_electronics/presentation/wallet/widgets/no_spare-parts_used.dart';
import 'package:alif_electronics/presentation/wallet/widgets/pyment_slip_dialogue.dart';
import 'package:alif_electronics/presentation/wallet/widgets/share_save_as_pdf_button.dart';
import 'package:alif_electronics/presentation/wallet/widgets/show_used_spare_parts.dart';
import 'package:alif_electronics/presentation/wallet/widgets/spare_parts_type_selection_button.dart';
import 'package:alif_electronics/presentation/wallet/widgets/tv_other_details.dart';
import 'package:alif_electronics/provider/spare_parts_provider.dart';
import 'package:alif_electronics/provider/wallet_provider.dart';
import 'package:alif_electronics/provider/work_provider.dart';
import 'package:alif_electronics/widgets/custom_appbar.dart';
import 'package:alif_electronics/widgets/custom_textfiled.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class PaymentSlipScreen extends StatefulWidget {
  const PaymentSlipScreen({super.key, required this.index});
  final int index;

  @override
  State<PaymentSlipScreen> createState() => _PaymentSlipScreenState();
}

class _PaymentSlipScreenState extends State<PaymentSlipScreen> {
  List<Map<String, dynamic>> selectedParts = [];
  final _serviceChargeController = TextEditingController(text: '300');

  @override
  void initState() {
    super.initState();
    final workProvider = Provider.of<WorkProvider>(context, listen: false);
    final walletProvider = Provider.of<WalletProvider>(context, listen: false);
    final data = walletProvider.selectedTab == 0
        ? walletProvider.pendingPayment[widget.index]
        : walletProvider.completedPayment[widget.index];
    if (walletProvider.selectedTab == 1) {
      selectedParts = workProvider
          .getSparePartsForWork(data.workId)
          .map((usage) => {
                'type': usage.type,
                'model': usage.model,
                'price': usage.price,
                'count': usage.count,
                'serviceCharge': usage.serviceCharge ?? 300.0,
              })
          .toList();
      if (selectedParts.isNotEmpty) {
        _serviceChargeController.text =
            selectedParts.first['serviceCharge'].toString();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final GeneratePdf pdfgenerate = GeneratePdf();
    final walletProvider = Provider.of<WalletProvider>(context);
    final sparePartsProvider = Provider.of<SparePartsProvider>(context);
    final workProvider = Provider.of<WorkProvider>(context);
    final data = walletProvider.selectedTab == 0
        ? walletProvider.pendingPayment[widget.index]
        : walletProvider.completedPayment[widget.index];

    final double partsTotal = selectedParts.fold(
        0, (sum, part) => sum + (part['price'] * part['count']));
    final double serviceCharge = walletProvider.selectedTab == 0
        ? (double.tryParse(_serviceChargeController.text) ?? 300.0)
        : (selectedParts.isNotEmpty
            ? (selectedParts.first['serviceCharge'] ?? 300.0)
            : 300.0);
    final double totalAmount =
        partsTotal + serviceCharge - (int.parse(data.advancePaid));

    return Scaffold(
      appBar: customAppbar(
        context: context,
        icon: Icons.arrow_back,
        text: 'Payment slip',
      ),
      body: Padding(
        padding: EdgeInsets.all(15.r),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              TvOtherDetails(data: data),
              SizedBox(height: 20.h),
              Text('Spare parts used',
                  style: TextStyle(
                      fontSize: 17,
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.6))),
              SizedBox(height: 15.h),
              if (walletProvider.selectedTab == 0)
                selectedParts.isEmpty
                    ? const NoSparePsrtsUsed()
                    : AddUSedSparePartsDetails(selectedParts: selectedParts),
              if (walletProvider.selectedTab == 1)
                selectedParts.isEmpty
                    ? const NoSparePsrtsUsed()
                    : ShowUsedSpareParts(
                        selectedParts: selectedParts,
                      ),
              SizedBox(height: 15.h),
              if (walletProvider.selectedTab == 0)
                InkWell(
                  onTap: () => showTypeSelectionDialog(
                    context,
                    sparePartsProvider,
                    serviceChargeController: _serviceChargeController,
                    selectedParts: selectedParts,
                    onPartAdded: () => setState(() {}), // Trigger UI rebuild
                  ),
                  child: const SparePartsTypeSelectionButton(),
                ),
              SizedBox(height: 20.h),
              AdvancePaidTotalWidget(head: 'Advance Paid', data: '- ₹ ${data.advancePaid}/-'),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Service charge',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontWeight: FontWeight.w500,
                          fontSize: 18)),
                  walletProvider.selectedTab != 0
                      ? Text(
                          ' ₹ ${selectedParts.isNotEmpty ? selectedParts.first['serviceCharge'] : 300.0}/-',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontWeight: FontWeight.bold,
                              fontSize: 18))
                      : SizedBox(
                          height: 40.h,
                          width: 120.w,
                          child: CustomTextfiled(
                            control: _serviceChargeController,
                            isNum: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Required';
                              }
                              if (double.tryParse(value) == null) {
                                return 'Invalid number';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {}); // Live update totalAmount
                            },
                          ),
                        ),
                ],
              ),
              const Divider(),
              AdvancePaidTotalWidget(head: 'Total Amount', data: ' ₹ $totalAmount/-'),
              SizedBox(height: 15.h),
              if (walletProvider.selectedTab == 0)
                GoToPaymentButton(
                    serviceChargeController: _serviceChargeController,
                    selectedParts: selectedParts,
                    totalAmount: totalAmount,
                    sparePartsProvider: sparePartsProvider,
                    workProvider: workProvider,
                    data: data,
                    walletProvider: walletProvider),
              if (walletProvider.selectedTab == 1)
                ShareSaveAsPdfButton(
                    pdfgenerate: pdfgenerate,
                    data: data,
                    selectedParts: selectedParts,
                    serviceCharge: serviceCharge,
                    totalAmount: totalAmount),
            ],
          ),
        ),
      ),
    );
  }
}