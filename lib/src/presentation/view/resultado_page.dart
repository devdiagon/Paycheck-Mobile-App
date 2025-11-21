import 'package:flutter/material.dart';
import 'package:modelview/src/domain/entities/resultado_operario.dart';

class ResultadoPage extends StatelessWidget {
  ResultadoOperario resultado;
  ResultadoPage({super.key,required this.resultado});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultado del Cálculo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Tarjeta para el Aumento
            Card(
              elevation: 4,
              margin: const EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.trending_up, color: Colors.green),
                        SizedBox(width: 8),
                        Text(
                          'Aumento Calculado',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '\$${resultado.aumento.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Incremento aplicado',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Tarjeta para el Sueldo Final
            Card(
              elevation: 4,
              margin: const EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.attach_money, color: Colors.blue),
                        SizedBox(width: 8),
                        Text(
                          'Sueldo Final',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '\$${resultado.sueldoFinal.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Total a recibir',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Espacio adicional y botón opcional
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Volver'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
