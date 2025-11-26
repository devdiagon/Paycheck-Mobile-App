import 'package:flutter/material.dart';

class AntiguedadSlider extends StatelessWidget {
  final int selectedYear;
  final ValueChanged<int> onChanged;

  const AntiguedadSlider({
    super.key,
    required this.selectedYear,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Antigüedad (años): $selectedYear',
          style: const TextStyle(fontSize: 16),
        ),
        Slider(
          value: selectedYear.toDouble(),
          min: 1,
          max: 10,
          divisions: 9,
          label: '$selectedYear',
          onChanged: (value) => onChanged(value.toInt()),
        ),
      ],
    );
  }
}
