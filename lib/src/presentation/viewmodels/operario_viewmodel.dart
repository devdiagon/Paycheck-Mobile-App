// EN operario_viewmodel.dart - ACTUALIZADO:
import 'package:flutter/material.dart';
import '../../domain/entities/operario.dart';
import '../../domain/entities/aumento_record.dart';
import '../../domain/entities/resultado_operario.dart';
import '../../domain/usecases/calcular_aumento.dart';

class OperarioViewModel extends ChangeNotifier {
  final List<Operario> _operarios = [];
  final CalcularAumento calcularAumento;

  OperarioViewModel(this.calcularAumento);

  List<Operario> get operarios => List.unmodifiable(_operarios);

  Operario? getById(String id) {
    for (var o in _operarios) {
      if (o.id == id) return o;
    }
    return null;
  }

  /// Crear operario con primer registro de aumento
  Operario crearOperario({
    required String nombre,
    required double sueldo,
    required int antiguedad,
  }) {
    final id = DateTime.now().microsecondsSinceEpoch.toString();
    final op = Operario(
      id: id,
      nombre: nombre,
      sueldo: sueldo,
      antiguedad: antiguedad,
    );

    // Crear primer registro de aumento (sueldo inicial)
    final primerRegistro = AumentoRecord(
      salarioAnterior: 0.0, // No tenía sueldo anterior
      salarioNuevo: sueldo,
      antiguedadAnterior: 0, // No tenía antigüedad anterior
      antiguedadNueva: antiguedad,
      fecha: DateTime.now(),
      aumento: sueldo, // El aumento es el sueldo completo (de 0 a sueldo)
    );

    op.historial.add(primerRegistro);
    _operarios.add(op);
    notifyListeners();
    return op;
  }

  /// Registrar aumento manualmente calculando el aumento real
  AumentoRecord registrarAumento(
      String operarioId, {
        required double nuevoSueldo,
        required int nuevaAntiguedad,
      }) {
    final op = getById(operarioId);
    if (op == null) throw Exception('Operario no encontrado');

    // Calcular el aumento según las reglas de negocio
    final resultadoAumento = calcularAumento.ejecutar(op);
    final aumentoCalculado = resultadoAumento.aumento;

    // El aumento real es la diferencia entre el nuevo sueldo y el actual
    final aumentoReal = nuevoSueldo - op.sueldo;

    final record = AumentoRecord(
      salarioAnterior: op.sueldo,
      salarioNuevo: nuevoSueldo,
      antiguedadAnterior: op.antiguedad,
      antiguedadNueva: nuevaAntiguedad,
      fecha: DateTime.now(),
      aumento: aumentoReal, // Usar el aumento real calculado
    );

    // Guardar historial
    op.historial.add(record);

    // Actualizar valores del operario
    op.sueldo = nuevoSueldo;
    op.antiguedad = nuevaAntiguedad;

    notifyListeners();
    return record;
  }

  /// Método alternativo que aplica el aumento calculado automáticamente
  AumentoRecord aplicarAumentoCalculado(
      String operarioId, {
        int? nuevaAntiguedad,
      }) {
    final op = getById(operarioId);
    if (op == null) throw Exception('Operario no encontrado');

    // Calcular el aumento usando el use case
    final resultado = calcularAumento.ejecutar(op);

    final nuevoSueldo = op.sueldo + resultado.aumento;
    final antiguedadFinal = nuevaAntiguedad ?? op.antiguedad;

    final record = AumentoRecord(
      salarioAnterior: op.sueldo,
      salarioNuevo: nuevoSueldo,
      antiguedadAnterior: op.antiguedad,
      antiguedadNueva: antiguedadFinal,
      fecha: DateTime.now(),
      aumento: resultado.aumento, // Usar el aumento calculado
    );

    // Guardar historial
    op.historial.add(record);

    // Actualizar valores del operario
    op.sueldo = nuevoSueldo;
    op.antiguedad = antiguedadFinal;

    notifyListeners();
    return record;
  }

  // Método para solo calcular aumento sin aplicarlo
  ResultadoOperario calcularAumentoOperario(String operarioId) {
    final op = getById(operarioId);
    if (op == null) throw Exception('Operario no encontrado');
    return calcularAumento.ejecutar(op);
  }
}