import 'package:flutter/material.dart';
import 'package:modelview/src/domain/entities/operario.dart';
import 'package:modelview/src/domain/entities/resultado_operario.dart';
import 'package:modelview/src/domain/usecases/calcular_aumento.dart';
import 'package:modelview/src/presentation/widgets/error_mesage.dart';
import 'package:provider/provider.dart';

import '../viewmodels/operario_viewmodel.dart';
import '../routes/app_routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _sueldoController = TextEditingController();
  int? _selectedYear = 1;
  String _errMsg = "";

  void _calcular() {
    setState(() {
      _errMsg = "";
    });
    final sueldo = double.tryParse(_sueldoController.text);

    if (sueldo == null) {
      setState(() {
        _errMsg = "Ingrese solo números válidos";
      });
      return;
    }

    final operario = Operario(
      sueldo: sueldo!,
      antiguedad: _selectedYear!,
    );

    final calculadora = CalcularAumento();
    final ResultadoOperario resultado = calculadora.ejecutar(operario);

    Navigator.pushNamed(context, AppRoutes.resultado, arguments: resultado,);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de Sueldo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Campo para ingresar el sueldo
            TextField(
              controller: _sueldoController,
              decoration: const InputDecoration(
                labelText: 'Ingresa el valor del sueldo',
                hintText: 'Ej: 1500.00',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.attach_money),
              ),
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 24),

            ErrorMessage(errorText: _errMsg,),

            // Título para los radio buttons
            const Text(
              'Selecciona el número de años:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            // Radio buttons para los años (1-10)
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  final year = index + 1;
                  return RadioListTile<int>(
                    title: Text('$year año${year > 1 ? 's' : ''}'),
                    value: year,
                    groupValue: _selectedYear,
                    onChanged: (value) {
                      setState(() {
                        _selectedYear = value;
                      });
                    },
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            // Botón para calcular
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _calcular,

                child: const Text('Calcular'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
