import 'package:alif_electronics/provider/spare_parts_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showTypeSelectionDialog(
  BuildContext context,
  SparePartsProvider provider, {
  required TextEditingController serviceChargeController,
  required List<Map<String, dynamic>> selectedParts,
  required VoidCallback onPartAdded, // Callback to trigger setState
}) {
  if (provider.dropdownItems.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('No spare part types available')),
    );
    return;
  }

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.blue[50],
        title: const Text('Select Spare Part Type'),
        content: SizedBox(
          width: MediaQuery.of(context).size.width<=394? double.maxFinite: (MediaQuery.of(context).size.width)/3.5 ,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: provider.dropdownItems.length,
            itemBuilder: (context, index) {
              final type = provider.dropdownItems[index];
              return ListTile(
                title: Text(type),
                onTap: () {
                  Navigator.pop(context);
                  showModelSelectionDialog(
                    context,
                    provider,
                    type,
                    serviceChargeController: serviceChargeController,
                    selectedParts: selectedParts,
                    onPartAdded: onPartAdded,
                  );
                },
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      );
    },
  );
}

void showModelSelectionDialog(
  BuildContext context,
  SparePartsProvider provider,
  String type, {
  required TextEditingController serviceChargeController,
  required List<Map<String, dynamic>> selectedParts,
  required VoidCallback onPartAdded,
}) {
  final models = provider.filteredSpareParts
      .where((part) => part.category == type)
      .toList();
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Select Model for $type'),
        content: SizedBox(
          width: double.maxFinite,
          child: models.isEmpty
              ? Padding(
                  padding: EdgeInsets.all(8.r),
                  child: const Text(
                    'There is no data, select another type',
                    style: TextStyle(color: Colors.red, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: models.length,
                  itemBuilder: (context, index) {
                    final model = models[index];
                    return ListTile(
                      title: Text(
                          '${model.model} (₹${model.price}, Stock: ${model.count})'),
                      onTap: () {
                        Navigator.pop(context);
                        showCountDialog(
                          context,
                          type,
                          model.model,
                          model.price,
                          model.count,
                          provider,
                          serviceChargeController: serviceChargeController,
                          selectedParts: selectedParts,
                          onPartAdded: onPartAdded,
                        );
                      },
                    );
                  },
                ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      );
    },
  );
}

void showCountDialog(
  BuildContext context,
  String type,
  String model,
  int price,
  int availableCount,
  SparePartsProvider provider, {
  required TextEditingController serviceChargeController,
  required List<Map<String, dynamic>> selectedParts,
  required VoidCallback onPartAdded,
}) {
  final TextEditingController countController = TextEditingController();
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Enter Count for $model'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Available: $availableCount'),
            TextField(
              controller: countController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Count'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              int? count = int.tryParse(countController.text);
              if (count != null && count > 0 && count <= availableCount) {
                selectedParts.add({
                  'type': type,
                  'model': model,
                  'price': price,
                  'count': count,
                  'serviceCharge':
                      double.tryParse(serviceChargeController.text) ?? 300.0,
                });
                onPartAdded(); // Trigger setState in PaymentSlipScreen
                Navigator.pop(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text('Enter a valid count (1-$availableCount)')),
                );
              }
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
