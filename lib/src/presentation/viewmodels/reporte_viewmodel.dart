import 'package:flutter/material.dart';
import '../../domain/usecases/generar_pdf.dart';
import '../../domain/entities/reporte.dart';

class ReporteViewModel extends ChangeNotifier {
  final GenerarPdf _useCase;

  bool _canGenerateReport = false;
  bool get canGenerateReport => _canGenerateReport;

  ReporteViewModel(this._useCase);

  void updateCanGenerate(bool value) {
    _canGenerateReport = value;
    notifyListeners();
  }

  Future<void> generateReport() async {
    final report = Reporte(
      title: "Reporte del día",
      content: "Contenido del reporte...",
    );

    await _useCase(report);
  }
}
