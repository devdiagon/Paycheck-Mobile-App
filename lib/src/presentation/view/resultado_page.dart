import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/operario_viewmodel.dart';
import '../widgets/cards/aumento_card.dart';
import '../widgets/cards/operario_info_card.dart';
import '../widgets/cards/sueldo_final_card.dart';

class ResultadoPage extends StatelessWidget {
  final String operarioId;

  const ResultadoPage({super.key, required this.operarioId});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<OperarioViewModel>(context);
    final operario = vm.getById(operarioId);

    // Si no encuentra el operario, mostrar error
    if (operario == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(child: Text('Operario no encontrado')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultado del Cálculo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Información del operario
            OperarioInfoCard(operario: operario),
            const SizedBox(height: 16),
            // Tarjeta para el Aumento
            AumentoCard(resultado: operario.result),
            const SizedBox(height: 16),
            // Tarjeta para el Sueldo Final
            SueldoFinalCard(resultado: operario.result),
          ],
        ),
      ),
    );
  }
}