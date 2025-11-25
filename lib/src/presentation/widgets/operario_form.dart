import 'package:flutter/material.dart';
import 'antiguedad_slider.dart';
import 'error_mesage.dart';

class OperarioForm extends StatelessWidget {
  final TextEditingController nombreController;
  final TextEditingController sueldoController;
  final int selectedYear;
  final String errorMsg;
  final ValueChanged<int> onYearChanged;
  final VoidCallback onCrearOperario;

  const OperarioForm({
    super.key,
    required this.nombreController,
    required this.sueldoController,
    required this.selectedYear,
    required this.errorMsg,
    required this.onYearChanged,
    required this.onCrearOperario,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: nombreController,
          decoration: const InputDecoration(
            labelText: 'Nombre del operario',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: sueldoController,
          decoration: const InputDecoration(
            labelText: 'Sueldo inicial',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.attach_money),
          ),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 8),
        ErrorMessage(errorText: errorMsg),
        const SizedBox(height: 8),
        AntiguedadSlider(
          selectedYear: selectedYear,
          onChanged: onYearChanged,
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onCrearOperario,
            child: const Text('Crear operario'),
          ),
        ),
      ],
    );
  }
}
