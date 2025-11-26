import 'package:flutter/material.dart';
import '../../../domain/entities/resultado_operario.dart';

class AumentoCard extends StatelessWidget {
  final ResultadoOperario resultado;

  const AumentoCard({
    super.key,
    required this.resultado,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            _buildHeader(),
            const SizedBox(height: 12),
            _buildAumentoAmount(),
            const SizedBox(height: 8),
            _buildPorcentaje(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return const Row(
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
    );
  }

  Widget _buildAumentoAmount() {
    return Text(
      '\$${resultado.aumento.toStringAsFixed(2)}',
      style: const TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.green,
      ),
    );
  }

  Widget _buildPorcentaje() {
    return Text(
      '${resultado.porcentaje.toStringAsFixed(1)}% de aumento',
      style: TextStyle(
        fontSize: 14,
        color: Colors.grey[600],
      ),
    );
  }
}