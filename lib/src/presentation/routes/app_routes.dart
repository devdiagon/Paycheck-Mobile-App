import 'package:flutter/material.dart';
import '../view/home_page.dart';
import '../view/resultado_page.dart';

class AppRoutes {
  static const home = '/';
  static const resultado = '/resultado';

  static Map<String, WidgetBuilder> routes = {
    home: (_) => const HomePage(),
    resultado: (context) {
      // Recibir el ID y obtener el operario desde el ViewModel
      final operarioId = ModalRoute.of(context)!.settings.arguments as String;
      return ResultadoPage(operarioId: operarioId);
    }
  };
}