import 'package:alif_electronics/models/spare_parts/spare_parts_model.dart';
import 'package:alif_electronics/provider/spare_parts_provider.dart';
import 'package:alif_electronics/widgets/custom_button.dart';
import 'package:alif_electronics/widgets/customsnackbar.dart';
import 'package:flutter/material.dart';

class AddSparePartsButton extends StatelessWidget {
  const AddSparePartsButton({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.provider,
    required TextEditingController modelController,
    required TextEditingController pro1Controller,
    required TextEditingController pro2Controller,
    required TextEditingController locationController,
    required TextEditingController priceController,
    required TextEditingController countController,
  })  : _formKey = formKey,
        _modelController = modelController,
        _pro1Controller = pro1Controller,
        _pro2Controller = pro2Controller,
        _locationController = locationController,
        _priceController = priceController,
        _countController = countController;

  final GlobalKey<FormState> _formKey;
  final SparePartsProvider provider;
  final TextEditingController _modelController;
  final TextEditingController _pro1Controller;
  final TextEditingController _pro2Controller;
  final TextEditingController _locationController;
  final TextEditingController _priceController;
  final TextEditingController _countController;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: 'Add',
      onTap: () async {
        if (_formKey.currentState!.validate()) {
          final data = SparepartsModel(
            category: provider.selectedValue!,
            model: provider.selectedValue == 'Resistor'
                ? '${_modelController.text}Ω'
                : provider.selectedValue == 'Capacitor'
                ? '${_pro1Controller.text}µF/ ${_pro2Controller.text}v'
                : _modelController.text,
            location: _locationController.text,
            price: int.parse(_priceController.text),
            count: int.parse(_countController.text),
            extra1: _pro1Controller.text,
            extra2: _pro2Controller.text,
            img: provider.selectedValue == 'Resistor'
                ? 'assets/images/resister.png'
                : provider.selectedValue == 'Capacitor'
                ? 'assets/images/capasotor.png'
                : provider.selectedValue == 'Transistor'
                ? 'assets/images/trasnsister.png'
                : provider.selectedValue == 'IC'
                ? 'assets/images/ic.png'
                : provider.imageFile?.path ?? 'Unknown',
          );
          await provider.dbFunctions.addSparePart(data, _modelController.text);
          customSnackbar(
              context: context, Message: 'Spare parts added successfully!');
          provider.loadAllData(); // Reload data to sync dropdownItems
          _modelController.clear();
          _pro1Controller.clear();
          _pro2Controller.clear();
          _locationController.clear();
          _priceController.clear();
          _countController.clear();
        }
      },
    );
  }
}
