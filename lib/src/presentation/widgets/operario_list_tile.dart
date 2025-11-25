import 'package:flutter/material.dart';
import '../../domain/entities/operario.dart';
import '../routes/app_routes.dart';

class OperarioListTile extends StatelessWidget {
  final Operario operario;

  const OperarioListTile({super.key, required this.operario});

  @override
  Widget build(BuildContext context) {
    final inicial = operario.nombre.isNotEmpty
        ? operario.nombre[0].toUpperCase()
        : '?';

    return ListTile(
      leading: CircleAvatar(child: Text(inicial)),
      title: Text(operario.nombre),
      subtitle: Text(
        'Sueldo: \$${operario.sueldo.toStringAsFixed(2)} • '
            'Antigüedad: ${operario.antiguedad} años',
      ),
      onTap: () => Navigator.pushNamed(
        context,
        AppRoutes.resultado,
        arguments: operario.id,
      ),
    );
  }
}
