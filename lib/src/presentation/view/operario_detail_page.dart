// EN operario_detail_page.dart - ACTUALIZADO:
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/operario_viewmodel.dart';
import '../../domain/entities/operario.dart';
import '../../domain/entities/aumento_record.dart'; // Agregar este import

class OperarioDetailPage extends StatefulWidget {
  final String operarioId;
  const OperarioDetailPage({super.key, required this.operarioId});

  @override
  State<OperarioDetailPage> createState() => _OperarioDetailPageState();
}

class _OperarioDetailPageState extends State<OperarioDetailPage> {
  final TextEditingController _nuevoSueldoController = TextEditingController();
  final TextEditingController _nuevaAntigController = TextEditingController();

  String _formatFecha(DateTime dt) {
    final two = (int n) => n.toString().padLeft(2, '0');
    return '${two(dt.day)}/${two(dt.month)}/${dt.year} ${two(dt.hour)}:${two(dt.minute)}';
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<OperarioViewModel>(context);
    final operario = vm.getById(widget.operarioId);

    if (operario == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Operario')),
        body: const Center(child: Text('Operario no encontrado')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('Detalle — ${operario.nombre}')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Información del operario
            Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  child: Text(
                      operario.nombre.isNotEmpty ? operario.nombre[0].toUpperCase() : '?'),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      operario.nombre,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text('Sueldo actual: \$${operario.sueldo.toStringAsFixed(2)}'),
                    Text('Antigüedad: ${operario.antiguedad} años'),
                  ],
                )
              ],
            ),

            const SizedBox(height: 20),

            /// Botón para aumento automático
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  final resultado = vm.aplicarAumentoCalculado(operario.id);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Aumento aplicado: \$${resultado.aumento.toStringAsFixed(2)}'),
                    ),
                  );
                },
                child: const Text('Aplicar Aumento Automático'),
              ),
            ),

            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 20),

            /// Registro de aumento manual
            const Text(
              'Registrar aumento manual',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            TextField(
              controller: _nuevoSueldoController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Nuevo sueldo',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),

            TextField(
              controller: _nuevaAntigController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Nueva antigüedad (años)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final nuevoSueldo =
                  double.tryParse(_nuevoSueldoController.text.trim());
                  final nuevaAntig =
                  int.tryParse(_nuevaAntigController.text.trim());

                  if (nuevoSueldo == null || nuevaAntig == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Valores inválidos')),
                    );
                    return;
                  }

                  final record = vm.registrarAumento(
                    operario.id,
                    nuevoSueldo: nuevoSueldo,
                    nuevaAntiguedad: nuevaAntig,
                  );

                  _nuevoSueldoController.clear();
                  _nuevaAntigController.clear();

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Aumento registrado: \$${record.aumento.toStringAsFixed(2)}'),
                    ),
                  );
                },
                child: const Text('Guardar aumento manual'),
              ),
            ),

            const SizedBox(height: 20),

            /// Historial
            const Text(
              'Historial de aumentos',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            Expanded(
              child: operario.historial.isEmpty
                  ? const Center(child: Text('No hay registros'))
                  : ListView.builder(
                itemCount: operario.historial.length,
                itemBuilder: (context, index) {
                  final rec = operario.historial[
                  operario.historial.length - 1 - index];

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      title: Text(
                        '\$${rec.salarioAnterior.toStringAsFixed(2)} → \$${rec.salarioNuevo.toStringAsFixed(2)}',
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Aumento: \$${rec.aumento.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: rec.aumento > 0 ? Colors.green : Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${_formatFecha(rec.fecha)}',
                          ),
                          Text(
                            'Antigüedad: ${rec.antiguedadAnterior} → ${rec.antiguedadNueva} años',
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}