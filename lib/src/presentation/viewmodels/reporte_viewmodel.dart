import 'package:flutter/material.dart';
import '../../domain/usecases/generar_pdf.dart';
import '../../domain/entities/reporte.dart';
import '../../domain/entities/operario.dart';

class ReporteViewModel extends ChangeNotifier {
  final GenerarPdf useCase;

  ReporteViewModel(this.useCase);

  bool _puedeGenerarPdf = false;
  bool get puedeGenerarReporte => _puedeGenerarPdf;
  
  void actualizarPuedeGenerar(bool value) {
    _puedeGenerarPdf = value;
    notifyListeners();
  }

  Future<void> generarReporte(List<Operario> operarios) async {
    final reporte = Reporte(
      titulo: "Reporte de Operarios Registrados",
      datosOperarios: operarios,
    );

    await useCase(reporte);
  }
}
