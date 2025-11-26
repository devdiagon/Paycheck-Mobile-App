import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'src/themes/general_theme.dart';
import 'src/presentation/viewmodels/reporte_viewmodel.dart';
import 'src/presentation/viewmodels/operario_viewmodel.dart';
import 'src/domain/usecases/calcular_aumento.dart';
import 'src/domain/usecases/generar_pdf.dart';
import 'src/presentation/routes/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => OperarioViewModel(CalcularAumento()),
        ),
        
        ChangeNotifierProvider(
            create: (context) => ReporteViewModel(GenerarPdf()),
        ),
      ],

      child: MaterialApp(
        title: 'Aumento Operario',
        debugShowCheckedModeBanner: false,
        theme: getGeneralTheme(Brightness.light),
        initialRoute: AppRoutes.home,
        routes: AppRoutes.routes,
      ),
    );
  }
}