import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../domain/entities/resultado_operario.dart';

class SueldoFinalCard extends StatelessWidget {
  final ResultadoOperario resultado;

  const SueldoFinalCard({
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
            _buildSueldoAmount(),
            const SizedBox(height: 8),
            _buildFooterInfo(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return const Row(
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
    );
  }

  Widget _buildSueldoAmount() {
    return Text(
      '\$${resultado.sueldoFinal.toStringAsFixed(2)}',
      style: const TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.blue,
      ),
    );
  }

  Widget _buildFooterInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Salario anterior: \$${resultado.salarioAnterior.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        Text(
          'Fecha: ${_formatearFecha(resultado.fecha)}',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[500],
          ),
        ),
      ],
    );
  }

  String _formatearFecha(DateTime fecha) {
    final formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(fecha);
  }
}