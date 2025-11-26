import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';

import 'info_item.dart';
import '../../domain/entities/operario.dart';

class OperarioCard {
  static pw.Widget build(Operario operario) {
    final formatter = DateFormat('dd/MM/yyyy');
    final porcentajeColor = _getPorcentajeColor(operario.result.porcentaje);

    return pw.Container(
      margin: const pw.EdgeInsets.only(bottom: 15),
      padding: const pw.EdgeInsets.all(12),
      decoration: pw.BoxDecoration(
        color: PdfColors.grey100,
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(8)),
        border: pw.Border.all(color: PdfColors.blue200, width: 1),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          _buildHeader(operario, porcentajeColor),
          pw.SizedBox(height: 8),
          _buildInfoRow(operario),
          pw.SizedBox(height: 8),
          pw.Divider(color: PdfColors.blue200),
          pw.SizedBox(height: 8),
          _buildSalaryRow(operario),
          pw.SizedBox(height: 8),
          pw.Text(
            'Fecha de cálculo: ${formatter.format(operario.result.fecha)}',
            style: const pw.TextStyle(
              fontSize: 9,
              color: PdfColors.grey700,
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildHeader(Operario operario, PdfColor color) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(
          operario.nombre,
          style: pw.TextStyle(
            fontSize: 14,
            fontWeight: pw.FontWeight.bold,
            color: PdfColors.blue900,
          ),
        ),
        pw.Container(
          padding: const pw.EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 4,
          ),
          decoration: pw.BoxDecoration(
            color: color,
            borderRadius: const pw.BorderRadius.all(pw.Radius.circular(4)),
          ),
          child: pw.Text(
            '+${operario.result.porcentaje.toStringAsFixed(1)}%',
            style: pw.TextStyle(
              fontSize: 11,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.white,
            ),
          ),
        ),
      ],
    );
  }

  static pw.Widget _buildInfoRow(Operario operario) {
    return pw.Row(
      children: [
        pw.Expanded(
          child: InfoItem.build(
            'Antigüedad',
            '${operario.antiguedad} años',
            PdfColors.blue700,
          ),
        ),
        pw.Expanded(
          child: InfoItem.build(
            'ID',
            operario.id.substring(0, 8),
            PdfColors.grey600,
          ),
        ),
      ],
    );
  }

  static pw.Widget _buildSalaryRow(Operario operario) {
    return pw.Row(
      children: [
        pw.Expanded(
          child: InfoItem.build(
            'Salario anterior',
            '\$${operario.result.salarioAnterior.toStringAsFixed(2)}',
            PdfColors.orange700,
          ),
        ),
        pw.Expanded(
          child: InfoItem.build(
            'Aumento',
            '\$${operario.result.aumento.toStringAsFixed(2)}',
            PdfColors.red700,
          ),
        ),
        pw.Expanded(
          child: InfoItem.build(
            'Salario final',
            '\$${operario.result.sueldoFinal.toStringAsFixed(2)}',
            PdfColors.green700,
          ),
        ),
      ],
    );
  }

  static PdfColor _getPorcentajeColor(double porcentaje) {
    if (porcentaje >= 15) return PdfColors.green700;
    if (porcentaje >= 10) return PdfColors.orange700;
    return PdfColors.red700;
  }
}