import 'package:pdf/widgets.dart' as pw;
import 'dart:io';
import '../entities/reporte.dart';

class GenerarPdf {
  Future<String> call(Reporte data) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (context) => pw.Center(
          child: pw.Text(data.title),
        ),
      ),
    );

    final output = await File("/storage/emulated/0/Download/reporte_operarios.pdf")
        .writeAsBytes(await pdf.save());

    return output.path;
  }
}