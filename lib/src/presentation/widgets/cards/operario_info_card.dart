import 'package:flutter/material.dart';
import '../../../domain/entities/operario.dart';

class OperarioInfoCard extends StatelessWidget {
  final Operario operario;

  const OperarioInfoCard({
    super.key,
    required this.operario,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            _buildAvatar(),
            const SizedBox(width: 16),
            _buildInfo(),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    final inicial = operario.nombre.isNotEmpty
        ? operario.nombre[0].toUpperCase()
        : '?';

    return CircleAvatar(
      child: Text(inicial),
    );
  }

  Widget _buildInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          operario.nombre,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'Antigüedad: ${operario.antiguedad} años',
          style: TextStyle(color: Colors.grey[600]),
        ),
      ],
    );
  }
}