import 'dart:io';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/foundation.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class PdfSaver {
  Future<String> savePdf(pw.Document pdf, String fileName) async {
    final bytes = await pdf.save();

    if (Platform.isAndroid) {
      return await _saveOnAndroid(bytes, fileName);
    } else if (Platform.isIOS) {
      return await _saveOnIOS(bytes, fileName);
    } else {
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/$fileName');
      await file.writeAsBytes(bytes);
      return file.path;
    }
  }

  Future<String> _saveOnAndroid(List<int> bytes, String fileName) async {
    Directory? directory;

    if (await _requestStoragePermission()) {
      directory = await getExternalStorageDirectory();

      if (directory != null) {
        final downloadPath = Directory('${directory.path}/Download');
        if (!await downloadPath.exists()) {
          await downloadPath.create(recursive: true);
        }
        directory = downloadPath;
      }
    }

    directory ??= await getApplicationDocumentsDirectory();

    final file = File('${directory.path}/$fileName');
    await file.writeAsBytes(bytes);

    return file.path;
  }

  Future<String> _saveOnIOS(List<int> bytes, String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$fileName');
    await file.writeAsBytes(bytes);
    return file.path;
  }

  Future<bool> _requestStoragePermission() async {
    if (Platform.isAndroid) {
      if (await Permission.storage.isGranted) {
        return true;
      }

      final status = await Permission.storage.request();
      return status.isGranted;
    }
    return true;
  }

  Future<void> openPdf(String filePath) async {
    try {
      final result = await OpenFile.open(filePath);
      if (result.type != ResultType.done) {
        debugPrint('Error al abrir PDF: ${result.message}');
      }
    } catch (e) {
      debugPrint('No se pudo abrir el PDF: $e');
    }
  }
}