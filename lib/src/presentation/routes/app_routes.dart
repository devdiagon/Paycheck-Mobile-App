import 'package:flutter/material.dart';
import '../view/home_page.dart';
import '../view/resultado_page.dart';
import '../view/operario_detail_page.dart';
import '../../domain/entities/resultado_operario.dart';


class AppRoutes {
  static const home = '/';
  static const resultado = '/resultado';
  static const operarioDetail = '/operario';


  static Map<String,WidgetBuilder> routes = {
    home: (_) => HomePage(),
    resultado: (context) {
      final resultado = ModalRoute.of(context)!.settings.arguments as ResultadoOperario;
      return ResultadoPage(resultado: resultado);
    },
    operarioDetail: (context) {
// Espera recibir como argumento el id del operario (String)
      final id = ModalRoute.of(context)!.settings.arguments as String;
      return OperarioDetailPage(operarioId: id);
    }
  };
}