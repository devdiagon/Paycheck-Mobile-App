// EN operario.dart - CORREGIR:
import 'aumento_record.dart';

class Operario {
  final String id;
  final String nombre;

  double sueldo;
  int antiguedad;

  List<AumentoRecord> historial; // Quitar 'final'

  Operario({
    required this.id,
    required this.nombre,
    required this.sueldo,
    required this.antiguedad,
  }) : historial = []; // Inicializar correctamente
}