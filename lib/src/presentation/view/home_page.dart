import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/reporte_viewmodel.dart';
import '../viewmodels/operario_viewmodel.dart';
import '../routes/app_routes.dart';
import '../widgets/operarios_list.dart';
import '../widgets/report_fab.dart';
import '../widgets/operario_form.dart';

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
    setState(() => _errMsg = "");

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

    final vmOp = Provider.of<OperarioViewModel>(context, listen: false);
    final op = vmOp.crearOperario(
        nombre: nombre,
        sueldo: sueldo,
        antiguedad: _selectedYear
    );

    _limpiarFormulario();

    // CORRECTO: Pasar el ID del operario
    Navigator.pushNamed(context, AppRoutes.resultado, arguments: op.id);
  }

  void _limpiarFormulario() {
    _nombreController.clear();
    _sueldoController.clear();
    _errMsg = "";
    setState(() {
      _selectedYear = 1;
      _errMsg = "";
    });
  }

  Future<void> _generarReporte(BuildContext context, ReporteViewModel vmPdf) async {
    await vmPdf.generateReport();
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("PDF generado")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final vmOp = Provider.of<OperarioViewModel>(context);
    final vmPdf = context.watch<ReporteViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('Gestión de Operarios')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Formulario crear operario
            OperarioForm(
              nombreController: _nombreController,
              sueldoController: _sueldoController,
              selectedYear: _selectedYear,
              errorMsg: _errMsg,
              onYearChanged: (value) => setState(() => _selectedYear = value),
              onCrearOperario: () => _crearOperario(context),
            ),
            const SizedBox(height: 16),

            Center(
              child: SwitchListTile(
                title: const Text("Activar botón de reporte"),
                value: vmPdf.canGenerateReport,
                onChanged: vmPdf.updateCanGenerate,
              ),
            ),

            const Divider(),
            const SizedBox(height: 8),
            const Text('Operarios disponibles', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),

            // Lista de operarios
            Expanded(
              child: OperariosList(operarios: vmOp.operarios),
            ),
          ],
        ),
      ),
      floatingActionButton: ReportFab(
        enabled: vmPdf.canGenerateReport,
        onPressed: () => _generarReporte(context, vmPdf),
      ),
    );
  }
}