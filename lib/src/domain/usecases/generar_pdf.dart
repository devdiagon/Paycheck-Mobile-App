import 'dart:io';
import 'package:pdf/widgets.dart' as pw;
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../entities/reporte.dart';

class GenerarPdf {
  Future<String> call(Reporte data) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (context) => pw.Center(
          child: pw.Text(data.title),
        ),
      ),
    );

    final filePath = await _savePdf(pdf, 'reporte_operarios.pdf');

    await _openPdf(filePath);

    return filePath;
  }

  /// Guarda el PDF en la ubicación apropiada según el dispositivo
  Future<String> _savePdf(pw.Document pdf, String fileName) async {
    final bytes = await pdf.save();

    if (Platform.isAndroid) {
      // Para Android 10+ (API 29+) y emuladores
      return await _saveOnAndroid(bytes, fileName);
    } else if (Platform.isIOS) {
      return await _saveOnIOS(bytes, fileName);
    } else {
      // Fallback para otras plataformas
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/$fileName');
      await file.writeAsBytes(bytes);
      return file.path;
    }
  }

  /// Guarda el PDF en Android (funciona en dispositivos reales y emuladores)
  Future<String> _saveOnAndroid(List<int> bytes, String fileName) async {
    Directory? directory;

    // Primero intentar obtener el directorio de descargas
    if (await _requestStoragePermission()) {
      // Para Android 10+ usar getExternalStorageDirectory
      directory = await getExternalStorageDirectory();

      if (directory != null) {
        // Crear carpeta "Downloads" en el almacenamiento externo
        final downloadPath = Directory('${directory.path}/Download');
        if (!await downloadPath.exists()) {
          await downloadPath.create(recursive: true);
        }
        directory = downloadPath;
      }
    }

    // Si no se pudo acceder al almacenamiento externo, usar directorio de la app
    directory ??= await getApplicationDocumentsDirectory();

    final file = File('${directory.path}/$fileName');
    await file.writeAsBytes(bytes);

    print('PDF guardado en: ${file.path}');
    return file.path;
  }

  /// Guarda el PDF en iOS
  Future<String> _saveOnIOS(List<int> bytes, String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$fileName');
    await file.writeAsBytes(bytes);
    return file.path;
  }

  /// Solicita permisos de almacenamiento (necesario para Android)
  Future<bool> _requestStoragePermission() async {
    if (Platform.isAndroid) {
      // Android 13+ (API 33+) no requiere permisos de almacenamiento
      if (await Permission.storage.isGranted) {
        return true;
      }

      final status = await Permission.storage.request();
      return status.isGranted;
    }
    return true;
  }

  /// Abre el PDF automáticamente con la aplicación predeterminada
  Future<void> _openPdf(String filePath) async {
    try {
      final result = await OpenFile.open(filePath);
      if (result.type != ResultType.done) {
        print('Error al abrir PDF: ${result.message}');
      }
    } catch (e) {
      print('No se pudo abrir el PDF: $e');
    }
  }
}