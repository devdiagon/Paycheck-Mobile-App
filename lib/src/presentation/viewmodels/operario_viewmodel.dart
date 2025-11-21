import 'package:flutter/material.dart';
import '../../domain/entities/operario.dart';
import '../../domain/entities/resultado_operario.dart';
import '../../domain/usecases/calcular_aumento.dart';

class OperarioViewModel extends ChangeNotifier {
  final CalcularAumento _useCase;

  OperarioViewModel(this._useCase);

  ResultadoOperario? resultado;

  ResultadoOperario calcular(double sueldo, int antiguedad) {
    final op = Operario(sueldo: sueldo, antiguedad: antiguedad);
    resultado = _useCase.ejecutar(op);
    notifyListeners();
    return resultado!;
  }
}
