import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../widgets/pdf_header.dart';
import '../widgets/pdf_footer.dart';
import '../widgets/operario_card.dart';
import '../../domain/entities/operario.dart';
import '../../domain/entities/reporte.dart';

class DetalleOperariosPage {
  static const operariosPorPagina = 6;

  static void buildPages(pw.Document pdf, Reporte contenido) {
    final totalPaginas =
    (contenido.datosOperarios.length / operariosPorPagina).ceil();

    for (int pagina = 0; pagina < totalPaginas; pagina++) {
      final inicio = pagina * operariosPorPagina;
      final fin = (inicio + operariosPorPagina < contenido.datosOperarios.length)
          ? inicio + operariosPorPagina
          : contenido.datosOperarios.length;

      final operariosPagina = contenido.datosOperarios.sublist(inicio, fin);

      pdf.addPage(_buildPage(operariosPagina, pagina, totalPaginas));
    }
  }

  static pw.Page _buildPage(
      List<Operario> operarios,
      int paginaActual,
      int totalPaginas,
      ) {
    return pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (context) => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          PdfHeader.build(
            'Detalle de Operarios (${paginaActual + 1}/$totalPaginas)',
          ),
          pw.SizedBox(height: 20),
          ...operarios.map((op) => OperarioCard.build(op)),
          pw.Spacer(),
          PdfFooter.build(paginaActual + 3, totalPaginas + 2),
        ],
      ),
    );
  }
}