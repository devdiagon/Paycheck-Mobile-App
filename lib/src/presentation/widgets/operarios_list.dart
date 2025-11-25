import 'package:flutter/material.dart';
import 'operario_list_tile.dart';
import '../../domain/entities/operario.dart';

class OperariosList extends StatelessWidget {
  final List<Operario> operarios;

  const OperariosList({super.key, required this.operarios});

  @override
  Widget build(BuildContext context) {
    if (operarios.isEmpty) {
      return const Center(child: Text('No hay operarios aún'));
    }

    return ListView.builder(
      itemCount: operarios.length,
      itemBuilder: (context, index) {
        final op = operarios[index];
        return OperarioListTile(operario: op);
      },
    );
  }
}
