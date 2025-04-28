import 'package:alif_electronics/presentation/spare_parts/screens/edit_spare_parts_screen.dart';
import 'package:alif_electronics/provider/spare_parts_provider.dart';
import 'package:alif_electronics/widgets/custom_build_show_dialoge.dart';
import 'package:alif_electronics/widgets/customsnackbar.dart';
import 'package:flutter/material.dart';

class DeleteSparePartsButton extends StatelessWidget {
  const DeleteSparePartsButton({
    super.key,
    required this.widget,
    required this.provider,
  });

  final EditSparePartsScreen widget;
  final SparePartsProvider provider;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        bool? confirmDelete = await custombuildShowDialog(
          context: context,
          mainText: 'Confirm Delete',
          subText: 'Are you sure you want to delete ',
          dataText: '${widget.data.category} ${widget.data.model}',
          btnText: 'Delete',
          confirmAction: () {
            Navigator.pop(context, true);
          },
        );

        if (confirmDelete == true) {
          await provider.deleteSpareParts(widget.data.model);
          customSnackbar(
              context: context, Message: 'Spare part deleted successfully');
          Navigator.pop(context);
        }
      },
      icon: const Icon(
        Icons.delete,
        color: Colors.red,
      ),
    );
  }
}