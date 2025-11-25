import 'package:flutter/material.dart';

import '../../domain/entities/operario.dart';
import '../../domain/entities/resultado_operario.dart';
import '../../domain/usecases/calcular_aumento.dart';

class OperarioViewModel extends ChangeNotifier {
  final CalcularAumento _useCase;
  OperarioViewModel(this._useCase);
  final List<Operario> _operarios = [];
  List<Operario> get operarios => List.unmodifiable(_operarios);


  Operario crearOperario({
    required String nombre,
    required double sueldo,
    required int antiguedad,
  }) {
    // ID basado en la fecha y hora
    final id = DateTime.now().millisecondsSinceEpoch.toString();

    // Crear operario inicial (temporal)
    final op = Operario(
      id: id,
      nombre: nombre,
      sueldo: sueldo,
      antiguedad: antiguedad,
      result: ResultadoOperario(
        aumento: 0,
        sueldoFinal: sueldo,
        salarioAnterior: sueldo,
        fecha: DateTime.now(),
        porcentaje: 0,
      ),
    );

    // Calcular su primer aumento
    final resultado = _useCase.ejecutar(op);

    // Actualizar operario con el resultado del aumento
    op.sueldo = resultado.sueldoFinal;
    op.result = resultado;

    // Guardarlo en la lista
    _operarios.add(op);

    notifyListeners();

    return op;
  }

  /// ---------------------------------------------------------
  /// OBTENER OPERARIO POR ID (para la pantalla resultado)
  /// ---------------------------------------------------------
  Operario? getById(String id) {
    try {
      return _operarios.firstWhere((e) => e.id == id);
    } catch (e) {
      return null;
    }
  }

}
