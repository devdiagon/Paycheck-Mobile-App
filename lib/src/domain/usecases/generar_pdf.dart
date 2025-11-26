import 'package:pdf/widgets.dart' as pw;

import '../entities/reporte.dart';
import '../../pdf/utils/pdf_saver.dart';
import '../../pdf/pages/detalle_operarios_page.dart';
import '../../pdf/pages/resumen_ejecutivo.dart';

class GenerarPdf {
  final PdfSaver _saver = PdfSaver();

  Future<String> call(Reporte contenido) async {
    final pdf = pw.Document();

    // Construir páginas de PDF
    pdf.addPage(ResumenEjecutivoPage.build(contenido));
    DetalleOperariosPage.buildPages(pdf, contenido);

    // Guardar PDF
    final filePath = await _saver.savePdf(pdf, 'reporte_operarios.pdf');
    await _saver.openPdf(filePath);

    return filePath;
  }
}