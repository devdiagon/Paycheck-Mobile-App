import '../entities/operario.dart';
import '../entities/resultado_operario.dart';

// Lógica de programación

class CalcularAumento{
  ResultadoOperario ejecutar(Operario op){
    double aumento = 0;
    if(op.sueldo < 500){
      if(op.antiguedad >= 10){
        aumento = op.sueldo * 0.20;
      } else {
        aumento = op.sueldo * 0.05;
      }
    }
    
    final sueldoFinal = op.sueldo + aumento;

    return ResultadoOperario(aumento: aumento, sueldoFinal: sueldoFinal);
  }
}
