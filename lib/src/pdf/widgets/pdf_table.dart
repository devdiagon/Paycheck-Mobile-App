import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfTable {
  static pw.Widget buildCell(String text, {bool isHeader = false}) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(8),
      child: pw.Text(
        text,
        style: pw.TextStyle(
          fontSize: isHeader ? 11 : 10,
          fontWeight: isHeader ? pw.FontWeight.bold : pw.FontWeight.normal,
          color: isHeader ? PdfColors.white : PdfColors.grey800,
        ),
        textAlign: pw.TextAlign.center,
      ),
    );
  }
}