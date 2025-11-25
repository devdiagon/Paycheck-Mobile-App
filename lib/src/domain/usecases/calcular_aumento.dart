import '../entities/operario.dart';
import '../entities/resultado_operario.dart';

class CalcularAumento {
  ResultadoOperario ejecutar(Operario op) {
    double aumento = 0;
    double porcentaje = 0;

    if (op.sueldo < 500) {
      if (op.antiguedad >= 10) {
        porcentaje = 0.20;
      } else {
        porcentaje = 0.05;
      }
      aumento = op.sueldo * porcentaje;
    }

    final sueldoFinal = op.sueldo + aumento;
    final fecha = DateTime.now();

    return ResultadoOperario(
      aumento: aumento,
      sueldoFinal: sueldoFinal,
      salarioAnterior: op.sueldo,
      fecha: fecha,
      porcentaje: porcentaje,
    );
  }
}
