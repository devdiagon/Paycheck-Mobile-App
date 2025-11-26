import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../domain/entities/reporte.dart';
import '../widgets/pdf_header.dart';
import '../widgets/pdf_table.dart';

class ResumenEjecutivoPage {
  static pw.Page build(Reporte contenido) {
    final totalOperarios = contenido.datosOperarios.length;
    final sueldoTotalAnterior = contenido.datosOperarios
        .fold(0.0, (sum, op) => sum + op.result.salarioAnterior);
    final sueldoTotalFinal = contenido.datosOperarios
        .fold(0.0, (sum, op) => sum + op.result.sueldoFinal);
    final aumentoTotal = sueldoTotalFinal - sueldoTotalAnterior;
    final promedioAntiguedad = contenido.datosOperarios.isEmpty
        ? 0.0
        : contenido.datosOperarios.fold(0, (sum, op) => sum + op.antiguedad) /
        totalOperarios;

    return pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (context) => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          PdfHeader.build('Resumen Ejecutivo'),
          pw.SizedBox(height: 20),
          _buildResumenContainer(
            totalOperarios,
            promedioAntiguedad,
            sueldoTotalAnterior,
            sueldoTotalFinal,
            aumentoTotal,
          ),
          pw.SizedBox(height: 30),
          _buildDistribucionAntiguedad(contenido),
        ],
      ),
    );
  }

  static pw.Widget _buildResumenContainer(
      int totalOperarios,
      double promedioAntiguedad,
      double sueldoAnterior,
      double sueldoFinal,
      double aumento,
      ) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(15),
      decoration: pw.BoxDecoration(
        color: PdfColors.blue50,
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(8)),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          _buildResumenRow(
            'Total de operarios',
            totalOperarios.toString(),
            PdfColors.blue700,
          ),
          pw.Divider(height: 15, color: PdfColors.blue200),
          _buildResumenRow(
            'Promedio de antigüedad',
            '${promedioAntiguedad.toStringAsFixed(1)} años',
            PdfColors.blue700,
          ),
          pw.Divider(height: 15, color: PdfColors.blue200),
          _buildResumenRow(
            'Masa salarial anterior',
            '\$${sueldoAnterior.toStringAsFixed(2)}',
            PdfColors.orange700,
          ),
          pw.Divider(height: 15, color: PdfColors.blue200),
          _buildResumenRow(
            'Masa salarial actual',
            '\$${sueldoFinal.toStringAsFixed(2)}',
            PdfColors.green700,
          ),
          pw.Divider(height: 15, color: PdfColors.blue200),
          _buildResumenRow(
            'Aumento total',
            '\$${aumento.toStringAsFixed(2)}',
            PdfColors.red700,
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildResumenRow(String label, String value, PdfColor color) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(
          label,
          style: const pw.TextStyle(fontSize: 12, color: PdfColors.grey800),
        ),
        pw.Text(
          value,
          style: pw.TextStyle(
            fontSize: 14,
            fontWeight: pw.FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  static pw.Widget _buildDistribucionAntiguedad(Reporte contenido) {
    final distribucion = <int, int>{};
    for (var op in contenido.datosOperarios) {
      distribucion[op.antiguedad] = (distribucion[op.antiguedad] ?? 0) + 1;
    }

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Distribución por Antigüedad',
          style: pw.TextStyle(
            fontSize: 16,
            fontWeight: pw.FontWeight.bold,
            color: PdfColors.blue900,
          ),
        ),
        pw.SizedBox(height: 10),
        pw.Table(
          border: pw.TableBorder.all(color: PdfColors.blue200),
          children: [
            pw.TableRow(
              decoration: const pw.BoxDecoration(color: PdfColors.blue700),
              children: [
                PdfTable.buildCell('Antigüedad (años)', isHeader: true),
                PdfTable.buildCell('Cantidad', isHeader: true),
              ],
            ),
            ...distribucion.entries.map(
                  (entry) => pw.TableRow(
                children: [
                  PdfTable.buildCell(entry.key.toString()),
                  PdfTable.buildCell(entry.value.toString()),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}