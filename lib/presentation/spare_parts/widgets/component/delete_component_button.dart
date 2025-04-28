import 'package:alif_electronics/presentation/spare_parts/screens/edit_component_screen.dart';
import 'package:alif_electronics/provider/spare_parts_provider.dart';
import 'package:alif_electronics/widgets/customsnackbar.dart';
import 'package:flutter/material.dart';

class DeleteComponentButton extends StatelessWidget {
  const DeleteComponentButton({
    super.key,
    required this.widget,
    required this.provider,
  });

  final EditComponentScreen widget;
  final SparePartsProvider provider;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        bool? confirmDelete = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Confirm Delete'),
            content: Text(
                'Are you sure you want to delete "${widget.categoryToEdit}"?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Delete',
                    style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        );

        if (confirmDelete == true) {
          await provider.deleteCategory(widget.categoryToEdit!);
          customSnackbar(
              context: context,
              Message: 'Component deleted successfully!');
          Navigator.pop(context);
        }
      },
      icon: const Icon(Icons.delete, color: Colors.red),
    );
  }
}