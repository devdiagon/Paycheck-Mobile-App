import 'package:flutter/material.dart';
import '../../themes/color_schema.dart';

class ReportFab extends StatelessWidget {
  final bool enabled;
  final VoidCallback onPressed;

  const ReportFab({
    super.key,
    required this.enabled,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: enabled ? onPressed : null,
      backgroundColor: enabled ? SaintColors.dark_blue : Colors.grey,
      child: Icon(
        Icons.picture_as_pdf,
        color: enabled ? Colors.white : Colors.black,
      ),
    );
  }
}
