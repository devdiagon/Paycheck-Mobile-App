import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/operario_viewmodel.dart';
import '../routes/app_routes.dart';
import '../widgets/error_mesage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _sueldoController = TextEditingController();
  int _selectedYear = 1;
  String _errMsg = "";

  void _crearOperario(BuildContext context) {
    setState(() {
      _errMsg = "";
    });

    final nombre = _nombreController.text.trim();
    final sueldo = double.tryParse(_sueldoController.text);

    if (nombre.isEmpty) {
      setState(() => _errMsg = 'Ingrese el nombre del operario');
      return;
    }
    if (sueldo == null || sueldo <= 0){
      setState(() => _errMsg = 'Ingrese un sueldo válido');
      return;
    }

    final vm = Provider.of<OperarioViewModel>(context, listen: false);
    final op = vm.crearOperario(
        nombre: nombre,
        sueldo: sueldo,
        antiguedad: _selectedYear
    );

    // Limpiar formulario
    _nombreController.clear();
    _sueldoController.clear();
    _errMsg = "";
    setState(() { _selectedYear = 1; });


    // CORRECTO: Pasar el ID del operario
    Navigator.pushNamed(context, AppRoutes.resultado, arguments: op.id);
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<OperarioViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Gestión de Operarios')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Formulario crear operario
            TextField(
              controller: _nombreController,
              decoration: const InputDecoration(labelText: 'Nombre del operario', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 8),

            TextField(
              controller: _sueldoController,
              decoration: const InputDecoration(labelText: 'Sueldo inicial', border: OutlineInputBorder(), prefixIcon: Icon(Icons.attach_money)),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 8),
            ErrorMessage(errorText: _errMsg,),
            const SizedBox(height: 8),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Antigüedad (años): $_selectedYear',
                  style: const TextStyle(fontSize: 16),
                ),
                Slider(
                  value: _selectedYear.toDouble(),
                  min: 1,
                  max: 10,
                  divisions: 9,
                  label: '$_selectedYear',
                  onChanged: (value) {
                    setState(() {
                      _selectedYear = value.toInt();
                    });
                  },
                ),
              ],
            ),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: () => _crearOperario(context), child: const Text('Crear operario')),
            ),

            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 8),
            const Text('Operarios disponibles', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),

            // Lista de operarios
            Expanded(
              child: vm.operarios.isEmpty
                  ? const Center(child: Text('No hay operarios aún'))
                  : ListView.builder(
                itemCount: vm.operarios.length,
                itemBuilder: (context, index) {
                  final op = vm.operarios[index];
                  final inicial = (op.nombre.isNotEmpty) ? op.nombre[0].toUpperCase() : '?';
                  return ListTile(
                    leading: CircleAvatar(child: Text(inicial)),
                    title: Text(op.nombre),
                    subtitle: Text('Sueldo: \$${op.sueldo.toStringAsFixed(2)} • Antigüedad: ${op.antiguedad} años'),
                    onTap: () => Navigator.pushNamed(context, AppRoutes.resultado, arguments: op.id),
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