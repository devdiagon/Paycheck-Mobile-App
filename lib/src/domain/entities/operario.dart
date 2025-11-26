import 'resultado_operario.dart';

class Operario {
  final String id;
  final String nombre;

  double sueldo;
  int antiguedad;
  ResultadoOperario result;

  Operario({
    required this.id,
    required this.nombre,
    required this.sueldo,
    required this.antiguedad,
    required this.result,
  });
}